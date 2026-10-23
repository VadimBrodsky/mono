## Configuration

### Monitors
To get the list of monitors
```shell
hyprctl monitors
```
To configure the monitors `.config/hypr/monitors.conf`
```
# Straight 1x setup for low-resolution displays like 1080p or 1440p
env = GDK_SCALE,1
monitor=,preferred,auto,1

# to see the connected monitors
# hyprctl monitors all

# ARZOPA portable monitor
monitor = desc:GWD ARZOPA 000000000001, highrr, auto-down, 1.2
# Alienware monitor
monitor = desc:Dell Inc. AW3423DWF HF742S3, 3440x1440@120.00, auto-up, 1.25
# Gigabyte monitor
monitor = desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27Q 20120B000001, 2560x1440@169.83Hz, auto-up, 1.25
```

### Input
To configure the keyboard `.config/hypr/input.conf`
```
# swaps alt and super
kb_options = compose:caps,altwin:swap_alt_win
```