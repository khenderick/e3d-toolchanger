; homeall.g
; called to home all axes

echo "Homing all..."

M98 P"homec.g"  ; Home C (ToolHead)
G4 P1000
M98 P"homey.g"  ; Home Y
G4 P1000
M98 P"homex.g"  ; Home X
G4 P1000
M98 P"homez.g"  ; Home Z

G1 X0 Y0 F15000  ; Park

echo "Homing all... Done"