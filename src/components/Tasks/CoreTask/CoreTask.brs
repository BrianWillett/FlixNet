sub init()
    m.top.functionName = "directFlow"
    m.messagePort = createObject("roMessagePort")
    m.top.observeField("params",m.messagePort)
end sub

sub directFlow()
    'wait for params to hit the port
    msg = wait(0,m.messagePort)
    'send it to the do work function
    if "roSGNodeEvent" = type(msg)
        doWork(msg.getData())
    end if
end sub

sub doWork(params)
    'stub
end sub

function sendRequest(httpObject, port)
    'stub
end function