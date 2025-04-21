"""
    get_user_by_username(username::String)::Union{User, Nothing}

Get an [`User`](@ref) by username.

# Arguments
- `username::String`: The username of the user to query.

# Returns
An [`User`](@ref) object. If the record does not exist, return `nothing`.
"""
get_user_by_username(username::String)::Union{User,Nothing} = fetch(User, username)

"""
    get_users()::Array{User, 1}

Get all [`User`](@ref).

# Returns
An array of [`User`](@ref) objects.
"""
get_users()::Array{User,1} = User |> fetch_all

"""
    create_user(user_payload::UserCreatePayload)::UpsertResult

Create an [`User`](@ref).

# Arguments
- `user_payload::UserCreatePayload`: The payload for creating an user.

# Returns
An [`UpsertResult`](@ref). `CREATED` if the record was successfully created, `DUPLICATE` if
the record already exists, `UNPROCESSABLE` if the record violates a constraint, and `ERROR`
if an error occurred while creating the record.
"""
create_user(user_payload::UserCreatePayload)::UpsertResult =
    insert(User, user_payload.first_name, user_payload.last_name, user_payload.username,
        user_payload.password)
