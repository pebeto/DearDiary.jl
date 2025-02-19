@with_trackingapi_test_db begin
    @testset verbose = true "row to dict" begin
        rows = DBInterface.execute(TrackingAPI.get_database(),
            "SELECT name FROM sqlite_schema WHERE type='table' ORDER BY name")
        row_dict = rows |> first |> TrackingAPI.row_to_dict
    
        @test row_dict isa Dict
        @test :name in keys(row_dict)
    end
end
