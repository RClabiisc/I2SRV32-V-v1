#include "header.h"

void lstm(State *prev_state, float input[], Param *params, State *curr_state)
{
    // Prepare Weight Structures for Gate Weights
    Param_gate w_i,w_f,w_o,w_g;
    Param_gate* wi=&w_i;
    Param_gate* wf=&w_f;
    Param_gate* wo=&w_o;
    Param_gate* wg=&w_g;

    wi->w_x = params->w_ix;
    wf->w_x = params->w_fx;
    wo->w_x = params->w_ox;
    wg->w_x = params->w_gx;

    wi->w_h = params->w_ih;
    wf->w_h = params->w_fh;
    wo->w_h = params->w_oh;
    wg->w_h = params->w_gh;

    wi->bias = params->b_i;
    wf->bias = params->b_f;
    wo->bias = params->b_o;
    wg->bias = params->b_g;
    
    float i_t[HIDDEN_LAYER_SIZE];
    float f_t[HIDDEN_LAYER_SIZE];
    float o_t[HIDDEN_LAYER_SIZE];
    float g_t[HIDDEN_LAYER_SIZE];
    float f_t_o_c_prev[HIDDEN_LAYER_SIZE];
    float i_t_o_g_t[HIDDEN_LAYER_SIZE];
    float tanh_c_t[HIDDEN_LAYER_SIZE];

    float h_t[HIDDEN_LAYER_SIZE];
    float c_t[HIDDEN_LAYER_SIZE];
    // Gate Computations
    gate(input, INPUT_SIZE,*( prev_state->h), HIDDEN_LAYER_SIZE, wi, 1, i_t);   // Input Gate
    gate(input, INPUT_SIZE,*( prev_state->h), HIDDEN_LAYER_SIZE, wf, 1, f_t);   // Forget Gate
    gate(input, INPUT_SIZE,*( prev_state->h), HIDDEN_LAYER_SIZE, wo, 1, o_t);   // Output Gate
    gate(input, INPUT_SIZE,*( prev_state->h), HIDDEN_LAYER_SIZE, wg, 0, g_t);   // G Gate
   
    // Compute c(t) and h(t)
    hadamard_product(f_t, *(prev_state->c), HIDDEN_LAYER_SIZE, f_t_o_c_prev);
    hadamard_product(i_t, g_t,    HIDDEN_LAYER_SIZE, i_t_o_g_t);
    vadd2(f_t_o_c_prev, i_t_o_g_t, HIDDEN_LAYER_SIZE, c_t);   //Cell State c(t)
    tanhyp(c_t, HIDDEN_LAYER_SIZE, tanh_c_t);
    hadamard_product(o_t, tanh_c_t, HIDDEN_LAYER_SIZE, h_t);  

    //Packing Outputs
    curr_state->h = &h_t;
    curr_state->c = &c_t;
}
