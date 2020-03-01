module Lexicographic

export FixedLengthLex, ShortLex

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


# short-lex

struct ShortLex{T}
    x::T
end

function Base.isless(a::ShortLex, b::ShortLex)
    embed(x) = FixedLengthLex{Tuple{Int, Any}}((length(x), x))
    return isless(embed(a.x), embed(b.x))
end

for f in [:(==), :isequal]
    @eval function Base.$f(a::ShortLex, b::ShortLex)
        return $f(a.x, b.x)
    end
end

# follow Base's lead on typemax(::String) (i.e. no definition)
# Base.typemax(::ShortLex) = error("no such element under short-lex ordering")

Base.typemin(::ShortLex) = ShortLex(())

end
