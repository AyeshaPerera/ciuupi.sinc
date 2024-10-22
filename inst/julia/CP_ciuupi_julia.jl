include("int_IICP_ciuupi_julia.jl")

function CP_ciuupi_julia(bsc_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, alpha::Float64, rho::Float64, gamma_param::Float64, no_nodes_GL::Float64)

    #int_IICP_ciuupi_julia(bsc_vec, t_vec, l, u, d, alpha, rho, gamma_param, no_nodes_GL)
    coverage_prob = 1 - alpha + int_IICP_ciuupi_julia(bsc_vec, t_vec, convert(Float64, 0), d, d, alpha, rho, gamma_param, no_nodes_GL)
    n_ints = length(t_vec)

    return coverage_prob
end
