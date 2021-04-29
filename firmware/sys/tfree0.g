; tfree0.g
; called when tool 0 is freed

M400  ; Wait for all moves to finish
if sensors.gpIn[3].value = 1
  T-1 P0  ; Deselect all tools
  abort "Tool 0 dock is not free"

G91
G1 Z4 F1000  ; Drop the bed
G90

M564 S0                   ; Allow movement outside the normal limits
G53 G1 X-5.2 Y156 F50000  ; Move to border no-go zone
M400
G53 G1 Y217.5 F4000       ; Move to dock position

M400  ; Wait for all moves to finish
if sensors.gpIn[3].value = 0
  T-1 P0  ; Deselect all tools
  abort "Tool 0 is not in dock"

M98 P"/macros/Coupler - Unlock.g"  ; Open Coupler

G53 G1 Y207 F4000  ; Move to partial-dock position

M400  ; Wait for all moves to finish
if sensors.gpIn[3].value = 0 || sensors.gpIn[1].value = 1
  T-1 P0  ; Deselect all tools
  abort "Tool 0 was not correctly released"

G53 G1 Y200 F4000  ; Move to border no-go zone

M208 X0:300 Y0:200 Z0:300  ; Set original limits
M564 S1                    ; Apply the normal limits again