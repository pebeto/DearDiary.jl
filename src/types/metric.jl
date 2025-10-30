"""
    Metric

A struct representing a metric with its details.

Fields
- `id`: The ID of the metric.
- `iteration_id`: The ID of the iteration this metric belongs to.
- `key`: The key/name of the metric.
- `value`: The value of the metric.
"""
struct Metric <: ResultType
    id::Int64
    iteration_id::Int64
    key::String
    value::Float64
end

"""
    MetricCreatePayload

A struct that represents the payload for creating a metric.

Fields
- `key`: The key/name of the metric.
- `value`: The value of the metric.
"""
struct MetricCreatePayload <: UpsertType
    key::String
    value::Float64
end

"""
    MetricUpdatePayload

A struct that represents the payload for updating a metric.

Fields
- `key`: The key/name of the metric, or `nothing` if not updating.
- `value`: The value of the metric, or `nothing` if not updating.
"""
struct MetricUpdatePayload <: UpsertType
    key::Optional{String}
    value::Optional{Float64}
end
