sub doWork(params)
    if invalid <> params and invalid <> params.reqType
        if "moviesByGenre" = params.reqType
            m.top.response = fetchMoviesByGenre(params)
        else if "specificMovie" = params.reqType and invalid <> params.movieId
            m.top.response = fetchSpecificMovie(params)
        else if "fetchMovieVideos" = params.reqType and invalid <> params.imdb_id
            m.top.response = fetchIMDBVideos(params)
        else if "fetchMovieTrailer" = params.reqType and invalid <> params.imdb_id
            m.top.response = fetchIMDBTrailer(params)
        else if "moviesByPopularity" = params.reqType
            m.top.response = fetchMoviesByPopularity()
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