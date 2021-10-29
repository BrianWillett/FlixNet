function fetchMoviesByGenre(params)
    genres = params.genreId.toStr()
    url = getValueFromKey("base_url") + "discover/movie?api_key=" + getValueFromKey("api_key") + "&language=en-US&sort_by=popularity.desc&page=1&with_genres=" + genres
    httpObject = createObject("roUrlTransfer")
    port = createObject("roMessagePort")
    httpObject.setUrl(url)
    httpObject.setHeaders({
        Accept: "application/json"
    })
    httpObject.setCertificatesFile("common:/certs/ca-bundle.crt")
    httpObject.setPort(port)

    return sendRequest(httpObject,port)
end function