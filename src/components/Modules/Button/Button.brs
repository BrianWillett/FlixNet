sub init()
    m.bg = m.top.findNode("bg")
    m.label = m.top.findNode("label")
end sub

sub adjustWidth()
    m.bg.width = m.top.bgWidth
    m.label.width = m.top.bgWidth
end sub

sub adjustHeight()
    m.bg.height = m.top.bgHeight
    m.label.height = m.top.bgHeight
end sub

sub handleAction()
    if m.top.execute
        if "exitApp" = m.top.action
            m.global.exitApp = true
        end if
        'reset the button
        m.top.execute = false
    end if
end sub