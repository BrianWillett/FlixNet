function fetchTVByPopularity()
    url = getValueFromKey("base_url") + "discover/tv?api_key=" + getValueFromKey("api_key") + "&language=en&sort_by=popularity.desc"
    httpObject = CreateObject("roURLTransfer")
    port = CreateObject("roMessagePort")
    httpObject.setUrl(url)
    httpObject.setPort(port)
    httpObject.setHeaders({
        Accept: "application/json"
    })
    httpObject.setCertificatesFile("common:/certs/ca-bundle.crt")

    return sendRequest(httpObject,port)
end function