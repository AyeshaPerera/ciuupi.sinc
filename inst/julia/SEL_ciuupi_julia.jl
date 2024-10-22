include("int_ISEL_ciuupi_julia.jl")

function SEL_ciuupi_julia(gamma_param::Float64, bsc_list::Vector{Float64}, t_vec::Vector{Float64}, d::Float64, alpha::Float64, rho::Float64, no_nodes_GL::Float64)


    b_s_split = div(length(bsc_list) + 1, 2)
    sc_knots_vec = bsc_list[b_s_split:end]

    z_alpha = quantile(Normal(0, 1), 1 - alpha / 2)

    #int_ISEL_ciuupi_julia(sc.knots.vec, t.vec, l, u, alpha, d, gamma.param, no.nodes.GL)
    integral_value = int_ISEL_ciuupi_julia(sc_knots_vec, t_vec, convert(Float64, 0), d, alpha, d, gamma_param, no_nodes_GL)

    sel_value = 1 + (1 / z_alpha) * integral_value

    return sel_value
end
