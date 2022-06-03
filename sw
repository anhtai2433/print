## *** THINGS TO CHANGE/CHECK: ***
## MCU paths                         	[mcu] section
## Thermistor types                      [extruder] and [heater_bed] sections - See 'sensor types' list at end of file
## PID tune                              [extruder] and [heater_bed] sections
## Fine tune E steps                     [extruder] section

## For wiring directions please see https://docs.vorondesign.com/build/electrical/sw_miniE3_v20_wiring.html

## Webclient config files. Uncomment one depending on UI being used.
#[include mainsail.cfg]
[include fluidd.cfg] 

[printer]
kinematics: corexz
max_velocity: 200
max_accel: 1000
max_z_velocity: 50
max_z_accel: 1000
square_corner_velocity: 4.0

[mcu]
###Change to device found by "ls -l /dev/serial/by-id/" with just one this MCU connected to Pi
serial: /dev/serial/by-id/usb-Klipper_lpc1768_12345-if00

#####################################################################
# 	X Stepper Settings
#####################################################################
[stepper_x]
step_pin: P2.2
dir_pin: P2.6
enable_pin: !P2.1
microsteps: 64
rotation_distance: 40
full_steps_per_rotation: 200
endstop_pin: ^P1.29
position_endstop: 215
position_min: 0
position_max: 215
homing_speed: 70
homing_positive_dir: true

[tmc2208 stepper_x]
uart_pin: P1.10
interpolate: True
run_current: 0.6
hold_current: 0.6
sense_resistor: 0.110
stealthchop_threshold: 0

#####################################################################
#   Y Stepper Settings
#####################################################################
[stepper_y]
step_pin: P0.19
dir_pin: P0.20
enable_pin: !P2.8
microsteps: 64
rotation_distance: 40
full_steps_per_rotation: 200
endstop_pin: ^P1.28
position_endstop: 0
position_min: 0
position_max: 220
homing_speed: 70
homing_positive_dir: false

[tmc2208 stepper_y]
uart_pin: P1.9
interpolate: True
run_current: 0.6
hold_current: 0.6
sense_resistor: 0.110
stealthchop_threshold: 0

#####################################################################
# 	Z Stepper Settings
#####################################################################
[stepper_z]
step_pin: P1.15
dir_pin: P1.14
enable_pin: !P1.16
microsteps: 64
rotation_distance: 40
full_steps_per_rotation: 200
endstop_pin: ^P1.27
#endstop_pin: probe:z_virtual_endstop
position_endstop: 0.0
position_max: 250
homing_speed: 40
position_min: -5.0

[tmc2208 stepper_z]
uart_pin: P1.1
interpolate: True
run_current: 0.6
hold_current: 0.6
sense_resistor: 0.110
stealthchop_threshold: 0
#####################################################################
#   Extruder Settings
#####################################################################
[extruder]
step_pin: P2.13
dir_pin: P0.11
enable_pin: !P2.12
microsteps: 64
gear_ratio: 7.5:1
rotation_distance: 33.5
nozzle_diameter: 0.400
filament_diameter: 1.750
full_steps_per_rotation: 200
heater_pin: P2.7
sensor_type: EPCOS 100K B57560G104F
sensor_pin: P0.24
#control: pid
#pid_Kp: 22.2
#pid_Ki: 1.08
#pid_Kd: 114
min_temp: 0
max_temp: 260

[tmc2208 extruder]
uart_pin: P1.4
run_current: 0.800
stealthchop_threshold: 0


#####################################################################
# 	Bed Heater
#####################################################################
[heater_bed]
heater_pin: P2.5
sensor_type: EPCOS 100K B57560G104F
sensor_pin: P0.23
#control: pid
#pid_Kp: 54.027
#pid_Ki: 0.770
#pid_Kd: 948.182
min_temp: -100
max_temp: 130

#####################################################################
# 	Probe
#####################################################################

