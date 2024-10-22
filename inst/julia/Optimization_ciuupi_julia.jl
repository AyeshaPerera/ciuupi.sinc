try
    using Distributions
catch
    using Pkg
    Pkg.add("Distributions")
    using Distributions
end

try
    using RCall
catch
    using Pkg
    Pkg.add("RCall")
    using RCall
end

include("OBJ_ciuupi_julia.jl")
include("constraint_fn_ciuupi_julia.jl")

function Optimization_ciuupi_julia(start_vec::Vector{Float64}, lambda::Float64, t_vec::Vector{Float64}, d::Float64, alpha::Float64, rho::Float64, n_ints::Float64, gamma_vec::Vector{Float64}, no_nodes_GL::Float64, num_ints::Float64, nl_info::Bool)

    n_ints_int = convert(Integer, n_ints)
    c_alpha = quantile(Normal(), 1 - alpha / 2)
    low = vcat(ones(n_ints_int - 1) * -100, ones(n_ints_int) * (0.5-c_alpha))
    up = vcat(ones(n_ints_int - 1) * 100, ones(n_ints_int) * (200-c_alpha))


    obj_func(x) = OBJ_ciuupi_julia(x, lambda, t_vec, d, alpha, no_nodes_GL)
    constr_func(x) = constraint_fn_ciuupi_julia(x, t_vec, d, alpha, rho, gamma_vec, no_nodes_GL, num_ints)

    list = Dict("xtol_rel" => 1e-10)

    @rput start_vec
    @rput obj_func
    @rput constr_func
    @rput low
    @rput up
    @rput list
    @rput nl_info
    sl = R"nloptr::slsqp(x0=start_vec, fn=obj_func, hin = constr_func,
                      lower = low,
                      upper = up,
                      control = list,
                      nl.info = nl_info)"

  return sl
 end
