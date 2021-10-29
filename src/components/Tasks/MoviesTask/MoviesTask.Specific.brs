function fetchSpecificMovie(params)
    url = getValueFromKey("base_url") + "movie/" + params.movieId + "?api_key=" + getValueFromKey("api_key") + "&language=en-US"
    httpObject = createObject("roUrlTransfer")
    port = createObject("roMessagePort")
    httpObject.setPort(port)
    httpObject.setUrl(url)
    httpObject.setHeaders({
        Accept:"application/json"
    })
    httpObject.setCertificatesFile("common:/certs/ca-bundle.crt")
    return sendRequest(httpObject,port)
end function