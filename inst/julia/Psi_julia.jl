try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

function Psi_julia(x::Float64, y::Float64, mu::Float64, variance::Float64)

    sigma = sqrt(variance)
    term1 = cdf(Normal(mu, sigma), y)
    term2 = cdf(Normal(mu, sigma), x)

    return term1 - term2
end
