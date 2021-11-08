function getValueFromKey(key)
    value = invalid
    if invalid <> key and "" <> key
        file = ReadAsciiFile("pkg:/keys")
        'split it into lines
        file = file.split(chr(10))
        for each line in file
            line = line.split("=")
            if key = line[0]
                value = line[1]
            end if
        end for
    end if
    return value
end function

function removeWhiteSpace(theString)
    rgx = createObject("roRegex", " ", "i")
    return rgx.ReplaceAll(theString, "")
end function

function logIn()
    authSec = CreateObject("roRegistrySection", "Authentication")
    authSec.write("LoggedIn","true")
    authSec.flush()
    return true
end function

function checkLoggedIn()
    authSec = createObject("roRegistrySection","Authentication")
    if authSec.Exists("LoggedIn")
        if "true" = authSec.read("LoggedIn")
            return true
        end if
    end if
    return false
end function

sub logOut()
    authSec = createObject("roRegistrySection","Authentication")
    if authSec.Exists("LoggedIn")
        if "true" = authSec.read("LoggedIn")
            authSec.Delete("LoggedIn")
            authSec.flush()
        end if
    end if
end sub