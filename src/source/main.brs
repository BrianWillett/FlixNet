sub main(params)

  screen = createObject("roSGscreen")
  port = createObject("roMessagePort")
  screen.setMessagePort(port)

  m.global = screen.getGlobalNode()
  m.global.addFields({exitApp: false})

  scene = screen.createScene("Main")
  screen.show() ' vscode_rale_tracker_entry
  'monitor field for graceful app close
  m.global.observeField("exitApp", port)

  while true
      msg = wait(0,port)
      msgType = type(msg)
      if "roSGScreenEvent" = msgType
        if msgType.isScreenClose() then return
      else if "roSGNodeEvent" = msgType
        if "exitApp" = msg.getField() then return
      end if
  end while
end sub