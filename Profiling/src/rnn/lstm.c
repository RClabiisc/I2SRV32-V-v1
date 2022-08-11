#include "header.h"

void lstm1(State1 *prev_state, float input[], Param1 *params, State1 *curr_state)
{
    // Prepare Weight Structures for Gate Weights
    Param1_gate w_i,w_f,w_o,w_g;
    Param1_gate* wi=&w_i;
    Param1_gate* wf=&w_f;
    Param1_gate* wo=&w_o;
    Param1_gate* wg=&w_g;

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
    gate1(input,*( prev_state->h),  wi, 1, i_t);   // Input Gate
    gate1(input,*( prev_state->h),  wf, 1, f_t);   // Forget Gate
    gate1(input,*( prev_state->h),  wo, 1, o_t);   // Output Gate
    gate1(input,*( prev_state->h),  wg, 0, g_t);   // G Gate
   
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



///////////////////////////////////////////LAYER2 LSTM ////////////////////////

void lstm2(State2 *prev_state, float input[], Param2 *params, State2 *curr_state)
{
    // Prepare Weight Structures for Gate Weights
    Param2_gate w_i,w_f,w_o,w_g;
    Param2_gate* wi=&w_i;
    Param2_gate* wf=&w_f;
    Param2_gate* wo=&w_o;
    Param2_gate* wg=&w_g;

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
    
    float i_t[LAYER2_SIZE];
    float f_t[LAYER2_SIZE];
    float o_t[LAYER2_SIZE];
    float g_t[LAYER2_SIZE];
    float f_t_o_c_prev[LAYER2_SIZE];
    float i_t_o_g_t[LAYER2_SIZE];
    float tanh_c_t[LAYER2_SIZE];

    float h_t[LAYER2_SIZE];
    float c_t[LAYER2_SIZE];
    // Gate Computations
    gate2(input,*( prev_state->h),  wi, 1, i_t);   // Input Gate
    gate2(input,*( prev_state->h),  wf, 1, f_t);   // Forget Gate
    gate2(input,*( prev_state->h),  wo, 1, o_t);   // Output Gate
    gate2(input,*( prev_state->h),  wg, 0, g_t);   // G Gate
   
    // Compute c(t) and h(t)
    hadamard_product(f_t, *(prev_state->c), LAYER2_SIZE, f_t_o_c_prev);
    hadamard_product(i_t, g_t,    LAYER2_SIZE, i_t_o_g_t);
    vadd2(f_t_o_c_prev, i_t_o_g_t, LAYER2_SIZE, c_t);   //Cell State c(t)
    tanhyp(c_t, LAYER2_SIZE, tanh_c_t);
    hadamard_product(o_t, tanh_c_t, LAYER2_SIZE, h_t);  

    //Packing Outputs
    curr_state->h = &h_t;
    curr_state->c = &c_t;
}
