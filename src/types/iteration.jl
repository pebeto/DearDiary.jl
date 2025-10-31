"""
    Iteration

A struct representing an iteration within an experiment.

Fields
- `id::Int64`: The unique identifier of the iteration.
- `experiment_id::Int64`: The identifier of the experiment to which the iteration belongs.
- `notes::String`: Notes associated with the iteration.
- `created_date::DateTime`: The date and time when the iteration was created.
- `end_date::Optional{DateTime}`: The date and time when the iteration ended, or `nothing` if it is still ongoing.
"""
struct Iteration <: ResultType
    id::Int64
    experiment_id::Int64
    notes::String
    created_date::DateTime
    end_date::Optional{DateTime}
end

struct IterationUpdatePayload <: UpsertType
    notes::Optional{String}
    end_date::Optional{DateTime}
end
