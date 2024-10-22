include("sinc_fn_julia.jl")
function b_fn_julia(t::Float64, b_knots_vec::Vector{Float64}, t_vec::Vector{Float64}, d::Float64)

    n_ints = (length(t_vec))
    h = d / (length(t_vec))

    if abs(t) >= d
        return 0.0
    end

    b_t_vec = zeros(length(b_knots_vec))

    for j in 2:length(t_vec)
        i = t_vec[j]
        b_t_vec[j-1] = sinc_fn_julia((t - i)  / (h)) - sinc_fn_julia((t + i) / (h))
    end
    
    return sum(b_knots_vec .* b_t_vec)
end
