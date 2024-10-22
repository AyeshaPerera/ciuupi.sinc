try
    using FastGaussQuadrature
catch
    using Pkg
    Pkg.add("FastGaussQuadrature")
    using FastGaussQuadrature
end

function GL_modified_nodes_weights_julia(lower::Float64, upper::Float64, number_of_nodes::Float64)

if upper <= lower
throw(ArgumentError("upper is less than or equal to lower"))
end

number_of_nodes_int = convert(Integer, number_of_nodes)
GL_nodes, GL_weights = gausslegendre(number_of_nodes_int)
middle = (lower + upper) / 2.0
half_width = (upper - lower) / 2.0

GL_modified_nodes = middle .+ half_width * GL_nodes
GL_modified_weights = half_width * GL_weights

GL_nodes_weights = Dict("nodes" => GL_modified_nodes, "weights" => GL_modified_weights)

return GL_nodes_weights
end
