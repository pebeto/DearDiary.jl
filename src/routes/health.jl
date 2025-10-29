function get_health_handler()
    data = Dict(
        "app_name" => TrackingAPI |> nameof |> String,
        "package_version" => TrackingAPI |> pkgversion,
        "server_time" => Dates.now(),
    )
    return json(data; status=HTTP.StatusCodes.OK)
end
