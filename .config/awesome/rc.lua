require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("debian.menu")

vicious = require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
theme.wallpaper_cmd = { "awsetbg /home/remigijus/.desktop_wallpaper.jpg" }

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- Can be useful later:
--    " ➊ ", " ➋ ", " ➌ ", " ➍ ", " ➎  ", " ➏  ", " ➐  ", " ➑  "
tags = {}
s = 1
if screen.count() == 2 then
    tags[1] = awful.tag({ " hacking ", " mail ", " calendar ", " sms ", " music  ", " ➊ ", " ➋ ", " ➌ "}, 1, layouts[1])
    s = 2
end
tags[s] = awful.tag({ " hacking ", " browse ", " ➊ ", " ➋ ", " ➌ "}, s, layouts[1])

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "Restart", awesome.restart },
   { "Quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "Terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = widget({ type = "textbox" })
vicious.register(mytextclock, vicious.widgets.date, "%b %d %A, %H:%M", 1)

-- Create a systray
mysystray = widget({ type = "systray" })

-- Memory widget
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, "$1% mem", 2)

-- CPU widget
cpuwidget = widget({ type = "textbox" })
cpuwidget.width = 49
cpuwidget.align = "center"
vicious.register(cpuwidget, vicious.widgets.cpu, "$1% cpu", 2)

-- Battery
batwidget = widget({ type = "textbox", name = "batwidget" })
vicious.register(batwidget, vicious.widgets.bat, "$2% battery", 60, "BAT0")

-- HDD temp widget
hddtempwidget = widget({ type = "textbox" })
vicious.register(hddtempwidget, vicious.widgets.hddtemp, "${/dev/sda}°C temp", 2)

-- Uptime widget
uptimewidget = widget({ type = "textbox" })
vicious.register(uptimewidget, vicious.widgets.uptime, "$6 load", 1)

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net, "${wlan0 down_kb}kb/s / ${wlan0 up_kb}kb/s", 2)

-- Separator widget
separator = widget({ type = "textbox" })
separator.text = " | "

-- Space widget
spacewidget = widget({ type = "textbox" })
spacewidget.width = 10
spacewidget.text = " "

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

if screen.count() > 1 then
    main_screen = 2
else
    main_screen = 1
end

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            -- mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        spacewidget,
        s == main_screen and mysystray or nil,
        spacewidget,
        s == main_screen and mytextclock or nil,
        -- s == main_screen and separator or nil,
        -- s == main_screen and memwidget or nil,
        -- s == main_screen and separator or nil,
        -- s == main_screen and cpuwidget or nil,
        -- s == main_screen and separator or nil,
        -- s == main_screen and hddtempwidget or nil,
        -- s == main_screen and separator or nil,
        -- s == main_screen and batwidget or nil,
        -- s == main_screen and separator or nil,
        -- s == main_screen and uptimewidget or nil,
        -- s == main_screen and separator or nil,
        -- s == main_screen and netwidget or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run({ prompt = "Run Lua code: " },
    --               mypromptbox[mouse.screen].widget,
    --               awful.util.eval, nil,
    --               awful.util.getdir("cache") .. "/history_eval")
    --           end),

    -- Control music with media keys
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)
                                                 naughty.notify({ title = 'Master', text = tostring(awful.tag.getnmaster()), timeout = 1 }) end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)
                                                 naughty.notify({ title = 'Master', text = tostring(awful.tag.getnmaster()), timeout = 1 }) end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)
                                                 naughty.notify({ title = 'Columns', text = tostring(awful.tag.getncol()), timeout = 1 }) end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)
                                                 naughty.notify({ title = 'Columns', text = tostring(awful.tag.getncol()), timeout = 1 }) end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 2%-") end),
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 2%+") end),
    awful.key({}, "XF86AudioNext",        function () awful.util.spawn("cmus-remote -n" ) end),
    awful.key({}, "XF86AudioPrev",        function () awful.util.spawn("cmus-remote -r" ) end),
    awful.key({}, "XF86AudioMute",        function () awful.util.spawn("bash /home/remigijus/Kodas/skriptai/mute-unmute-alsa-mixer.sh") end),
    awful.key({}, "XF86AudioPlay",        function () awful.util.spawn("cmus-remote -u") end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--
-- -- {{{ Run programs on startup
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("skype")
run_once("parcellite")
run_once("dropbox start")
run_once("numlockx")
run_once("nm-applet")
run_once("deluged")
run_once("gnome-terminal")

awful.hooks.timer.register(300, function ()
    os.execute("awsetbg -r '/home/remigijus/Paveikslėliai/Ekranas'")
end)

os.execute("xset r rate 220 60")
-- }}}
