try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

include("s_fn_julia.jl")

function IOBJ_ciuupi_julia(h::Float64, sc_knots_vec::Vector{Float64}, lambda::Float64, t_vec::Vector{Float64}, d::Float64, alpha::Float64)

    z_alpha = quantile(Normal(0, 1), 1 - alpha / 2)

    s_h = s_fn_julia(h, sc_knots_vec, t_vec, alpha, d)

    term1 = s_h - z_alpha
    term2 = lambda + pdf(Normal(0, 1), h)

    result = term1 * term2

    return result
end
