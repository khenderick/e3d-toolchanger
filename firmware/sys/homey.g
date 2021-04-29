; homey.g
; called to home the y axis

echo "Homing Y..."

if sensors.gpIn[3].value = 0
  abort "Tool 0 is not docked"

G91             ; use relative positioning
G1 H2 Z3 F5000  ; lift Z 3mm

M400                    ; make sure everything has stopped before we change the motor currents
M913 X40 Y40            ; set motor currents to 40%
G1 H1 Y-400 F3000       ; move to the left 400mm, stopping at the endstop
G1 Y2 F2000             ; move away from end
G4 P250

M400                    ; make sure everything has stopped before we change the motor currents
M913 X20 Y20            ; set motor currents to 20%
G1 H1 Y-400 F3000       ; move to the front 400mm, stopping at the endstop
G1 Y2 F2000             ; move away from end
G4 P250

M400            ; make sure everything has stopped before we reset the motor currents
M913 X100 Y100  ; motor currents back to 100%

G1 H2 Z-3 F1200  ; lower Z
G90              ; back to absolute positioning
G1 Y49.6 F15000  ; goto bed Y0
G92 Y0           ; mark as Y0

echo "Homing Y... Done"