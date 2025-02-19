"""
    User

A struct that represents a user.

# Fields
- `id::Integer`: The ID of the user.
- `first_name::String`: The first name of the user.
- `last_name::String`: The last name of the user.
- `username::String`: The username of the user.
- `created_at::DateTime`: The date and time the user was created.
"""
struct User
    id::Integer
    first_name::String
    last_name::String
    username::String
    created_at::DateTime
end
User(data::Dict{Symbol,Any}) = User(data[:id], data[:first_name], data[:last_name],
    data[:username], (data[:created_at] |> DateTime))
User(data::Dict{String, Any}) = User(data["id"], data["first_name"], data["last_name"],
    data["username"], (data["created_at"] |> DateTime))

"""
    UserPayload

A struct that represents the payload for creating a user.

# Fields
- `first_name::String`: The first name of the user.
- `last_name::String`: The last name of the user.
- `username::String`: The username of the user.
- `password::String`: The password of the user.
"""
struct UserPayload
    first_name::String
    last_name::String
    username::String
    password::String
end
