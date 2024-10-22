try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

include("sinc_fn_julia.jl")
include("b_fn_julia.jl")
include("s_fn_julia.jl")
include("Psi_julia.jl")

function k_fn_julia(x::Float64, bsc_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, rho::Float64, gamma_param::Float64, alpha::Float64)

    n_ints = length(t_vec)

    # b_fn(t, b_knots_vec, t_vec, d)
    b_x = b_fn_julia(x, bsc_vec[1:(n_ints - 1)], t_vec, d)

    # s_fn(t, sc_knots_vec, t_vec, alpha, d)
    s_x = s_fn_julia(x, bsc_vec[n_ints:end], t_vec, alpha, d)

    mu = rho * (x - gamma_param)
    variance = 1 - rho^2

    # Psi(x, y, mu, variance)
    term1 = (b_x - s_x)
    term2 = (b_x + s_x)

    return Psi_julia(term1, term2, mu, variance)

end
