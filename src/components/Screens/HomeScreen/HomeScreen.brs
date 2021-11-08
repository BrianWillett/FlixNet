sub init()
    m.list = m.top.findNode("genreList")
    m.list.visible = false
    m.backdrop = m.top.findNode("backdrop")
    m.list.observeField("rowItemSelected","onSelection")
    m.list.observeField("rowItemFocused","onFocus")
    m.watchBtn = m.top.findNode("watch")
    m.infoBtn = m.top.findNode("info")
    m.navBar = m.top.findNode("NavBar")
    m.btnFocusColor = "#FFFFFF"
    m.buttonUnfocusColor = "#112244"
    m.movieSelectedId = invalid
    m.movieSelectedTitle = ""
    m.movieSelectedMovie = invalid
    m.trailerPlayer = m.top.findNode("player")
    m.playerState = "stopped"
    m.lastFocused = invalid
    m.spinner = m.top.findNode("spinner")
end sub


sub onOpen(params)
    m.spinner.control = "start"
    m.spinner.status = "Loading Profile..."
    m.trailerPlayer.visible = false
    if invalid <> params and invalid <> params.data
        displayGenres(params.data)
    else if invalid <> m.list and invalid <> m.list.content
        if invalid <> m.lastFocused
            m.lastFocused.setFocus(true)
        else
            m.list.setFocus(true)
        end if
    end if
end sub

sub displayGenres(genres)
    topNode = createObject("roSGNode","ContentNode")
    topNode = addPopularToTop(topNode, genres)
    for each genre in genres
        if genre <> "Popular Movies" and genre <> "Popular Television"
            rowNode = CreateObject("roSGNode","ContentNode")
            rowNode.title = genre
            rowNode.id = genres[genre].genreId
            movies = genres[genre].movies
            for i = 0 to movies.count() - 1 step 1
                if invalid <> movies[i]
                    movie = createObject("roSGNode","ContentNode")
                    if invalid <> movies[i].id then movie.id = movies[i].id
                    if invalid <> movies[i].title then movie.title = movies[i].title
                    if invalid <> movies[i].release_date then movie.releaseDate = movies[i].release_date
                    if invalid <> movies[i].vote_average then movie.rating = movies[i].vote_average.toStr()
                    if invalid <> movies[i].overview then movie.description = movies[i].overview
                    if invalid <> movies[i].poster_path then movie.HDPosterURL = getValueFromKey("mini_poster_base_url") +  movies[i].poster_path
                    if invalid <> movies[i].backdrop_path
                        movie.SDPosterURL = getValueFromKey("backdrop_poster_base_url") + movies[i].backdrop_path
                    else
                        movie.SDPosterURL = "pkg:/assets/images/blankscreen.png"
                    end if
                    rowNode.appendChild(movie)
                end if
            end for
            topNode.appendChild(rowNode)
        end if
    end for
    m.spinner.control = "stop"
    m.list.content = topNode
    m.list.visible = true
    m.list.setFocus(true)
end sub

