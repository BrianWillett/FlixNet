sub init()
    m.collapse = "pkg:/assets/images/navigation/collapsed.png"
    m.expand = "pkg:/assets/images/navigation/expanded.png"
    m.focusColor = "#FFFFFF"
    m.unfocusColor = "#555555"
    m.index = 0
    m.homeLabel = m.top.findNode("homeLabel")
    m.moviesLabel = m.top.findNode("moviesLabel")
    m.tvLabel = m.top.findNode("tvLabel")
    m.settingsLabel = m.top.findNode("settingsLabel")
end sub

sub handleExpansion()
    changeIndex(0)
    if m.top.expanded
        m.top.navWidth = 400
        m.top.navBG = m.expand
        m.top.homeColor = m.focusColor
        m.top.moviesColor = m.focusColor
        m.top.tvColor = m.focusColor
        m.top.settingsColor = m.focusColor
        m.top.dotColor = m.focusColor
        m.top.labelsVis = true
        m.top.titleVis = true
    else
        m.top.navWidth = 100
        m.top.navBG = m.collapse
        m.top.homeColor = m.unfocusColor
        m.top.moviesColor = m.unfocusColor
        m.top.tvColor = m.unfocusColor
        m.top.settingsColor = m.unfocusColor
        m.top.dotColor = m.unfocusColor
        m.top.labelsVis = false
        m.top.titleVis = false
    end if
end sub

sub changeIndex(delta)
    m.index += delta

    if 0 > m.index then m.index = 0
    if 3 < m.index then m.index = 3

    if 0 = m.index
        m.top.dotTranslation = [14,222]
        highlightLabel(m.homeLabel)
    else if 1 = m.index
        m.top.dotTranslation = [14, 294]
        highlightLabel(m.moviesLabel)
    else if 2 = m.index
        m.top.dotTranslation = [14,369]
        highlightLabel(m.tvLabel)
    else if 3 = m.index
        m.top.dotTranslation = [14,439]
        highlightLabel(m.settingsLabel)
    end if
end sub

sub highlightLabel(labelToHighlight)
    m.homeLabel.color = m.focusColor
    m.moviesLabel.color = m.focusColor
    m.tvLabel.color = m.focusColor
    m.settingsLabel.color = m.focusColor
    labelToHighlight.color = "#FF4422"
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "up" = key
            changeIndex(-1)
            handled = true
        else if "down" = key
            changeIndex(1)
            handled = true
        else if "OK" = key
            
            handled = true
        else if "back" = key
            
            handled = true
        end if
    end if
    return handled
end function