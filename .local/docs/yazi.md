set:
```
# ~/.config/xdg-desktop-portal/portals.conf
[preferred]
org.freedesktop.impl.portal.FileChooser=termfilechooser
```

```
# ~/.config/xdg-desktop-portal-termfilechooser/config
[filechooser]
cmd=yazi-wrapper.sh
default_dir=$HOME/Downloads
open_mode=suggested
save_mode=last
```

restart:
```
systemctl --user restart xdg-desktop-portal.service
systemctl --user restart xdg-desktop-portal-termfilechooser.service
```

for firefox set this (def val == 2):
```
widget.use-xdg-desktop-portal.file-picker = 1
```
