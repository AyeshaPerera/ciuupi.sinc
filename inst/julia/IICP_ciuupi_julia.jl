try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

include("k_fn_julia.jl")
include("k_dag_fn_julia.jl")
function IICP_ciuupi_julia(x::Float64, bsc_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, alpha::Float64, rho::Float64, gamma_param::Float64)

    # k_fn_julia(x, bsc_vec, t_vec, d, rho, gamma_param, alpha, w)
    k1 = k_fn_julia(x, bsc_vec, t_vec, d, rho, gamma_param, alpha)

    # k_dag_fn_julia(x, alpha, w, gamma_param, rho)
    k_dag1 = k_dag_fn_julia(x, alpha, gamma_param, rho)

    term1 = (k1 - k_dag1) * pdf(Normal(0, 1), x - gamma_param)

    # k_fn_julia(x, bsc_vec, t_vec, d, rho, gamma_param, alpha, w)
    k2 = k_fn_julia(-x, bsc_vec, t_vec, d, rho, gamma_param, alpha)

    # k_dag_fn_julia(x, alpha, w, gamma_param, rho)
    k_dag2 = k_dag_fn_julia(-x, alpha, gamma_param, rho)

    term2 = (k2 - k_dag2) * pdf(Normal(0, 1), x + gamma_param)

    return term1 + term2
end
