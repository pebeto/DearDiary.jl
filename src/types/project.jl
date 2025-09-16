"""
    Project

A struct representing a project with its details.

# Fields
- `id::Integer`: The ID of the project.
- `name::String`: The name of the project.
- `description::Union{String,Missing}`: A brief description of the project.
- `created_date::DateTime`: The date and time the project was created.
"""
struct Project <: ResultType
    id::Integer
    name::String
    description::Union{String,Missing}
    created_date::DateTime
end

"""
    ProjectCreatePayload

A struct that represents the payload for creating a project.

# Fields
- `name::String`: The name of the project.
"""
struct ProjectCreatePayload <: UpsertType
    name::String
end

"""
    ProjectUpdatePayload

A struct that represents the payload for updating a project.

# Fields
- `name::Union{String,Nothing}`: The name of the project.
- `description::Union{String,Nothing}`: A brief description of the project.
"""
struct ProjectUpdatePayload <: UpsertType
    name::Union{String,Nothing}
    description::Union{String,Nothing}
end
