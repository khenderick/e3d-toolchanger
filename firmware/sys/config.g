; General preferences
M111 S0  ; Debugging off
G21      ; Work in millimetres
G90      ; Send absolute coordinates...
M83      ; ...but relative extruder moves

; Network
M550 P"Toolchanger"  ; Set name
M551 P"toolchanger"  ; Set password
M552 P0.0.0.0 S1     ; Enable network and acquire dynamic address via DHCP
M586 P0 S1           ; Enable HTTP
M586 P1 S0           ; Disable FTP
M586 P2 S0           ; Disable Telnet

; Motion type
M669 K1  ; CoreXY mode	

; Drive direction
M569 P0 S1        ; Drive 0 Z
M569 P1 S0        ; Drive 1 Y
M569 P2 S0        ; Drive 2 X
M569 P3 S0        ; Drive 3 COUPLER
M569 P20.0 S0 D2  ; Drive 20.0 (E0) spreadCycle mode
M569 P21.0 S0 D2  ; Drive 21.0 (E1) spreadCycle mode

; Mappings
M584 X1 Y2 Z0 C3  ; Axis to driver mapping
M584 E20.0:21.0   ; Set extruder drivers

; General motion settings
M208 X0:300 Y0:200 Z0:300 C0:500            ; Set axis maxima & minima
M92 X100 Y100 Z1600 C200 E409:409           ; Set steps per mm assuming x16 microstepping
M350 E16:16 I1                              ; Configure microstepping with interpolation
M350 C16 I1                                 ; Configure microstepping with interpolation
M350 X16 Y16 Z16 I1                         ; Configure microstepping with interpolation
M566 X400 Y400 Z8 C2 E200:200               ; Set maximum instantaneous speed changes (mm/min)
M203 X35000 Y35000 Z1200 C10000 E5000:5000  ; Set maximum speeds (mm/min)
M201 X6000 Y6000 Z400 C500 E2500:2500       ; Set accelerations (mm/s^2)
M906 X2000 Y2000 Z1330 C500 E1000:1000 I30  ; Set motor currents (mA) and motor idle factor in percent
M84 S120                                    ; Set idle timeout
; Absolute maxima: X-24:330 Y-45:200 (based on X0 Y0 in left-bottom corner of bed)

; Inputs
M950 J1 C"!^io1.in"  ; Toolhead detector switch
M950 J3 C"!^io3.in"  ; T0 docking switch
M950 J4 C"!^io4.in"  ; T1 docking switch

; Endstops
M574 X1 Y1 S3  ; Set X / Y endstop stall detection
M574 Z0        ; No Z endstop
M574 C1 S3     ; Stall detect coupler at low end of its range

; Z probe
M558 P8 C"^io0.in" H3 F360 I0 T20000  ; Set Z probe type to switch, the axes for which it is used and the dive height + speeds
G31 P200 X0 Y0 Z0                     ; Set Z probe trigger value, offset and trigger height
M557 X0:280 Y0:160 S40                ; Define mesh grid

;Stall Detection
M915 C S6 F0 H200 R0     ; Coupler
M915 P1:2 S1 F0 H280 R0  ; X / Y Axes

; Heaters and temperature sensors
; Bed heater
M308 S0 P"temp0" Y"thermistor" T100000 B4138 C0  ; Set thermistor 
M950 H0 C"out0" T0                               ; Bed heater
M143 H0 S120                                     ; Set temperature limit for heater 0 to 120C
M307 H0 A590.6 C474.5 D4.4                       ; Heater 0 tuning results
M140 H0                                          ; Bed heater is heater 0

; Tool 0 heater
M308 S1 P"20.temp0" Y"thermistor" T100000 B4725 C7.06e-8
M950 H1 C"20.out0" T1
M143 H1 S300  ; Set temperature limit for heater 1 to 300C
M307 H1 A452 C235 D5.5 V24

; Tool 1 heater
M308 S2 P"21.temp0" Y"thermistor" T100000 B4725 C7.06e-8
M950 H2 C"21.out0" T2
M143 H2 S300  ; Set temperature limit for heater 2 to 300C
M307 H2 A452 C235 D5.5 V24

; Fans
M950 F1 C"20.out2+out2.tach"  ; Tool 0 hot end fan with tacho
M950 F2 C"20.out1"            ; Tool 0 print cooling fan, no tacho
M950 F3 C"21.out2+out2.tach"  ; Tool 1 hot end fan with tacho
M950 F4 C"21.out1"            ; Tool 1 print cooling fan, no tacho

M106 P1 S255 H1 T50  ; Tool 0 hot end
M106 P2 S0           ; Tool 0 PCF
M106 P3 S255 H2 T50  ; Tool 1 hot end
M106 P4 S0           ; Tool 1 PCF

; Tools
M563 P0 S"T0" D0 H1 F2  ; Define tool 0
G10 P0 X11.2 Y44.3 Z-7  ; Set offset
G10 P0 R0 S0            ; Reset initial tool 0 active and standby temperatures to 0C

M563 P1 S"T1" D1 H2 F4  ; Define tool 1
G10 P1 X11.2 Y44.3 Z-7  ; Set offset
G10 P1 R0 S0            ; Reset initial tool 1 active and standby temperatures to 0C

M593 F50  ; cancel ringing at 50Hz (https://forum.e3d-online.com/threads/accelerometer-and-resonance-measurements-of-the-motion-system.3445/)
M376 H15  ; bed compensation taper
