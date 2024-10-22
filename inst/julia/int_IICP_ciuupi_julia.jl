include("GL_modified_nodes_weights_julia.jl")
include("IICP_ciuupi_julia.jl")

function int_IICP_ciuupi_julia(bsc_vec::Vector{Float64}, t_vec::Vector{Float64}, l::Float64, u::Float64, d::Float64, alpha::Float64, rho::Float64, gamma_param::Float64, no_nodes_GL::Float64)

    # GL_modified_nodes_weights_julia(lower, upper, number_of_nodes)
    GL_modified = GL_modified_nodes_weights_julia(l, u, no_nodes_GL)
    icp = 0.0

    no_nodes_GL_int = convert(Integer, no_nodes_GL)

    for i in 1:no_nodes_GL_int
        y_i = GL_modified["nodes"][i]
        w_i = GL_modified["weights"][i]

        # IICP_ciuupi_julia(x, bsc_vec, t_vec, d, alpha, rho, gamma_param)
        iicp_val = IICP_ciuupi_julia(y_i, bsc_vec, t_vec, d, alpha, rho, gamma_param)

        icp += w_i * iicp_val
    end

    return icp
end
