"""
    fetch(::Type{<:Experiment}, id::Integer)::Union{Experiment,Nothing}

Fetch an [`Experiment`](@ref) by id.

# Arguments
- `::Type{<:Experiment}`: The type of the record to query.
- `id::Integer`: The id of the experiment to query.

# Returns
An [`Experiment`](@ref) object. If the record does not exist, return `nothing`.
"""
function fetch(::Type{<:Experiment}, id::Integer)::Union{Experiment,Nothing}
    experiment = fetch(SQL_SELECT_EXPERIMENT_BY_ID, (id=id,))
    return (experiment |> isnothing) ? nothing : (experiment |> Experiment)
end

"""
    fetch_all(::Type{<:Experiment}, project_id::Integer)::Array{Experiment,1}

Fetch all [`Experiment`](@ref) associated with a specific project.

# Arguments
- `::Type{<:Experiment}`: The type of the record to query.
- `project_id::Integer`: The id of the project.

# Returns
An array of [`Experiment`](@ref) objects.
"""
fetch_all(::Type{<:Experiment}, project_id::Integer)::Array{Experiment,1} =
    fetch_all(SQL_SELECT_EXPERIMENTS_BY_PROJECT_ID; params=(id=project_id,)) .|> Experiment

"""
    insert(::Type{<:Experiment}, project_id::Integer, status_id::Integer,
        name::AbstractString)::Tuple{Union{Nothing,<:Integer},UpsertResult}

Insert an [`Experiment`](@ref) record.

# Arguments
- `::Type{<:Experiment}`: The type of the record to insert.
- `project_id::Integer`: The id of the project.
- `status_id::Integer`: The id of the status.
- `name::AbstractString`: The name of the experiment.

# Returns
- The inserted record ID. If an error occurs, `nothing` is returned.
- An [`UpsertResult`](@ref). [`Created`](@ref) if the record was successfully created,
[`Duplicate`](@ref) if the record already exists, [`Unprocessable`](@ref) if the record
violates a constraint, and [`Error`](@ref) if an error occurred while creating the record.
"""
insert(::Type{<:Experiment}, project_id::Integer, status_id::Integer,
    name::AbstractString)::Tuple{Union{Nothing,<:Integer},UpsertResult} =
    insert(SQL_INSERT_EXPERIMENT, (project_id=project_id, status_id=status_id, name=name,
        created_date=(now() |> string),))

"""
    update(::Type{<:Experiment}, id::Integer; status_id::Union{Integer,Nothing}=nothing,
        name::Union{String,Nothing}=nothing, description::Union{String,Nothing}=nothing,
        end_date::Union{DateTime,Nothing}=nothing)::UpsertResult

Update an [`Experiment`](@ref) record.

# Arguments
- `::Type{<:Experiment}`: The type of the record to update.
- `id::Integer`: The id of the experiment to update.
- `status_id::Integer`: The new status id of the experiment.
- `name::String`: The new name of the experiment.
- `description::String`: The new description of the experiment.
- `end_date::DateTime`: The new end date of the experiment.

# Returns
An [`UpsertResult`](@ref). [`Updated`](@ref) if the record was successfully updated,
[`Unprocessable`](@ref) if the record violates a constraint, and [`Error`](@ref) if an
error occurred.
"""
update(::Type{<:Experiment}, id::Integer; status_id::Union{Integer,Nothing}=nothing,
    name::Union{String,Nothing}=nothing, description::Union{String,Nothing}=nothing,
    end_date::Union{DateTime,Nothing}=nothing)::UpsertResult =
    update(SQL_UPDATE_EXPERIMENT, fetch(Experiment, id); status_id=status_id, name=name,
        description=description, end_date=end_date)

"""
    delete(::Type{<:Experiment}, id::Integer)::Bool

Delete a [`Experiment`](@ref) record.

# Arguments
- `::Type{<:Experiment}`: The type of the record to delete.
- `id::Integer`: The id of the experiment to delete.

# Returns
`true` if the record was successfully deleted, `false` otherwise.
"""
delete(::Type{<:Experiment}, id::Integer)::Bool = delete(SQL_DELETE_EXPERIMENT, id)
