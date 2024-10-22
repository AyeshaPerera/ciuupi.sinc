try
    using Optim
catch
    using Pkg
    Pkg.add("Optim")
    using Optim
end

include("SEL_ciuupi_julia.jl")

function sel_min_max_julia(b_s_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, alpha::Float64, rho::Float64, no_nodes_GL::Float64)

    b_s_split = div(length(b_s_vec) + 1, 2)
    sc_knots_vec = b_s_vec[b_s_split:end]

    # SEL_ciuupi_julia(gamma_param, b_s_vec, t_vec, d, alpha, rho, no_nodes_GL)
    result = optimize(gamma_param -> -SEL_ciuupi_julia(gamma_param, b_s_vec, t_vec, d, alpha, rho, no_nodes_GL), 0.0, d, GoldenSection())
    sel_max = -result.minimum
    sel_min = SEL_ciuupi_julia(0.0, b_s_vec, t_vec, d, alpha, rho, no_nodes_GL)

    return Dict("sel_min" => sel_min, "sel_max" => sel_max)
end
