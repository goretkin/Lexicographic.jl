module Lexicographic

export FixedLengthLex
struct FixedLengthLex{T}
    x::T
end

function Base.isless(a::FixedLengthLex, b::FixedLengthLex)
    if length(a.x) != length(b.x)
        error("Cannot compare different length sequences")
    end
    return isless(a.x, b.x)
end

for f in [:(==), :isequal]
    @eval function Base.$f(a::FixedLengthLex, b::FixedLengthLex)
        return $f(a.x, b.x)
    end
end

for typeminmax in [:typemin, :typemax]
    @eval function Base.$(typeminmax)(::Type{FixedLengthLex{T}}) where T<:Tuple
        return FixedLengthLex($(typeminmax).(tuple(T.parameters...)))
    end

    @eval function Base.$(typeminmax)(v::FixedLengthLex{T}) where T<:Tuple
        return $(typeminmax)(typeof(v))
    end
end

end
