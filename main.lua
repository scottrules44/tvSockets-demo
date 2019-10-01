local tvSockets = require "plugin.tvSockets"
local json = require "json"
local widget= require "widget"

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 0,0,.5 )

local title = display.newText( "Tv Sockets Plugin", display.contentCenterX, 40, native.systemFontBold, 20 )
local scottSocket
local openScottSocket = display.newText( "Click button on remote to open Scott Socket and Send Data", display.contentCenterX, display.contentCenterY, native.systemFont, 12 )
local function onKeyEvent( event )
    
    if event.phase =="up" and event.keyName =="buttonA" then
        openScottSocket.alpha = .5
        timer.performWithDelay(500, function()
            openScottSocket.alpha = 1
        end )
        scottSocket = tvSockets.connect("wss://sockets.platopus.tv/alpha?auth=scott", function(e)
            print(json.encode(e))
        end)
        tvSockets.send(scottSocket, "Hello World")
    end
    
end

Runtime:addEventListener( "key", onKeyEvent )
