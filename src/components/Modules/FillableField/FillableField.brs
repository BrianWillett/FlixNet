sub init()
    m.name = m.top.findNode("name")
    m.underscore = m.top.findNode("underscore")
    m.error = m.top.findNode("error")
    m.focusedColor = "#111177"
    m.unfocusedColor = "#ffffff"
end sub

sub handleFocus()
    if m.top.focused
        m.underscore.color = m.focusedColor
    else
        m.underscore.color = m.unfocusedColor
    end if
end sub

sub displayError()
    if m.top.errored
        if "email" = m.top.id
            m.error.text = "Enter a valid e-mail address"
        else if "password" = m.top.id
            m.error.text = "Incorrect password"
        end if
        m.error.visible = true
    else
        m.error.visible = false
    end if
end sub