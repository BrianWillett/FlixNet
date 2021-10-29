function fetchIMDBVideos(params)
    url = getValueFromKey("imdb_videos_url") + "?tconst=" + params.imdb_id + "&limit=25&region=US"
    httpObject = createObject("roURLTransfer")
    port = createObject("roMessagePort")
    httpObject.setUrl(url)
    httpObject.setPort(port)
    httpObject.addHeader("x-rapidapi-host", "imdb8.p.rapidapi.com")
    httpObject.addHeader("x-rapidapi-key", getValueFromKey("imdb_api_key"))
    httpObject.SetCertificatesFile("common:/certs/ca-bundle.crt")

    return sendRequest(httpObject,port)
end function

function fetchIMDBTrailer(params)
    url = getValueFromKey("imdb_video_playback_url") + "?viconst=" + params.imdb_id + "&region=US"
    httpObject = createObject("roURLTransfer")
    port = createObject("roMessagePort")
    httpObject.setUrl(url)
    httpObject.setPort(port)
    httpObject.addHeader("x-rapidapi-host", "imdb8.p.rapidapi.com")
    httpObject.addHeader("x-rapidapi-key", getValueFromKey("imdb_api_key"))
    httpObject.setCertificatesFile("common:/certs/ca-bundle.crt")

    return sendRequest(httpObject,port)
end function