; tpre1.g
; called before tool 1 is selected

M400  ; Wait for all moves to finish
if sensors.gpIn[1].value = 1
  T-1 P0  ; Deselect all tools
  abort "Toolhead not free, cannot pick up tool"

M98 P"/macros/Coupler - Unlock.g" ; unlock Coupler

G91
G1 Z20 F1000  ; Drop the bed
G90

M400
M564 S0                  ; Allow movement outside the normal limits
G53 G1 X85 Y185 F50000  ; Move to border no-go zone
M400
G53 G1 Y217.5 F4000     ; Move to dock position

M400  ; Wait for all moves to finish
if sensors.gpIn[1].value = 0
  T-1 P0  ; Deselect all tools
  abort "Tool 1 is not detected"

M98 P"/macros/Coupler - Lock.g"  ; Close Coupler

G53 G1 Y207 F4000  ; Move to partial-dock position

M400  ; Wait for all moves to finish
if sensors.gpIn[1].value = 0 || sensors.gpIn[4].value = 1
  T-1 P0  ; Deselect all tools
  abort "Tool 1 was not correctly picked up"

G53 G1 Y140 F4000  ; Move to border no-go zone

M208 X-11.2:288.8 Y-44.3:140.7 Z7:300  ; Set limits with tool
M564 S1                                ; Apply the normal limits again
