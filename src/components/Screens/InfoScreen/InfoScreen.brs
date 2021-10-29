sub init()
    m.watchBtn = m.top.findNode("watch")
end sub


sub onOpen(params)
    if invalid <> params and invalid <> params.data
        if invalid <> params.data.description then m.top.description = params.data.description
        if invalid <> params.data.rating
            m.top.rating = params.data.rating + "/10"
        end if
        if invalid <> params.data.releaseDate
            date = params.data.releaseDate.split("-")
            m.top.releaseDate = date[0]
        end if
        if invalid <> params.data.SDPosterURL then m.top.SDPosterURL = params.data.SDPosterURL
        if invalid <> params.data.HDPosterURL then m.top.HDPosterURL = params.data.HDPosterURL
        if invalid <> params.data.title then m.top.title = params.data.title
    end if
    m.watchBtn.setFocus(true)
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
            
            handled = false
        else if "back" = key
            m.global.screenManager.callFunc("goBack",{closeCurrent: true})
            handled = true
        end if
    end if
    return handled
end function