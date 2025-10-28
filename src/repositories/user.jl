"""
    fetch(::Type{<:User}, username::AbstractString)::Union{User,Nothing}

Fetch a [`User`](@ref) record by username.

# Arguments
- `::Type{<:User}`: The type of the record to query.
- `username::AbstractString`: The username of the user to query.

# Returns
An [`User`](@ref) object. If the record does not exist, return `nothing`.
"""
function fetch(::Type{<:User}, username::AbstractString)::Union{User,Nothing}
    user = fetch(SQL_SELECT_USER_BY_USERNAME, (username=username,))
    return (user |> isnothing) ? nothing : (user |> User)
end

"""
    fetch(::Type{<:User}, id::Integer)::Union{User,Nothing}

Fetch a [`User`](@ref) record by id.

# Arguments
- `::Type{<:User}`: The type of the record to query.
- `id::Integer`: The id of the user to query.

# Returns
An [`User`](@ref) object. If the record does not exist, return `nothing`.
"""
function fetch(::Type{<:User}, id::Integer)::Union{User,Nothing}
    user = fetch(SQL_SELECT_USER_BY_ID, (id=id,))
    return (user |> isnothing) ? nothing : (user |> User)
end

"""
    fetch_all(::Type{<:User})::Array{User,1}

Fetch all [`User`](@ref) records.

# Arguments
- `::Type{<:User}`: The type of the records to fetch.

# Returns
An array of [`User`](@ref) objects.
"""
fetch_all(::Type{<:User})::Array{User,1} = SQL_SELECT_USERS |> fetch_all .|> User

"""
    fetch_all(::Type{<:User}, project_id::Integer)::Array{User,1}

Fetch all [`User`](@ref) records associated with a specific project.

# Arguments
- `::Type{<:User}`: The type of the records to fetch.
- `project_id::Integer`: The ID of the project.

# Returns
An array of [`User`](@ref) objects.
"""
fetch_all(::Type{<:User}, project_id::Integer)::Array{User,1} =
    fetch_all(SQL_SELECT_USERS_BY_PROJECT_ID, (id=project_id,)) .|> User

"""
    insert(::Type{<:User}, first_name::AbstractString, last_name::AbstractString,
        username::AbstractString,
        password::AbstractString)::Tuple{Union{Nothing,<:Integer},UpsertResult}

Insert a [`User`](@ref) record.

# Arguments
- `::Type{<:User}`: The type of the record to insert.
- `first_name::AbstractString`: The first name of the user.
- `last_name::AbstractString`: The last name of the user.
- `username::AbstractString`: The username of the user.
- `password::AbstractString`: The password of the user.

# Returns
- The inserted record ID. If an error occurs, `nothing` is returned.
- An [`UpsertResult`](@ref). [`Created`](@ref) if the record was successfully created,
[`Duplicate`](@ref) if the record already exists, [`Unprocessable`](@ref) if the record
violates a constraint, and [`Error`](@ref) if an error occurred while creating the record.
"""
insert(::Type{<:User}, first_name::AbstractString, last_name::AbstractString,
    username::AbstractString,
    password::AbstractString)::Tuple{Union{Nothing,<:Integer},UpsertResult} =
    insert(SQL_INSERT_USER, (first_name=first_name, last_name=last_name, username=username,
        password=password, created_date=(now() |> string),))

"""
    update(::Type{<:User}, id::Integer; first_name::Union{String,Nothing}=nothing,
        last_name::Union{String,Nothing}=nothing, password::Union{String,Nothing}=nothing,
        is_admin::Union{String,Nothing}=nothing)::UpsertResult

Update a [`User`](@ref) record.

# Arguments
- `::Type{<:User}`: The type of the record to update.
- `first_name::String`: The first name of the user.
- `last_name::String`: The last name of the user.
- `password::String`: The password of the user.
- `is_admin::Bool`: Whether the user is an admin.

# Returns
An [`UpsertResult`](@ref). [`Updated`](@ref) if the record was successfully updated,
[`Unprocessable`](@ref) if the record violates a constraint, and [`Error`](@ref) if an
error occurred.
"""
update(::Type{<:User}, id::Integer; first_name::Union{String,Nothing}=nothing,
    last_name::Union{String,Nothing}=nothing, password::Union{String,Nothing}=nothing,
    is_admin::Union{Bool,Nothing}=nothing)::UpsertResult =
    update(SQL_UPDATE_USER, fetch(User, id); first_name=first_name, last_name=last_name,
        password=password, is_admin=is_admin)

"""
    delete(::Type{<:User}, id::Integer)::Bool

Delete a [`User`](@ref) record.

# Arguments
- `::Type{<:User}`: The type of the record to delete.
- `id::Integer`: The id of the user to delete.

# Returns
`true` if the record was successfully deleted, `false` otherwise.
"""
delete(::Type{<:User}, id::Integer)::Bool = delete(SQL_DELETE_USER, id)
