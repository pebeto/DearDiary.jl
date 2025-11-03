@testset verbose = true "enums utilities" begin
    @testset verbose = true "convert integer value to status enum" begin
        @test convert(DearDiary.Status, 1) == DearDiary.IN_PROGRESS
        @test convert(DearDiary.Status, 2) == DearDiary.STOPPED
        @test convert(DearDiary.Status, 3) == DearDiary.FINISHED
        @test_throws ArgumentError convert(DearDiary.Status, 4)
    end
end
