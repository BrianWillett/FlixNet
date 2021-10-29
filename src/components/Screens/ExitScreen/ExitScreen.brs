sub init()
    m.exit = m.top.findNode("exit")
    m.cancel = m.top.findNode("cancel")
    m.btnFocusColor = "#FFFFFF"
    m.buttonUnfocusColor = "#112244"
    onOpen({})
end sub

sub onOpen(params)
    updateFocus(m.cancel)
end sub

sub updateFocus(btnToFocus)
    if m.exit.id = btnToFocus.id
        m.cancel.bgColor = m.buttonUnfocusColor
        m.cancel.textColor = "#FFFFFF"
        m.exit.bgColor = m.btnFocusColor
        m.exit.textColor = "#000000"
    else if m.cancel.id = btnToFocus.id
        m.cancel.bgColor = m.buttonFocusColor
        m.cancel.textColor = "#000000"
        m.exit.bgColor = m.buttonUnfocusColor
        m.exit.textColor = "#FFFFFF"
    end if
    btnToFocus.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "left" = key
            if m.cancel.isInFocusChain() then updateFocus(m.exit)
            handled = true
        else if "right" = key
            if m.exit.isInFocusChain() then updateFocus(m.cancel)
            handled = true
        else if "OK" = key
            if m.cancel.isInFocusChain()
                m.global.screenManager.callFunc("goBack",{closeCurrent: true})
            else if m.exit.isInFocusChain()
                m.global.exitApp = true
            end if
            handled = true
        else if "back" = key
            m.global.screenManager.callFunc("goBack",{closeCurrent: true})
            handled = true
        end if
    end if
    return handled
end function