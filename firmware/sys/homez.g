; homez.g
; called to home the Z axis

echo "Homing Z..."

if sensors.gpIn[3].value = 0
  abort "Tool 0 is not docked"

G91                  ; Relative mode
G1 H2 Z5 F5000       ; Lower the bed
G90                  ; Back to absolute positioning
G1 X150 Y100 F50000  ; Position the endstop above the bed centre

M558 F1000
G30
M558 F300
G30

echo "Homing Z... Done"