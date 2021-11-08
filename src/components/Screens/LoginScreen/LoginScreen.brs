sub init()
    m.email = m.top.findNode("email")
    m.password = m.top.findNode("password")
    m.signIn = m.top.findNode("signIn")
    m.signUp = m.top.findNode("signUp")
    m.logIn = m.top.findNode("logIn")
    m.logIn = m.top.findNode("logIn")
    m.keyboard = m.top.findNode("keyboard")
    m.keyboardpass = m.top.findNode("keyboardpass")
    m.savedPass = invalid
    m.store = createObject("roSGNode","ChannelStore")
    m.store.requestedUserData = "email, firstname, lastname"
    m.info = CreateObject("roSGNode", "ContentNode")
    m.info.addFields({context: "signin"})
    m.loginGroup = m.top.findNode("loginGroup")
    m.btnGroup = m.top.findNode("buttonGroup")
    m.data = invalid
end sub


sub onOpen(params)
    if invalid <> params and invalid <> params.data then m.data = params.data
    m.loginGroup.visible = false
    changeFocus(m.signIn)
    m.savedPass = invalid
    m.keyboard.buttons= ["Ok","Clear"]
    m.keyboardpass.buttons= ["Ok","Clear"]
    m.keyboard.title = "Enter E-mail"
    m.keyboardpass.title = "Enter Password"
    m.keyboard.observeField("buttonSelected","handleClick")
    m.keyboardpass.observeField("buttonSelected","handleClick")
end sub

sub changeFocus(fieldToFocus)
    if "email" = fieldToFocus.id
        m.email.setFocus(true)
        m.email.focused = true
        m.signIn.focused = false
        m.password.focused = false
        m.signUp.focused = false
        m.logIn.focused = false
    else if "password" = fieldToFocus.id
        m.password.setFocus(true)
        m.password.focused = true
        m.email.focused = false
        m.signIn.focused = false
        m.signUp.focused = false
        m.logIn.focused = false
    else if "signIn" = fieldToFocus.id
        m.signIn.setFocus(true)
        m.signIn.focused = true
        m.password.focused = false
        m.signUp.focused = false
        m.email.focused = false
        m.logIn.focused = false
    else if "signUp" = fieldToFocus.id
        m.signUp.setFocus(true)
        m.signUp.focused = true
        m.signIn.focused = false
        m.password.focused = false
        m.email.focused = false
        m.logIn.focused = false
    else if "logIn" = fieldToFocus.id
        m.logIn.setFocus(true)
        m.login.focused = true
        m.signIn.focused = false
        m.password.focused = false
        m.email.focused = false
        m.signUp.focused = false
    end if
end sub

sub handleClick(event)
    selection = event.getData()
    if m.keyboard.visible
        if 0 = selection
            m.email.fieldName = m.keyboard.text
            if "" <> removeWhiteSpace(m.keyboard.text) then m.email.errored = false
            if "Password" = m.password.fieldName
                m.keyboard.visible = false
                m.keyboardpass.visible = true
                m.keyboardpass.setFocus(true)
            else
                m.keyboard.visible = false
                changeFocus(m.logIn)
            end if
        else if 1 = selection
            m.keyboard.text = ""
        end if
    else if m.keyboardpass.visible
        if 0 = selection
            m.savedPass = m.keyboardpass.text
            if "" <> removeWhiteSpace(m.keyboardpass.text) then m.password.errored = false
            replacement = ""
            for i = 0 to m.savedPass.len() - 1 step 1
                replacement += "*"
            end for
            m.password.fieldName = replacement
            if "E-mail" = m.email.fieldName
                m.keyboardpass.visible = false
                m.keyboard.visible = true
                m.keyboard.setFocus(true)
            else
                m.keyboardpass.visible = false
                changeFocus(m.logIn)
            end if
        else if 1 = selection
            m.keyboardpass.text = ""
        end if
    end if
end sub

sub requestRokuData()
    m.info.context = "signUp"
    m.store.requestedUserDataInfo = m.info
    m.store.command = "getUserData"
    m.store.observeField("userData","handleUserSubmission")
end sub

