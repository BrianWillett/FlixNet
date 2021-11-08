sub init()
    m.released = m.top.findNode("released")
    m.bg = m.top.findNode("poster")
    m.spinner = m.top.findNode("spinner")
end sub

sub formatReleaseDate()
    dateString = m.top.releaseDate
    if invalid <> dateString and "" <> dateString
        dateString = dateString.split("-")
        m.released.text = "(" + dateString[0] + ")"
    end if
end sub

sub loadPoster()
    m.bg.observeField("loadStatus","onStatusChange")
end sub

sub onStatusChange()
    if "ready" = m.bg.loadStatus or "failed" = m.bg.loadStatus
        m.spinner.visible = false
        m.spinner.control = "stop"
        m.bg.unobserveField("loadStatus")
    else if "loading" = m.bg.loadStatus
        m.spinner.control = "start"
        m.spinner.visible = true
    end if
end sub