function addPopularToTop(topNode, genres)
    orderedGenres = createObject("roAssociativeArray")
    pMovies = genres.lookup("Popular Movies")
    pTV = genres.lookup("Popular Television")
    orderedGenres.addReplace("Popular Movies", pMovies)
    orderedGenres.addReplace("Popular Television", pTV)
    for each genre in orderedGenres
        rowNode = CreateObject("roSGNode","ContentNode")
        rowNode.title = genre
        rowNode.id = orderedGenres[genre].genreId
        movies = orderedGenres[genre].movies
        for i = 0 to movies.count() - 1 step 1
            if invalid <> movies[i] and invalid <> movies[i].original_language and "en" = movies[i].original_language
                movie = createObject("roSGNode","ContentNode")
                if invalid <> movies[i].id then movie.id = movies[i].id
                if invalid <> movies[i].title then movie.title = movies[i].title
                if "Popular Television" = genre
                    if invalid <> movies[i].name then movie.title = movies[i].name
                    if invalid <> movies[i].first_air_date then movie.releaseDate = movies[i].first_air_date
                end if
                if invalid <> movies[i].release_date then movie.releaseDate = movies[i].release_date
                if invalid <> movies[i].vote_average then movie.rating = movies[i].vote_average.toStr()
                if invalid <> movies[i].overview and "" <> movies[i].overview
                    movie.description = movies[i].overview
                else if "" = movies[i].overview
                    movie.description = "No description given"
                end if
                if invalid <> movies[i].poster_path then movie.HDPosterURL = getValueFromKey("mini_poster_base_url") +  movies[i].poster_path
                if invalid <> movies[i].backdrop_path
                    movie.SDPosterURL = getValueFromKey("backdrop_poster_base_url") + movies[i].backdrop_path
                else
                    movie.SDPosterURL = "pkg:/assets/images/blankscreen.png"
                end if
                rowNode.appendChild(movie)
            end if
        end for
        topNode.appendChild(rowNode)
    end for
    return topNode
end function

sub onFocus(event)
    movie = findMovieDetails(event.getData())
    if invalid <> movie
        if invalid <> movie.title then m.backdrop.title = movie.title
        if invalid <> movie.releaseDate then m.backdrop.releaseDate = movie.releaseDate
        if invalid <> movie.rating then m.backdrop.scoreText = movie.rating + "/10"
        if invalid <> movie.description then m.backdrop.description = movie.description
        if invalid <> movie.SDPosterURL then  m.backdrop.imageUri = movie.SDPosterURL
    end if
end sub

sub onSelection(event)
    movie = findMovieDetails(event.getData())
    m.movieSelectedMovie = movie
    m.movieSelectedTitle = movie.title
    m.movieSelectedId = movie.id
    children = m.backdrop.getChild(m.backdrop.getChildCount() - 1)
    children = children.getChild(children.getChildCount() - 1)
    btns = children.getChildren(-1,0)
    changeButtonFocus(btns[0])
end sub

function findMovieDetails(coords)
    movie = invalid
    if invalid <> coords and invalid <> coords[0] and invalid <> coords[1]
        if invalid <> m.list and invalid <> m.list.content then row = m.list.content.getChildren(-1,0)
        if invalid <> row then movies = row[coords[0]].getChildren(-1,0)
        if invalid <> movies then movie = movies[coords[1]]
    end if
    return movie
end function

sub changeButtonFocus(btnToFocus = invalid)
    if invalid <> btnToFocus
        if m.watchBtn.id = btnToFocus.id
            m.backdrop.infoBtnColor = m.buttonUnfocusColor
            m.backdrop.infoTxtColor = "#FFFFFF"
            m.backdrop.watchBtnColor = m.btnFocusColor
            m.backdrop.watchTxtColor = "#000000"
        else if m.infoBtn.id = btnToFocus.id
            m.backdrop.infoBtnColor = m.buttonFocusColor
            m.backdrop.infoTxtColor = "#000000"
            m.backdrop.watchBtnColor = m.buttonUnfocusColor
            m.backdrop.watchTxtColor = "#FFFFFF"
        end if
        btnToFocus.setFocus(true)
        m.lastFocused = btnToFocus
    else
        m.backdrop.watchBtnColor = m.buttonUnfocusColor
        m.backdrop.watchTxtColor = "#FFFFFF"
        m.backdrop.infoBtnColor = m.buttonUnfocusColor
        m.backdrop.infoTxtColor = "#FFFFFF"
        m.list.setFocus(true)
        m.lastFocused = m.list
    end if
end sub

