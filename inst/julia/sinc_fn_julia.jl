function sinc_fn_julia(t::Float64)

    term = π * t

    if(abs(t) < 1e-3)
        out =  1.0 - (term^2)/6.0 + (term^4)/120.0
        return out
    else
        return sin(term)/term
    end
end
