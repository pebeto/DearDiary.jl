"""
    get_user_by_username_handler(request::HTTP.Request, username::String)::HTTP.Response

!!! warning
    This function is for route handling and should not be called directly.
"""
@same_user_or_admin_required function get_user_by_id_handler(request::HTTP.Request,
    id::Int)::HTTP.Response
    response_user = id |> get_user_by_id

    if (response_user |> isnothing)
        return json(("message" => (HTTP.StatusCodes.NOT_FOUND |> HTTP.statustext));
            status=HTTP.StatusCodes.NOT_FOUND)
    end
    return json(response_user; status=HTTP.StatusCodes.OK)
end

"""
    get_users_handler(request::HTTP.Request)::HTTP.Response

!!! warning
    This function is for route handling and should not be called directly.
"""
@admin_required function get_users_handler(request::HTTP.Request)::HTTP.Response
    return json(get_users(); status=HTTP.StatusCodes.OK)
end

"""
    create_user_handler(request::HTTP.Request,
        parameters::Json{UserCreatePayload})::HTTP.Response

!!! warning
    This function is for route handling and should not be called directly.
"""
@admin_required function create_user_handler(request::HTTP.Request,
    parameters::Json{UserCreatePayload})::HTTP.Response
    user_id, upsert_result = parameters.payload |> create_user
    upsert_status = upsert_result |> get_status_by_upsert_result
    return json(("user_id" => user_id); status=upsert_status)
end

"""
    update_user_handler(request::HTTP.Request, id::Int,
        parameters::Json{UserUpdatePayload})::HTTP.Response

!!! warning
    This function is for route handling and should not be called directly.
"""
@same_user_or_admin_required function update_user_handler(request::HTTP.Request, id::Int,
    parameters::Json{UserUpdatePayload})::HTTP.Response
    upsert_result = update_user(id, parameters.payload)
    upsert_status = upsert_result |> get_status_by_upsert_result
    return json(("message" => (upsert_result |> String)); status=upsert_status)
end

"""
    delete_user_handler(request::HTTP.Request, id::Int)::HTTP.Response

!!! warning
    This function is for route handling and should not be called directly.
"""
@same_user_or_admin_required function delete_user_handler(request::HTTP.Request,
    id::Int)::HTTP.Response
    success = id |> delete_user

    if !success
        return json(("message" => (HTTP.StatusCodes.INTERNAL_SERVER_ERROR |> HTTP.statustext));
            status=HTTP.StatusCodes.INTERNAL_SERVER_ERROR)
    end
    return json(("message" => (HTTP.StatusCodes.OK |> HTTP.statustext));
        status=HTTP.StatusCodes.OK)
end
