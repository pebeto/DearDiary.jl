"""
    UpsertResult

# Members
- `CREATED`: The record was successfully created.
- `DUPLICATE`: The record already exists.
- `ERROR`: An error occurred while creating the record.
"""
@enum UpsertResult begin
    CREATED
    DUPLICATE
    UNPROCESSABLE
    ERROR
end
