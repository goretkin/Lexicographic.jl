    using Lexicographic
    using Test
    using Random: shuffle
    @testset "Lexicographic.jl" begin
        @testset "inherit NaN behavior" begin
            nan1 = (NaN, 1)

            @test nan1 != nan1
            @test isequal(nan1, nan1)

            l_nan1 = FixedLengthLex(nan1)
            @test l_nan1 != l_nan1
            @test isequal(l_nan1, l_nan1)
        end

        @test_throws Exception FixedLengthLex((1, 2)) < FixedLengthLex((1, 2, 3))

        for v in [FixedLengthLex((1, 2)), FixedLengthLex((1, 2.0))]
            @test typemin(v) === typemin(typeof(v))
            @test typemax(v) === typemax(typeof(v))

            @test typeof(typemin(v)) === typeof(v)
            @test typeof(typemax(v)) === typeof(v)
            @test typemin(v) <= v
            @test typemax(v) >= v
        end

        @testset "short lex" begin
            @test (1,2,2) < (2,1) # just to show what Base does
            @test [1,2,2] < [2,1] # just to show what Base does
            @test ShortLex((1,2,2)) > ShortLex((2,1))
            @test ShortLex([1,2,2]) > ShortLex([2,1])

            sorted_words = ["zz", "boy", "dog", "jewel", "dogged", "jewelia", "boyfriend"]
            for _ in 1:10
                r = shuffle(sorted_words)
                r_ = map(s->ShortLex(collect(s)), r)
                s_ = sort(r_)
                s = map(e->prod(e.x), s_)
                @test s == sorted_words
            end
        end
    end
