# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import datetime
import os
import subprocess
from typing import List  # noqa: F401

import psutil
from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger

try:
    import yaml
    with open(os.path.join(os.path.basename(__file__), "local_config.yaml")) as fp:
        local_config = yaml.safe_load(fp)
except Exception as e:
    logger.warning("Local config could not be loaded, using defaults from dotfile!"+str(e))
    local_config = {}

def get_local_or_default_config(config: dict, key: str, default):
    if key in config:
        return config[key]
    else:
        return default

# mod = "mod4"  # left-super
mod = get_local_or_default_config(local_config, "mod", "mod1")  # left-alt
terminal = guess_terminal()

# GNOME startup hook


@hook.subscribe.startup
def dbus_register():
    id = os.environ.get('DESKTOP_AUTOSTART_ID')
    if not id:
        return
    subprocess.Popen(['dbus-send',
                      '--session',
                      '--print-reply',
                      '--dest=org.gnome.SessionManager',
                      '/org/gnome/SessionManager',
                      'org.gnome.SessionManager.RegisterClient',
                      'string:qtile',
                      'string:' + id])


def get_num_monitors():
    num_monitors = 0
    try:
        from Xlib import display as xdisplay
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(
                output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        logger.exception(e)
        return 1
    else:
        return num_monitors


num_monitors = get_num_monitors()

# layout dependent functions


def mod_h():
    @lazy.function
    def _inner(qtile):
        if qtile.current_layout.name == "stack":
            qtile.current_layout.cmd_previous()
        else:
            qtile.current_layout.left()

    return _inner


keys = [
    # Switch between windows
    Key([mod], "h",
        # lazy.layout.left(),
        lazy.layout.left(),
        desc="Move focus to left"),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # default for kill is 'w' but q is the default in i3 and q for quit reasonable
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    # Function key bindings TODO not working yet
    # Key(["function"], "F10",
    #     lambda:subprocess.call("amixer -q sset Master 5%-"),
    #     desc="Reduce Master volume by 5%."),
    # Key(["function"], "F11",
    #     lambda:subprocess.call("amixer -q sset Master 5%+"),
    #     desc="Increase Master volume by 5%."),
]


# rename groups, define default layouts
groups = [Group(i) for i in "asdfuiop"]
group_names = [
    ("DEV", {"layout": "monadcode"}),  # coding
    ("COM", {"layout": "matrix"}),     # communication
    ("DOC", {"layout": "monadtall"}),  # writing
    ("MUS", {"layout": "matrix"}),     # music
    ("VID", {"layout": "fullstack"}),  # video
    ("SYS", {"layout": "monadtall"}),  # sysadmin
    ("VIR", {"layout": "monadtall"}),  # virtualization
    ("REM", {"layout": "monadtall"}),  # remote
    ("GFX", {"layout": "floating"}),   # graphical
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    # Send current window to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))


layout_theme = {"border_width": 2,
                "margin": 6,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }


class MyStack(layout.Stack):
    """
    Simply add left/right to Stack so hjkl works similar to other layouts.
    """

    def cmd_left(self):
        self.cmd_previous()

    def cmd_right(self):
        self.cmd_next()

    # TODO shuffle left/right sometimes causes graphical glitches
    # TODO find a way to trigger a redraw of the entire screen
    def cmd_shuffle_left(self):
        # self.cmd_swap_left()
        self.cmd_client_to_previous()

    def cmd_shuffle_right(self):
        self.cmd_client_to_next()

    # TODO maybe implement swap left/right
    def cmd_swap_left(self):
        self.cmd_swap_clients(self.current_stack_offset - 1)

    def cmd_swap_right(self):
        self.cmd_swap_clients(self.current_stack_offset + 1)

    def cmd_swap_clients(self, n):
        # TODO not yet working, looses windows somehow it seems
        if not self.current_stack:
            return
        target = n % len(self.stacks)  # id of target stack
        curr_win = self.current_stack.current_client
        self.current_stack.remove(curr_win)
        neighbor_win = self.stacks[target].current_client
        self.stacks[target].remove(neighbor_win)
        self.current_stack.add(neighbor_win)
        self.stacks[target].add(curr_win)
        self.stacks[target].focus(curr_win)
        self.group.layout_all()


layouts = [
    layout.MonadTall(name="monadcode", ratio=0.75, align=1, **layout_theme),
    MyStack(name="stack", num_stacks=3, **layout_theme),
    MyStack(num_stacks=1, name="fullstack", **layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Floating(**layout_theme),
    layout.TreeTab(**layout_theme),
    layout.Matrix(**layout_theme),
    # layout.Stack(name="stack", **layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(border_focus_stack='#d75f5f', **layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Max(**layout_theme),
    # layout.Bsp(),
    # layout.MonadWide(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='DejaVu Sans Mono',
    # font='DejaVu Serif',
    fontsize=12,
    padding=3,
)

# This does nothing, I guess?
extension_defaults = widget_defaults.copy()

main_screen_widgets = [
    widget.CurrentLayout(fmt="{:<9}", **widget_defaults),
    widget.GroupBox(**widget_defaults),
    widget.Prompt(**widget_defaults),
    widget.WindowName(**widget_defaults),
    widget.Chord(
        chords_colors={
            'launch': ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    widget.Notify(**widget_defaults),
    widget.Systray(**widget_defaults),
    widget.Volume(
        volume_app="pavucontrol",
        **widget_defaults),
    widget.Net(format='{down} ↓↑ {up}', **widget_defaults),
    widget.Clock(format="%a %Y-%m-%d %H:%M:%S", **widget_defaults),
    widget.QuickExit(**widget_defaults),
]


screens = [
    Screen(
        top=bar.Bar(main_screen_widgets,
                    24,
                    ),
    ),
]

logger.warning("Num Monitors is "+str(num_monitors))

if num_monitors > 1:
    for m in range(num_monitors - 1):
        screens.append(
            Screen(
                top=bar.Bar(
                    main_screen_widgets,  # other screens widgets
                    24,
                ),
            )
        )

# swallow processes spawned from terminals


@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {c.window.get_net_wm_pid(): wid for wid,
             c in window.qtile.windows_map.items()}
    for i in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            if parent.window.get_wm_class()[0] != terminal:
                return
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()


@hook.subscribe.client_killed
def _unswallow(window):
    if hasattr(window, 'parent'):
        # TODO maybe add distinction here as well?
        # check this if closing windows changes layouts weirdly
        window.parent.minimized = False


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"


floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(title='branchdialog'),  # gitk
    Match(title='confirm'),
    Match(title='confirmreset'),  # gitk
    Match(title='dialog'),
    Match(title='download'),
    Match(title='error'),
    Match(title='file_progress'),
    Match(title='makebranch'),  # gitk
    Match(title='maketag'),  # gitk
    Match(title='notification'),
    Match(title='pinentry'),  # GPG key password entry
    Match(title='splash'),
    Match(title='ssh-askpass'),  # ssh-askpass
    Match(title='toolbar'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
