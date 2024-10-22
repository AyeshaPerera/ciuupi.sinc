include("ISEL_ciuupi_julia.jl")
include("GL_modified_nodes_weights_julia.jl")

function int_ISEL_ciuupi_julia(sc_knots_vec::Vector{Float64}, t_vec::Vector{Float64}, l::Float64, u::Float64, alpha::Float64, d::Float64, gamma_param::Float64, no_nodes_GL::Float64)

    GL_modified = GL_modified_nodes_weights_julia(l, u, no_nodes_GL)
    isel = 0.0

    no_nodes_GL_int = convert(Integer, no_nodes_GL)

    for i in 1:no_nodes_GL_int
        y_i = GL_modified["nodes"][i]
        w_i = GL_modified["weights"][i]

        isel_val = ISEL_ciuupi_julia(y_i, sc_knots_vec, t_vec, d, alpha, gamma_param)

        isel += w_i * isel_val
    end

    return isel
end