######
#Z Max Connector on Z(main) Board
#Inductive Probe
###############
[probe]
##      If your probe is NO instead of NC, add change pin to !z:P1.24
pin: ^!P2.0
x_offset: 0
y_offset: 25
#z_offset: 0
speed: 15
samples: 3
samples_result: median
sample_retract_dist: 3
samples_tolerance: 0.05
samples_tolerance_retries: 3
#####################################################################
# 	Fan Control
#####################################################################
[fan]
pin: P2.3


#####################################################################
#   Homing and Bed Mesh
#####################################################################
[homing_override]
axes: z
set_position_z: 0
gcode:
    G90
    G0 Z5 F500
    G28 X0 Y0
    G0 X125 Y100 F9000
    G28 Z0
    G0 Z5 F500

    
[bed_mesh]
speed: 150
horizontal_move_z: 5
mesh_min: 25,35.0
mesh_max: 210.0,210
probe_count: 6,6
algorithm: bicubic
fade_start: 1
fade_end: 10
fade_target: 0

########################################
# EXP1 / EXP2 (display) pins
########################################


# This section is used for a Creality "12864" display with a single
# ribbon cable between the display's EXP3 plug and the
# micro-controller board's EXP1 connector.

[display]
lcd_type: st7920
cs_pin: P1.22
sclk_pin: P1.21
sid_pin: P1.23
encoder_pins: ^P1.20, ^P1.18
click_pin: ^!P0.28

#[output_pin beeper]
#pin: P0.17

# See the sample-lcd.cfg file for definitions of common LCD displays.

#####################################
#       END INSTRUCTRUCTIONS        #
#####################################


#$[neopixel sb_leds]
#pin: P1.24
#   The pin connected to the neopixel. This parameter must be provided.
#chain_count: 3
#   The number of Neopixel chips that are "daisy chained" to the
#   provided pin. The default is 1 (which indicates only a single
#   Neopixel is connected to the pin).
#color_order: GRBW
#   Set the pixel order required by the LED hardware. Options are GRB,
#   RGB, GRBW, or RGBW. The default is GRB.
#initial_RED: 1.0
#initial_GREEN: 1.0
#initial_BLUE: 1.0
#initial_WHITE: 1.0
#   Sets the initial LED color of the Neopixel. Each value should be
#   between 0.0 and 1.0. The WHITE option is only available on RGBW
#   LEDs. The default for each color is 0.#
[neopixel my_neopixel]
#    To control Neopixel RGB in mini12864 display
pin: P1.24
chain_count: 3
initial_RED: 1.0
initial_GREEN: 1.0
initial_BLUE: 1.0
#color_order_GRB: False
# Most configuration for the macros can be done by modifying the variables in the _sb_vars macro
# at the start of this file.

##########
# MACROS #
##########

# The following status macros are available (these go inside of your macros):
#
#    STATUS_READY
#    STATUS_OFF
#    STATUS_BUSY
#    STATUS_HEATING
#    STATUS_LEVELING
#    STATUS_HOMING
#    STATUS_CLEANING
#    STATUS_MESHING
#    STATUS_CALIBRATING_Z
#
# With additional macros for basic control:
#
   # SET_NOZZLE_LEDS_ON
   # SET_LOGO_LEDS_OFF
   #SET_NOZZLE_LEDS_OFF
#
# Contributed by Voron discord users wile.e, Tetsunosuke, and etherwalker


