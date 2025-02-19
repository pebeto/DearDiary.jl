"""
    row_to_dict(type::SQLite.Row)::Dict{Symbol, Any}

Convert a SQLite row to a dictionary.
"""
row_to_dict(type::SQLite.Row)::Dict{Symbol,Any} =
    zip((type |> keys), (type |> values)) |> collect |> Dict
