; homec.g
; called to home the c-axis (coupler)

echo "Homing C..."

if sensors.gpIn[3].value = 0
  abort "Tool 0 is not docked"

G91  ; use relative positioning

M400                 ; make sure everything has stopped before we change the motor currents
M913 C60             ; set motor currents to 60%
G1 H2 C-1000 F10000  ; rotate -1000mm, stopping at the endstop
G92 C-125            ; set steps/mm

M400       ; make sure everything has stopped before we reset the motor currents
M913 C100  ; motor currents back to 100%

G90           ; back to absolute positioning
G1 C0 F10000  ; set to zero point

echo "Homing C... Done"