sub init()
    m.collapse = "pkg:/assets/images/navigation/collapsed.png"
    m.expand = "pkg:/assets/images/navigation/expanded.png"
    m.focusColor = "#FFFFFF"
    m.unfocusColor = "#555555"
    m.index = 0
    m.labelGroup = m.top.findNode("labelGroup")
    m.icons = m.top.findNode("isCollapsed")
end sub

sub handleExpansion()
    changeIndex(0)
    if m.top.expanded
        m.top.navWidth = 400
        m.top.navBG = m.expand
        changeIconColor(m.focusColor)
        m.top.dotColor = m.focusColor
        m.top.labelsVis = true
        m.top.titleVis = true
    else
        m.top.navWidth = 100
        m.top.navBG = m.collapse
        changeIconColor(m.unfocusColor)
        m.top.dotColor = m.unfocusColor
        m.top.labelsVis = false
        m.top.titleVis = false
    end if
end sub

sub changeIconColor(color)
    children = m.icons.getChildren(-1,0)
    for i = 0 to children.count() -1 step 1
        children[i].blendColor = color
    end for
end sub

sub changeIndex(delta)
    m.index += delta
    children = m.labelGroup.getChildren(-1,0)
    numOptions = children.count() - 1

    if 0 > m.index then m.index = 0
    if numOptions < m.index then m.index = 3

    yValue = 205
    m.top.dotTranslation = [10, (yValue + (m.index * 75))]
    highlightLabel(m.index)
end sub

sub highlightLabel(labelToHighlight)
    children = m.labelGroup.getChildren(-1,0)
    for i = 0 to children.count() - 1 step 1
        if labelToHighlight = i
            children[i].color = "#FF4422"
            children[i].setFocus(true)
        else
            children[i].color = m.focusColor
        end if
    end for
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
            currScreen = m.global.screenManager.callFunc("getCurrentScreen")
            if m.labelGroup.focusedChild.id <> currScreen.id
                if "LoginScreen" = m.labelGroup.focusedChild.id
                    logOut()
                    m.global.screenManager.callFunc("goToScreen",{type:m.labelGroup.focusedChild.id,closeCurrent: true})
                else
                    m.global.screenManager.callFunc("goToScreen",{type:m.labelGroup.focusedChild.id})
                end if
                handled = true
            else
                handled = false
            end if
        end if
    end if
    return handled
end function