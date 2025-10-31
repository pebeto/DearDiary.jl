"""
    @enum Status IN_PROGRESS = 1 STOPPED = 2 FINISHED = 3

An enumeration representing the status of an experiment.
"""
@enum Status IN_PROGRESS = 1 STOPPED = 2 FINISHED = 3

@doc """
    IN_PROGRESS::Status

An enumeration value representing an experiment that is currently in progress.
""" IN_PROGRESS

@doc """
    STOPPED::Status

An enumeration value representing an experiment that has been stopped.
""" STOPPED

@doc """
    FINISHED::Status

An enumeration value representing an experiment that has finished.
""" FINISHED

Base.convert(::Type{Status}, value::Integer) = Status(value)
