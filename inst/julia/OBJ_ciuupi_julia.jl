include("OBJ_legendre_ciuupi_julia.jl")

function OBJ_ciuupi_julia(b_s_vec::Vector{Float64}, lambda::Float64, t_vec::Vector{Float64}, d::Float64, alpha::Float64, no_nodes_GL::Float64)

    b_s_split = div(length(b_s_vec) + 1, 2)
    sc_knots_vec = b_s_vec[b_s_split:end]

    return OBJ_legendre_ciuupi_julia(sc_knots_vec, lambda, t_vec, d, alpha, no_nodes_GL)
end
