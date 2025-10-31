"""
    Metric

A struct representing a metric with its details.

Fields
- `id::Int64`: The ID of the metric.
- `iteration_id::Int64`: The ID of the iteration this metric belongs to.
- `key::String`: The key/name of the metric.
- `value::Float64`: The value of the metric.
"""
struct Metric <: ResultType
    id::Int64
    iteration_id::Int64
    key::String
    value::Float64
end

struct MetricCreatePayload <: UpsertType
    key::String
    value::Float64
end

struct MetricUpdatePayload <: UpsertType
    key::Optional{String}
    value::Optional{Float64}
end
