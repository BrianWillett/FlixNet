sub doWork(params)
    if invalid <> params and  invalid <> params.reqType
        if "tvByPopularity" = params.reqType
            m.top.response = fetchTVByPopularity()
        end if
    end if
end sub

function sendRequest(httpObject,port)
    response = invalid
    httpObject.asyncGetToString()
    msg = wait(1000,port)

    if "roUrlEvent" = type(msg)
        if 200 = msg.getResponseCode()
            resp = msg.getString()
            response = ParseJson(resp)
        end if
    end if
    return response
end function