@testset verbose = true "get database" begin
    @testset "default database file" begin
        db = TrackingAPI.get_database()

        @test db isa SQLite.DB
        @test db.file == "trackingapi.db"

        "trackingapi.db" |> rm
        TrackingAPI.get_database |> memoize_cache |> empty!
    end

    ENV["TRACKINGAPI_DB_FILE"] = "trackingapi_test.db"

    @testset "custom database file" begin
        db = TrackingAPI.get_database()

        @test db isa SQLite.DB
        @test db.file == "trackingapi_test.db"
    end

    @testset "check memoization" begin
        db1 = TrackingAPI.get_database()
        db2 = TrackingAPI.get_database()

        @test db1 === db2
    end

    @testset "initialize database" begin
        TrackingAPI.initialize_database()

        rows = DBInterface.execute(TrackingAPI.get_database(),
            "SELECT name FROM sqlite_schema WHERE type='table' ORDER BY name")

        for row in rows
            @test row isa SQLite.Row
            @test keys(row) == [:name]
            @test values(row) in [["user"], ["project"], ["user_project"]]
        end
    end

    "trackingapi_test.db" |> rm
    TrackingAPI.get_database |> memoize_cache |> empty!
    delete!(ENV, "TRACKINGAPI_DB_FILE")
end
