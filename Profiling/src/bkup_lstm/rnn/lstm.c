#include "header.h"

State* lstm(State *prev_state, Vec *input, Param *params)
{
    Vec      *i_t,  *f_t,  *o_t,  *g_t;
    Matrix2D *w_ix, *w_fx, *w_ox, *w_gx;
    Matrix2D *w_ih, *w_fh, *w_oh, *w_gh;
    Vec      *b_i,  *b_f,  *b_o,  *b_g;
    Vec      *h_prev,*c_prev;
    Vec      *c_t   ,*h_t;
    
    State *curr_state=(State *)malloc(sizeof(State) + 2*sizeof(Vec));

    Vec *f_t_o_c_prev,*i_t_o_g_t,*tanh_c_t;
    //Unpacking Inputs
    //1. Unpacking States
    h_prev = prev_state->h;
    c_prev = prev_state->c;
    //2. Unpacking Parameters
    w_ix = params->w_ix;
    w_fx = params->w_fx;
    w_ox = params->w_ox;
    w_gx = params->w_gx;

    w_ih = params->w_ih;
    w_fh = params->w_fh;
    w_oh = params->w_oh;
    w_gh = params->w_gh;

    b_i  = params->b_i;
    b_f  = params->b_f;
    b_o  = params->b_o;
    b_g  = params->b_g;


    // Gate Computations
    i_t = gate(input,h_prev,w_ix,w_ih,b_i,1);   // Input Gate
    f_t = gate(input,h_prev,w_fx,w_fh,b_f,1);   // Forget Gate
    o_t = gate(input,h_prev,w_ox,w_oh,b_o,1);   // Output Gate
    g_t = gate(input,h_prev,w_gx,w_gh,b_g,0);   // G Gate
   
    // Compute c(t) and h(t)
    f_t_o_c_prev = hadamard_product(f_t,c_prev);
    i_t_o_g_t = hadamard_product(i_t,g_t);
    c_t = vadd2(f_t_o_c_prev,i_t_o_g_t);   //Cell State c(t)
    tanh_c_t = tanhyp(c_t);
    h_t = hadamard_product(o_t,tanh_c_t);  

    //Packing Outputs
    curr_state->h = h_t;
    curr_state->c = c_t;

    // Free all Non returnable mallocs
    free(i_t);
    free(f_t);
    free(o_t);
    free(g_t);
    free(f_t_o_c_prev);
    free(i_t_o_g_t);
    free(tanh_c_t);

    return curr_state;
}
