@with_trackingapi_test_db begin
    @testset verbose = true "create user" begin
        payload = Dict("first_name" => "Missy", "last_name" => "Gala",
            "username" => "missy", "password" => "gala") |> JSON.json
        response = HTTP.post("http://127.0.0.1:19000/user"; body=payload)

        @assert response.status == HTTP.StatusCodes.CREATED
        data = response.body |> String |> JSON.parse
        @assert data["message"] == "CREATED"
    end

    @testset verbose = true "get user by username" begin
        response = HTTP.get("http://127.0.0.1:19000/user/missy")

        @assert response.status == HTTP.StatusCodes.OK
        data = response.body |> String |> JSON.parse
        user = TrackingAPI.User(data)

        @assert user.id isa Int
        @assert user.first_name == "Missy"
        @assert user.last_name == "Gala"
        @assert user.username == "missy"
        @assert user.created_at isa DateTime
    end
end
