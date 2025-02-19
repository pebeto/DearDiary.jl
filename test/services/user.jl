@with_trackingapi_test_db begin
    @testset verbose = true "create user" begin
        upsert_result = TrackingAPI.create_user("Missy", "Gala", "missy", "gala")

        @test upsert_result == TrackingAPI.CREATED
    end

    @testset verbose = true "get_user_by_username" begin
        @testset "get user by existing username" begin
            user = TrackingAPI.get_user_by_username("missy")

            @test user isa TrackingAPI.User
            @test user.id isa Int
            @test user.first_name == "Missy"
            @test user.last_name == "Gala"
            @test user.username == "missy"
            @test user.created_at isa DateTime
        end

        @testset "get user by non-existing username" begin
            @test TrackingAPI.get_user_by_username("gala") |> isnothing
        end
    end
end
