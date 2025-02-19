"""
    query_record(::Type{<:User}, username::String;
        database::SQLite.DB=get_database())::Union{SQLite.Row, Nothing}

Query an [`User`](@ref) record by username.

# Arguments
- `::Type{<:User}`: The type of the record to query.
- `username::String`: The username of the user to query.

# Keyword Arguments
- `database::SQLite.DB`: The database connection.

# Returns
A [`SQLite.Row`](@ref) object.
"""
function query_record(::Type{<:User}, username::String;
    database::SQLite.DB=get_database())::Union{SQLite.Row,Nothing}
    record = DBInterface.execute(database, SQL_SELECT_USER_BY_USERNAME,
        (username=username,))
    if (record |> isempty)
        return nothing
    end
    return (record |> first)
end

"""
    insert_record(::Type{<:User}, first_name::String, last_name::String, username::String,
        password::String; database::SQLite.DB=get_database())::UpsertResult

Insert an [`User`](@ref) record.

# Arguments
- `::Type{<:User}`: The type of the record to insert.
- `first_name::String`: The first name of the user.
- `last_name::String`: The last name of the user.
- `username::String`: The username of the user.
- `password::String`: The password of the user.

# Keyword Arguments
- `database::SQLite.DB`: The database connection.

# Returns
An [`UpsertResult`](@ref).
"""
function insert_record(::Type{<:User}, first_name::String, last_name::String,
    username::String, password::String; database::SQLite.DB=get_database())::UpsertResult
    try
        DBInterface.execute(database, SQL_INSERT_USER, (first_name=first_name,
            last_name=last_name, username=username, password=password,
            created_at=(now() |> string),))
        return CREATED
    catch exception
        if occursin("UNIQUE constraint failed", (exception.msg |> string))
            return DUPLICATE
        elseif occursin("CHECK constraint failed", (exception.msg |> string))
            return UNPROCESSABLE
        else
            return ERROR
        end
    end
end
