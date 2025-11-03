"""
    Resource <: ResultType

A struct representing a resource associated with an experiment.

Fields
- `id::Int64`: The ID of the resource.
- `experiment_id::Int64`: The ID of the experiment this resource belongs to.
- `name::String`: The name of the resource.
- `description::String`: A description of the resource.
- `data::Optional{Array{UInt8,1}}`: The binary data of the resource.
- `created_date::DateTime`: The date and time when the resource was created.
- `updated_date::Optional{DateTime}`: The date and time when the resource was last updated.
"""
struct Resource <: ResultType
    id::Int64
    experiment_id::Int64
    name::String
    description::String
    data::Optional{Array{UInt8,1}}
    created_date::DateTime
    updated_date::Optional{DateTime}
end
