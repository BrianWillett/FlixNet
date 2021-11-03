sub init()
  m.global.append({screenManager: createObject("roSGNode","ScreenManager")})
  m.genreCount = 0
  m.fetchedCount = 0
  m.genres = createObject("roAssociativeArray")
  m.movies = createObject("roAssociativeArray")
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

sub getMoviesForGenres(index)
    fetch = createObject("roSGNode","MoviesTask")
    fetch.unobserveField("response")
    fetch.params = {
      reqType: "moviesByGenre",
      genreId: m.genres[index].id
    }
    fetch.observeField("response","onResponseReceived")
    fetch.control = "run"
end sub

sub onResponseReceived(event)
    response = event.getData()
    if invalid <> response
      if invalid <> response.genres
        m.genres.clear()
        m.genres = response.genres
        m.genreCount = response.genres.count()
        if 0 < response.genres.count() then getMoviesForGenres(m.fetchedCount)
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
          m.global.screenManager.callFunc("goToScreen",{type:"LoginScreen", data:m.movies})
        else
          getMoviesForGenres(m.fetchedCount)
        end if
      end if
    end if
  end sub