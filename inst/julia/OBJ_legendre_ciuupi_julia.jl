try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end


include("IOBJ_ciuupi_julia.jl")
include("GL_modified_nodes_weights_julia.jl")

function OBJ_legendre_ciuupi_julia(sc_knots_vec::Vector{Float64}, lambda::Float64, t_vec::Vector{Float64}, d::Float64, alpha::Float64, no_nodes_GL::Float64)

    # GL_modified_nodes_weights_julia(lower, upper, number_of_nodes)
    GL_modified = GL_modified_nodes_weights_julia(convert(Float64, 0), d, no_nodes_GL)

    iobj = 0.0

    no_nodes_GL_int = convert(Integer, no_nodes_GL)

    for i in 1:no_nodes_GL_int
        x_i = GL_modified["nodes"][i]
        w_i = GL_modified["weights"][i]

        # IOBJ_ciuupi_julia(h, sc_knots_vec, lambda, t_vec, d, alpha)
        iobj_val = IOBJ_ciuupi_julia(x_i, sc_knots_vec, lambda, t_vec, d, alpha)

        iobj += w_i * iobj_val
    end

    return iobj
end
