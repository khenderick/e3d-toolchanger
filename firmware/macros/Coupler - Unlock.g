M400

if sensors.gpIn[3].value = 0
  abort "Tool 0 is not docked, cannot unlock"

M913 C100
G1 C129 F50000
M400
M913 C50