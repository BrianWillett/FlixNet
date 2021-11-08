sub init()
    m.label = m.top.findNode("label")
end sub


sub onOpen(params)
    m.label.setFocus(true)
    m.global.lastFocused = m.label
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
            
            handled = true
        else if "back" = key
            
            handled = true
        else if "options" = key
            handled = false
        end if
    end if
    return handled
end function