sub requestLoginData()
    switchView(m.loginGroup)
    if "E-mail" <> m.email.fieldName and "" <> removeWhiteSpace(m.email.fieldName)
        if "Password" <> m.password.fieldName and "" <> removeWhiteSpace(m.password.fieldName)
            changeFocus(m.logIn)
        else
            changeFocus(m.password)
        end if
    else
        m.info.context = "signIn"
        m.store.requestedUserDataInfo = m.info
        m.store.command = "getUserData"
        m.store.observeField("userData","handleUserSubmission")
    end if
end sub

sub handleUserSubmission(event)
    data = m.store.userData
    m.store.unobserveField("userData")
    if invalid <> data
        writeOut = "User signUping with:  "
        if m.loginGroup.isInFocusChain()
            if invalid <> m.store.requestedUserDataInfo and invalid <> m.store.requestedUserDataInfo.context and "signIn" = m.store.requestedUserDataInfo.context
                writeOut = "Signing in with:  "
                if invalid <> data.email
                    m.email.fieldName = data.email
                    changeFocus(m.password)
                else
                    changeFocus(m.email)
                end if
            end if
        end if
        ?writeOut
        if invalid <> data.firstName and invalid <> data.lastName then ?"Name:  " + data.firstName + " " data.lastName
        if invalid <> data.email then ?"Email:  " + data.email

    else
        ?"User declined to share info, send to signUp screen"
    end if
end sub

sub switchView(groupToView)
    if m.loginGroup.id = groupToView.id
        m.btnGroup.visible = false
        m.email.errored = false
        m.password.errored = false
        changeFocus(m.email)
    else if m.btnGroup.id = groupToView.id
        m.loginGroup.visible = false
        changeFocus(m.signIn)
    end if
    groupToView.visible = true
end sub

function validateForm()
    valid = true
    if m.logIn.isInFocusChain()
        if "E-mail" = m.email.fieldName or "" = removeWhiteSpace(m.email.fieldName)
            m.email.errored = true
            valid = false
        else
            m.email.errored = false
        end if
        if "Password" = m.password.fieldName or "" = removeWhiteSpace(m.password.fieldName)
            m.password.errored = true
            valid = false
        else
            m.password.errored = false
        end if
    end if

    return valid
end function

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if "left" = key
            if m.signUp.isInFocusChain()
                changeFocus(m.signIn)
            end if
            handled = true
        else if "right" = key
            if m.signIn.isInFocusChain()
                changeFocus(m.signUp)
            end if
            handled = true
        else if "up" = key
            if m.password.isInFocusChain()
                changeFocus(m.email)
            else if m.signUp.isInFocusChain()
                changeFocus(m.signIn)
            else if m.logIn.isInFocusChain()
                changeFocus(m.password)
            end if
            handled = true
        else if "down" = key
            if m.email.isInFocusChain()
                changeFocus(m.password)
            else if m.password.isInFocusChain()
                changeFocus(m.logIn)
            else if m.signIn.isInFocusChain()
                changeFocus(m.signUp)
            end if
            handled = true
        else if "OK" = key
            if m.email.isInFocusChain()
                if "E-mail" <> m.email.fieldName and "" <> removeWhiteSpace(m.email.fieldName) then m.keyboard.text = m.email.fieldName
                m.keyboard.visible = true
                m.keyboardpass.visible = false
                m.keyboard.setFocus(true)
            else if m.password.isInFocusChain()
                m.keyboard.visible = false
                m.keyboardpass.visible = true
                m.keyboardpass.setFocus(true)
            else if m.signIn.isInFocusChain()
                requestLoginData()
            else if m.signUp.isInFocusChain()
                requestRokuData()
            else if m.logIn.isInFocusChain()
                if validateForm()
                    if logIn()
                        m.global.screenManager.callFunc("goToScreen",{type: "HomeScreen", data: m.data, closeCurrent: true})
                    end if
                end if
            end if
            handled = true
        else if "back" = key
            if m.loginGroup.visible
                switchView(m.btnGroup)
            else
                m.global.screenManager.callFunc("goBack",{})
            end if
            handled = true
        end if
    end if
    return handled
end function