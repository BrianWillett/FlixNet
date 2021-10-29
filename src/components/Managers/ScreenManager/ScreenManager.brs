sub init()
    'get the scenegraph scene
    m.scene = m.top.getScene()
    if invalid <> m.scene
        'find the screens group, this is where each screen will be added to
        m.screens =  m.scene.findNode("screens")
        if invalid = m.screens
            'if screens group doesn't exist, add it
            m.screens = createObject("roSGNode","Group")
            m.screens.id = "screens"
            m.scene.appendChild(m.screens)
        end if
    end if
    m.currentScreen = invalid
    m.prevScreens = []
end sub

sub goToScreen(params)
    if invalid <> params and invalid <> params.type
        screenName = params.type
        if invalid <> screenName and "" <> screenName
            'handle if the screen being nav'd away from should go in to the history array
            if invalid <> params.closeCurrent and not params.closeCurrent
                if invalid <> m.currentScreen then m.prevScreens.push(m.currentScreen)
            end if
            'hide the currently shown screen
            if invalid <> m.currentScreen then m.currentScreen.visible = false
            'set up new screen
            navToScreen = CreateObject("roSGNode",screenName)
            navToScreen.id = screenName
            'set as the new current screen
            m.currentScreen = navToScreen
            'add to the screens group
            m.screens.appendChild(m.currentScreen)
            'make it visible and focused to display
            m.currentScreen.visible = true
            m.currentScreen.setFocus(true)
            'nav to it depending on if there are params to pass
            if invalid <> params.data
                m.currentScreen.callFunc("onOpen",{data: params.data})
            else
                m.currentScreen.callFunc("onOpen",{})
            end if
        end if
    end if
end sub

sub goBack(params)
    
end sub