function get_project_by_id_handler(request::HTTP.Request, id::Int)::HTTP.Response
    response_project = id |> get_project_by_id

    if (response_project |> isnothing)
        return json(
            ("message" => (HTTP.StatusCodes.NOT_FOUND |> HTTP.statustext));
            status=HTTP.StatusCodes.NOT_FOUND,
        )
    end
    return json(response_project; status=HTTP.StatusCodes.OK)
end

function get_projects_handler(request::HTTP.Request)::HTTP.Response
    return json(get_projects(); status=HTTP.StatusCodes.OK)
end

@admin_required function create_project_handler(
    request::HTTP.Request, parameters::Json{ProjectCreatePayload}
)::HTTP.Response
    project_id, upsert_result = create_project(user.id, parameters.payload)
    upsert_status = upsert_result |> get_status_by_upsert_result
    return json(("project_id" => project_id); status=upsert_status)
end

function update_project_handler(
    request::HTTP.Request, id::Int, parameters::Json{ProjectUpdatePayload}
)::HTTP.Response
    upsert_result = update_project(id, parameters.payload)
    upsert_status = upsert_result |> get_status_by_upsert_result
    return json(("message" => (upsert_result |> String)); status=upsert_status)
end

function delete_project_handler(request::HTTP.Request, id::Int)::HTTP.Response
    success = id |> delete_project

    if !success
        return json(
            ("message" => (HTTP.StatusCodes.INTERNAL_SERVER_ERROR |> HTTP.statustext));
            status=HTTP.StatusCodes.INTERNAL_SERVER_ERROR,
        )
    end
    return json(
        ("message" => (HTTP.StatusCodes.OK |> HTTP.statustext));
        status=HTTP.StatusCodes.OK,
    )
end
