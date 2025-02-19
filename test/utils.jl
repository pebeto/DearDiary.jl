@testset verbose = true "load env file" begin
    file = ".env.trackingapitest"

    @testset "file exists" begin
        open(file, "w") do io
            write(io, "TRACKINGAPI_DB_FILE=trackingapi_test.db")
        end
        file |> TrackingAPI.load_env_file

        @test ENV["TRACKINGAPI_DB_FILE"] == "trackingapi_test.db"

        delete!(ENV, "TRACKINGAPI_DB_FILE")
    end

    @testset "file does not exist" begin
        if (file |> isfile)
            file |> rm
        end
        file |> TrackingAPI.load_env_file

        @test !haskey(ENV, "TRACKINGAPI_DB_FILE")
    end
end
