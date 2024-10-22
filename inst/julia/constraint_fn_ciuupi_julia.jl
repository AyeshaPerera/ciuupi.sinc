include("CP_ciuupi_julia.jl")
include("s_fn_julia.jl")

function constraint_fn_ciuupi_julia(b_s_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, alpha::Float64, rho::Float64, gamma_vec::Vector{Float64}, no_nodes_GL::Float64, num_ints::Float64)

    h_vec = Float64[]

    cp_vec = [CP_ciuupi_julia(b_s_vec, t_vec, d, alpha, rho, g, no_nodes_GL) for g in gamma_vec]

    # cp[i] - (1 - alpha) >= 0
    cp_minus_vec = cp_vec .- (1 - alpha)
    h_vec = vcat(h_vec, cp_minus_vec)

    step_len = d / num_ints
    t_vals = 0:step_len:(d - step_len)

    b_s_split = div(length(b_s_vec) + 1, 2)
    sc_knots_vec = b_s_vec[b_s_split:end]

    s_vec = [s_fn_julia(t, sc_knots_vec, t_vec, alpha, d) for t in t_vals]

    # s_vec[i] - epsilon >= 0
    epsilon = 1.0e-1
    h_s_vec = s_vec .- epsilon
    #h_vec = vcat(h_vec, h_s_vec)

    return h_vec
end
