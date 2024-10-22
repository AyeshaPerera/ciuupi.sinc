try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end


include("s_fn_julia.jl")

function ISEL_ciuupi_julia(x::Float64, sc_knots_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, alpha::Float64, gamma_param::Float64)


    z_alpha = quantile(Normal(0, 1), 1 - alpha / 2)

    s_x = s_fn_julia(x, sc_knots_vec, t_vec, alpha, d)

    temp1 = s_x - z_alpha

    temp2 = pdf(Normal(0, 1), x - gamma_param) + pdf(Normal(0, 1), x + gamma_param)

    return temp1 * temp2
end

