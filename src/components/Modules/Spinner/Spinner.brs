sub init()
    m.bg = m.top.findNode("bg")
    m.spinner = m.top.findNode("spinner")
end sub

sub handleSpinner()
    m.top.status = ""
    m.spinner.poster.setFields({
        uri: "pkg:/assets/images/spinner.png",
        width: 150,
        height: 150
    })
    if "start" = m.top.control
        m.bg.visible = true
        m.spinner.visible = true
        m.spinner.control = "start"
    else if "stop" = m.top.control
        m.bg.visible = false
        m.spinner.visible = false
        m.spinner.control = "stop"
    end if
end sub
