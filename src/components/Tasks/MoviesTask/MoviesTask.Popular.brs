function fetchMoviesByPopularity()
    url = getValueFromKey("base_url") + "discover/movie?api_key=" + getValueFromKey("api_key") + "&sort_by=popularity.desc"
    httpObject = CreateObject("roURLTransfer")
    port = CreateObject("roMessagePort")
    httpObject.setURL(url)
    httpObject.setPort(port)
    httpObject.setHeaders({
        Accept: "application/json"
    })
    httpObject.setCertificatesFile("common:/certs/ca-bundle.crt")

    return sendRequest(httpObject,port)
end function