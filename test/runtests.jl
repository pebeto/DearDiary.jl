using HTTP
using JSON
using Test
using Dates
using Compat
using SQLite
using Memoize

using TrackingAPI

TrackingAPI.run(; port=19000)

macro with_trackingapi_test_db(expr)
    quote
        ENV["TRACKINGAPI_DB_FILE"] = "trackingapi_test.db"
        TrackingAPI.initialize_database()

        try
            $(expr |> esc)
        finally
            "trackingapi_test.db" |> rm
            TrackingAPI.get_database |> memoize_cache |> empty!
            delete!(ENV, "TRACKINGAPI_DB_FILE")
        end
    end
end

include("utils.jl")

include("repositories/database.jl")
include("repositories/user.jl")
include("repositories/utils.jl")

include("services/user.jl")

include("routes/utils.jl")
include("routes/health.jl")
include("routes/user.jl")

TrackingAPI.stop()
