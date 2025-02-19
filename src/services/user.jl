"""
    query_user_by_username(username::String)::Union{User, Nothing}

Query an [`User`](@ref) record by username.

# Arguments
- `username::String`: The username of the user to query.

# Returns
An [`User`](@ref) object.
"""
function get_user_by_username(username::String)::Union{User,Nothing}
    record = query_record(User, username)

    if (record |> isnothing)
        return nothing
    end
    return record |> row_to_dict |> User
end

"""
    create_user(first_name::String, last_name::String, username::String,
        password::String)::UpsertResult

# Arguments
- `first_name::String`: The first name of the user.
- `last_name::String`: The last name of the user.
- `username::String`: The username of the user.
- `password::String`: The password of the user.

# Returns
An [`UpsertResult`](@ref).
"""
create_user(first_name::String, last_name::String, username::String,
    password::String)::UpsertResult =
    insert_record(User, first_name, last_name, username, password)
