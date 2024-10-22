try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

include("sinc_fn_julia.jl")

function s_fn_julia(t::Float64, sc_knots_vec::Vector{Float64}, t_vec::Vector{Float64}, alpha::Float64, d::Float64)

    z = quantile(Normal(), 1 - alpha/2)

    n_ints = length(t_vec)
    h = d / (n_ints)

    if abs(t) >= d
        return z
    end

    s_t_vec = zeros(n_ints)
    s_t_vec[1] = sinc_fn_julia(t / (h))

    for j in 2:n_ints
        i = t_vec[j]
        s_t_vec[j] = sinc_fn_julia((t + i) / (h)) + sinc_fn_julia((t - i) / (h))
    end

    s_c = sum(sc_knots_vec .* s_t_vec)
    s_t = z + s_c

    return s_t

end