sub runTask(taskToRun, imdb_id = invalid)
    theParams = invalid
    if "MoviesTask" = taskToRun
        m.spinner.control = "start"
        m.spinner.status = "Fetching Video..."
        theParams = {
            reqType: "specificMovie",
            movieId: m.movieSelectedId.toStr()
        }
    else if "MovieVideos" = taskToRun and invalid <> imdb_id
        taskToRun = "MoviesTask"
        theParams = {
            reqType: "fetchMovieVideos"
            imdb_id: imdb_id
        }
    else if "MovieTrailer" = taskToRun and invalid <> imdb_id
        taskToRun = "MoviesTask"
        theParams = {
            reqType: "fetchMovieTrailer"
            imdb_id: imdb_id
        }
    end if
    task = CreateObject("roSGNode",taskToRun)
    task.unobserveField("response")
    task.params = theParams
    task.observeField("response","onResponseReceived")
    task.control = "run"
end sub

sub onResponseReceived(event)
    response = event.getData()
    if invalid <> response
        if invalid <> response.imdb_id
            runTask("MovieVideos", response.imdb_id)
        else if invalid <> response.resource
            if invalid <> response.resource.videos
                vids = response.resource.videos
                if invalid <> vids and invalid <> vids[0]
                    trailerId = vids[0].id.split("/")
                    runTask("MovieTrailer",trailerId[2])
                end if
            else if invalid <> response.resource.encodings
                encodings = response.resource.encodings
                playVideo(encodings[0].playUrl)
            else
                ?"No Video To Display"
            end if
        end if
    end if
end sub

sub playVideo(url)
    trailerSetup = createObject("roSGNode","ContentNode")
    trailerSetup.title = m.movieSelectedTitle + " Trailer"
    trailerSetup.url = url

    m.trailerPlayer.EnableCookies()
    m.trailerPlayer.setCertificatesFile("common:/certs/ca-bundle.crt")
    m.trailerPlayer.InitClientCertificates()

    m.trailerPlayer.content = trailerSetup

    m.trailerPlayer.observeField("state", "updateState")
    m.spinner.control = "stop"
    m.trailerPlayer.control = "play"
    m.trailerPlayer.visible = true
    m.trailerPlayer.setFocus(true)
end sub

sub updateState(event)
    m.state = event.getData()
    if "finished" = m.state then closeVideo()
end sub

sub closeVideo()
    m.trailerPlayer.control = "stop"
    m.trailerPlayer.visible = false
    m.watchBtn.setFocus(true)
end sub

sub focusNavBar()
    m.navBar.setFocus(true)
    m.navBar.expanded= true
end sub

sub closeNavBar()
    m.navBar.expanded = false
    if invalid <> m.lastFocused
        m.lastFocused.setFocus(true)
    else
        m.list.setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "left" = key
            if m.infoBtn.isInFocusChain() then changeButtonFocus(m.watchBtn)
            handled = true
        else if "right" = key
            if m.watchBtn.isInFocusChain() then changeButtonFocus(m.infoBtn)
            if m.navBar.isInFocusChain() then closeNavBar()
            handled = true
        else if "up" = key
            handled = true
        else if "down" = key
            if m.infoBtn.isInFocusChain() or m.watchBtn.isInFocusChain() then changeButtonFocus()
            handled = true
        else if "OK" = key
            if m.watchBtn.isInFocusChain()
                runTask("MoviesTask")
            else if m.infoBtn.isInFocusChain()
                m.lastFocused = m.infoBtn
                m.global.screenManager.callFunc("goToScreen",{type:"InfoScreen",data:m.movieSelectedMovie})
            else if m.navBar.isInFocusChain()
                closeNavBar()
            end if
            handled = true
        else if "back" = key
            if m.trailerPlayer.isInFocusChain()
                closeVideo()
            else if m.watchBtn.isInFocusChain() or m.infoBtn.isInFocusChain()
                changeButtonFocus()
            else if m.list.isInFocusChain()
                m.global.screenManager.callFunc("goBack",{})
            else if m.navBar.isInFocusChain()
                closeNavBar()
            end if
            handled = true
        else if "options" = key
            if not m.navBar.isInFocusChain()
                focusNavBar()
            else
                closeNavBar()
            end if
            handled = true
        end if
    end if
    return handled
end function