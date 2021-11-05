sub init()
  m.global.append({screenManager: createObject("roSGNode","ScreenManager")})
  m.genreCount = 0
  m.fetchedCount = 0
  m.genres = createObject("roAssociativeArray")
  m.movies = createObject("roAssociativeArray")
  m.navBar = m.top.findNode("navBar")
  m.navBar.visible = false
  lstF = createObject("roSGNode","Node")
  m.global.addFields({lastFocused: lstF})
  getMovieGenres()
end sub

sub getMovieGenres()
  m.genreCount = 0
  m.fetchedCount = 0
  fetch = createObject("roSGNode","GenresTask")
  fetch.params = {
      reqType: "movieGenres",
  }
  fetch.observeField("response","onResponseReceived")
  fetch.control = "run"
end sub

sub getVideosForGenres(index,theTask)
    fetch = createObject("roSGNode",theTask)
    fetch.unobserveField("response")
    if "Popular Television" <> m.genres[index].name and "Popular Movies" <> m.genres[index].name
      fetch.params = {
        reqType: "moviesByGenre",
        genreId: m.genres[index].id
      }
    else
      theType = "moviesByPopularity"
      if "TVTask" = theTask
        theType = "tvByPopularity"
      end if
      fetch.params = {
        reqType: theType
      }
    end if
    fetch.observeField("response","onResponseReceived")
    fetch.control = "run"
end sub

sub onResponseReceived(event)
    response = event.getData()
    if invalid <> response
      if invalid <> response.genres
        m.genres.clear()
        m.genres = response.genres
        m.genres.push({id:1,name:"Popular Movies"})
        m.genres.push({id:2,name:"Popular Television"})
        m.genreCount = m.genres.count()
        if 0 < response.genres.count()
          theTask = "MoviesTask"
          if "Popular Television" = m.genres[m.fetchedCount].name then theTask = "TVTask"
            getVideosForGenres(m.fetchedCount, theTask)
          end if
      else if invalid <> response.results
        genre = {
          "genreId":m.genres[m.fetchedCount].id,
          "genreName": m.genres[m.fetchedCount].name,
          "movies":response.results
        }
        m.movies.addReplace(m.genres[m.fetchedCount].name,genre)
        m.fetchedCount += 1
        if m.genreCount = m.fetchedCount
          params = {
            genres: m.genres,
            movies: m.movies
          }
          if checkLoggedIn()
            m.navBar.visible = true
            m.global.screenManager.callFunc("goToScreen",{type:"HomeScreen", data:m.movies})
          else
            m.navBar.visible = true
            m.global.screenManager.callFunc("goToScreen",{type:"LoginScreen", data:m.movies})
          end if
        else
          theTask = "MoviesTask"
          if "Popular Television" = m.genres[m.fetchedCount].name then theTask = "TVTask"
            getVideosForGenres(m.fetchedCount, theTask)
          end if
      end if
    end if
  end sub

  sub focusNavBar()
    m.navBar.setFocus(true)
    m.navBar.expanded= true
end sub

sub closeNavBar()
    m.navBar.expanded = false
    if invalid <> m.global.lastFocused
        m.global.lastFocused.setFocus(true)
    else
        m.list.setFocus(true)
    end if
end sub

  function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
      if "left" = key
        
        handled = true
      else if "right" = key
        
        handled = true
      else if "up" = key
        
        handled = true
      else if "down" = key
        
        handled = true
      else if "OK" = key
        closeNavBar()
        handled = true
      else if "back" = key
          if m.navBar.isInFocusChain() then closeNavBar()
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