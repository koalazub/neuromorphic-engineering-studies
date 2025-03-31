using Test
using assign_1

@testset "Basic function test" begin
    @test add(1, 3) == 3

    @test_throws ArgumentError add(-1)
end
