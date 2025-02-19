@with_trackingapi_test_db begin
    @testset verbose = true "insert user" begin
        @testset "insert with no existing username" begin
            @test TrackingAPI.insert_record(TrackingAPI.User, "Missy", "Gala", "missy", "gala") == TrackingAPI.CREATED
        end

        @testset "insert with existing username" begin
            @test TrackingAPI.insert_record(TrackingAPI.User, "Missy", "Gala", "missy", "gala") == TrackingAPI.DUPLICATE
        end

        @testset "insert with empty username" begin
            @test TrackingAPI.insert_record(TrackingAPI.User, "Missy", "Gala", "", "gala") == TrackingAPI.UNPROCESSABLE
        end
    end

    @testset verbose = true "query user" begin
        @testset "query with existing username" begin
            user = TrackingAPI.query_record(TrackingAPI.User, "missy")

            @test user isa SQLite.Row
            @test user[:id] isa Int
            @test user[:first_name] == "Missy"
            @test user[:last_name] == "Gala"
            @test user[:username] == "missy"
            @test user[:created_at] |> !isempty
        end

        @testset "query with non-existing username" begin
            @test TrackingAPI.query_record(TrackingAPI.User, "gala") |> isnothing
        end
    end
end