[gcode_macro _sb_vars]
# User settings for the StealthBurner status leds. You can change the status colors and led
# configurations for the logo and nozzle here.
variable_colors: {
        'logo': { # Colors for logo states
            'busy': {'r': 0.4, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'cleaning': {'r': 0.0, 'g': 0.02, 'b': 0.5, 'w': 0.0},
            'calibrating_z': {'r': 0.8, 'g': 0., 'b': 0.35, 'w': 0.0},
            'heating': {'r': 0.3, 'g': 0.18, 'b': 0.0, 'w': 0.0},
            'homing': {'r': 0.0, 'g': 0.6, 'b': 0.2, 'w': 0.0},
            'leveling': {'r': 0.5, 'g': 0.1, 'b': 0.4, 'w': 0.0},
            'meshing': {'r': 0.2, 'g': 1.0, 'b': 0.0, 'w': 0.0},
            'off': {'r': 0.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'printing': {'r': 1.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'standby': {'r': 0.01, 'g': 0.01, 'b': 0.01, 'w': 0.1},
        },
        'nozzle': { # Colors for nozzle states
            'heating': {'r': 0.8, 'g': 0.35, 'b': 0.0, 'w':0.0},
            'off': {'r': 0.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'on': {'r': 0.8, 'g': 0.8, 'b': 0.8, 'w':1.0},
            'standby': {'r': 0.6, 'g': 0.0, 'b': 0.0, 'w':0.0},
        },
        'thermal': {
            'hot': {'r': 1.0, 'g': 0.0, 'b': 0.0, 'w': 0.0},
            'cold': {'r': 0.3, 'g': 0.0, 'b': 0.3, 'w': 0.0}
        }
    }
variable_logo_led_name:         "sb_leds" 
# The name of the addressable LED chain that contains the logo LED(s)
variable_logo_idx:              "1" 
# A comma-separated list of indexes LEDs in the logo
variable_nozzle_led_name:       "sb_leds"
# The name of the addressable LED chain that contains the nozzle LED(s). This will
# typically be the same LED chain as the logo.
variable_nozzle_idx:            "2,3"
# A comma-separated list of indexes of LEDs in the nozzle
gcode:
    # This section is required.  Do Not Delete.


[gcode_macro _set_sb_leds]
gcode:
    {% set red = params.RED|default(0)|float %}
    {% set green = params.GREEN|default(0)|float %}
    {% set blue = params.BLUE|default(0)|float %}
    {% set white = params.WHITE|default(0)|float %}
    {% set led = params.LED|string %}
    {% set idx = (params.IDX|string).split(',') %}
    {% set transmit_last = params.TRANSMIT|default(1) %}

    {% for led_index in idx %}
        {% set transmit=transmit_last if loop.last else 0 %}
        set_led led={led} red={red} green={green} blue={blue} white={white} index={led_index} transmit={transmit}
    {% endfor %}

[gcode_macro _set_sb_leds_by_name]
gcode:
    {% set leds_name = params.LEDS %}
    {% set color_name = params.COLOR %}
    {% set color = printer["gcode_macro _sb_vars"].colors[leds_name][color_name] %}
    {% set led = printer["gcode_macro _sb_vars"][leds_name + "_led_name"] %}
    {% set idx = printer["gcode_macro _sb_vars"][leds_name + "_idx"] %}
    {% set transmit = params.TRANSMIT|default(1) %}

    _set_sb_leds led={led} red={color.r} green={color.g} blue={color.b} white={color.w} idx="{idx}" transmit={transmit}

[gcode_macro _set_logo_leds]
gcode:
    {% set red = params.RED|default(0)|float %}
    {% set green = params.GREEN|default(0)|float %}
    {% set blue = params.BLUE|default(0)|float %}
    {% set white = params.WHITE|default(0)|float %}
    {% set led = printer["gcode_macro _sb_vars"].logo_led_name %}
    {% set idx = printer["gcode_macro _sb_vars"].logo_idx %}
    {% set transmit=params.TRANSMIT|default(1) %}

    _set_sb_leds led={led} red={red} green={green} blue={blue} white={white} idx="{idx}" transmit={transmit}

[gcode_macro _set_nozzle_leds]
gcode:
    {% set red = params.RED|default(0)|float %}
    {% set green = params.GREEN|default(0)|float %}
    {% set blue = params.BLUE|default(0)|float %}
    {% set white = params.WHITE|default(0)|float %}
    {% set led = printer["gcode_macro _sb_vars"].nozzle_led_name %}
    {% set idx = printer["gcode_macro _sb_vars"].nozzle_idx %}
    {% set transmit=params.TRANSMIT|default(1) %}

    _set_sb_leds led={led} red={red} green={green} blue={blue} white={white} idx="{idx}" transmit={transmit}

[gcode_macro set_logo_leds_off]
gcode:
    {% set transmit=params.TRANSMIT|default(1) %}
    _set_logo_leds red=0 blue=0 green=0 white=0 transmit={transmit}

[gcode_macro set_nozzle_leds_on]
gcode:
    {% set transmit=params.TRANSMIT|default(1) %}
    _set_sb_leds_by_name leds="nozzle" color="on" transmit={transmit}

[gcode_macro set_nozzle_leds_off]
gcode:
    {% set transmit=params.TRANSMIT|default(1) %}
    _set_sb_leds_by_name leds="nozzle" color="off" transmit={transmit}

[gcode_macro status_off]
gcode:
    set_logo_leds_off transmit=0
    set_nozzle_leds_off

[gcode_macro status_ready]
gcode:
    _set_sb_leds_by_name leds="logo" color="standby" transmit=0
    _set_sb_leds_by_name leds="nozzle" color="standby" transmit=1

[gcode_macro status_busy]
gcode:
    _set_sb_leds_by_name leds="logo" color="busy" transmit=0
    set_nozzle_leds_on

[gcode_macro status_heating]
gcode:
    _set_sb_leds_by_name leds="logo" color="heating" transmit=0
    _set_sb_leds_by_name leds="nozzle" color="heating" transmit=1

[gcode_macro status_leveling]
gcode:
    _set_sb_leds_by_name leds="logo" color="leveling" transmit=0
    set_nozzle_leds_on

[gcode_macro status_homing]
gcode:
    _set_sb_leds_by_name leds="logo" color="homing" transmit=0
    set_nozzle_leds_on

[gcode_macro status_cleaning]
gcode:
    _set_sb_leds_by_name leds="logo" color="cleaning" transmit=0
    set_nozzle_leds_on

[gcode_macro status_meshing]
gcode:
    _set_sb_leds_by_name leds="logo" color="meshing" transmit=0
    set_nozzle_leds_on

[gcode_macro status_calibrating_z]
gcode:
    _set_sb_leds_by_name leds="logo" color="calibrating_z" transmit=0
    set_nozzle_leds_on

[gcode_macro status_printing]
gcode:
    _set_sb_leds_by_name leds="logo" color="printing" transmit=0
    set_nozzle_leds_on

#####################################################################
# 	Macros Gcode
#####################################################################
[gcode_macro RCBC]
gcode:
 
   G28
     BED_MESH_CALIBRATE

#*# <---------------------- SAVE_CONFIG ---------------------->
#*# DO NOT EDIT THIS BLOCK OR BELOW. The contents are auto-generated.
#*#
#*# [heater_bed]
#*# control = pid
#*# pid_kp = 73.904
#*# pid_ki = 1.584
#*# pid_kd = 861.902
#*#
#*# [extruder]
#*# control = pid
#*# pid_kp = 19.468
#*# pid_ki = 0.908
#*# pid_kd = 104.398
#*#
#*# [probe]
#*# z_offset = 1.300
#*#
#*# [bed_mesh default]
#*# version = 1
#*# points =
#*# 	  -1.121875, -1.209375, -1.240625, -1.250000, -1.221875, -1.103125
#*# 	  -1.137500, -1.234375, -1.262500, -1.256250, -1.256250, -1.131250
#*# 	  -1.150000, -1.253125, -1.278125, -1.293750, -1.303125, -1.228125
#*# 	  -1.153125, -1.234375, -1.271875, -1.278125, -1.290625, -1.218750
#*# 	  -1.146875, -1.221875, -1.237500, -1.256250, -1.259375, -1.200000
#*# 	  -1.225000, -1.275000, -1.271875, -1.262500, -1.243750, -1.093750
#*# tension = 0.2
#*# min_x = 25.0
#*# algo = bicubic
#*# y_count = 6
#*# mesh_y_pps = 2
#*# min_y = 35.0
#*# x_count = 6
#*# max_y = 210.0
#*# mesh_x_pps = 2
#*# max_x = 210.0
