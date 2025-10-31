"""
    UserPermission

A struct representing a user's permissions for a specific project.

Fields
- `id::Int64`: The unique identifier for the user permission record.
- `user_id::Int64`: The ID of the user.
- `project_id::Int64`: The ID of the project.
- `create_permission::Bool`: Permission to create resources.
- `read_permission::Bool`: Permission to read resources.
- `update_permission::Bool`: Permission to update resources.
- `delete_permission::Bool`: Permission to delete resources.
"""
struct UserPermission <: ResultType
    id::Int64
    user_id::Int64
    project_id::Int64
    create_permission::Bool
    read_permission::Bool
    update_permission::Bool
    delete_permission::Bool
end

struct UserPermissionCreatePayload <: UpsertType
    create_permission::Bool
    read_permission::Bool
    update_permission::Bool
    delete_permission::Bool
end

struct UserPermissionUpdatePayload <: UpsertType
    create_permission::Optional{Bool}
    read_permission::Optional{Bool}
    update_permission::Optional{Bool}
    delete_permission::Optional{Bool}
end
