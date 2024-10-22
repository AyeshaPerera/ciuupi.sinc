try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

include("Psi_julia.jl")

function k_dag_fn_julia(x::Float64, alpha::Float64, gamma_param::Float64, rho::Float64)

    z_val = quantile(Normal(0, 1), 1 - alpha / 2)

    mu = rho * (x - gamma_param)

    variance = 1 - rho^2

    return Psi_julia(-z_val, z_val, mu, variance)
end
