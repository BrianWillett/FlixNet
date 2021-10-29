function fetchMovieGenres()
    url = getValueFromKey("base_url") + "genre/movie/list?api_key=" + getValueFromKey("api_key")
    httpObject = CreateObject("roUrlTransfer")
    httpObject.setUrl(url)
    httpObject.setHeaders({
        Accept: "application/json"
    })
    port = createObject("roMessagePort")
    httpObject.setPort(port)
    httpObject.setCertificatesFile("common:/certs/ca-bundle.crt")

    return sendRequest(httpObject,port)
end function