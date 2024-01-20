
_main:

;finalfire.c,24 :: 		void main() {
;finalfire.c,26 :: 		initialize();
	CALL       _initialize+0
;finalfire.c,29 :: 		delay_ms(750);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;finalfire.c,32 :: 		while (1) {
L_main1:
;finalfire.c,33 :: 		checkFlameSensors();
	CALL       _checkFlameSensors+0
;finalfire.c,34 :: 		}
	GOTO       L_main1
;finalfire.c,35 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_initialize:

;finalfire.c,37 :: 		void initialize() {
;finalfire.c,39 :: 		ATD_start();
	CALL       _ATD_start+0
;finalfire.c,42 :: 		OPTION_REG &= 0x87;
	MOVLW      135
	ANDWF      OPTION_REG+0, 1
;finalfire.c,45 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;finalfire.c,46 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;finalfire.c,49 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;finalfire.c,50 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;finalfire.c,54 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;finalfire.c,55 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;finalfire.c,57 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_initialize3:
	DECFSZ     R13+0, 1
	GOTO       L_initialize3
	DECFSZ     R12+0, 1
	GOTO       L_initialize3
	DECFSZ     R11+0, 1
	GOTO       L_initialize3
	NOP
	NOP
;finalfire.c,59 :: 		PWM_Init();
	CALL       _PWM_Init+0
;finalfire.c,61 :: 		ctr_return = 0; // Counter for rotation
	CLRF       _ctr_return+0
	CLRF       _ctr_return+1
;finalfire.c,62 :: 		moving_Forward = 0x00; // Car initially Stopped
	CLRF       _moving_Forward+0
;finalfire.c,63 :: 		pumping = 0x00; // Pump initially Stopped
	CLRF       _pumping+0
;finalfire.c,64 :: 		HL = 1; // start high
	MOVLW      1
	MOVWF      _HL+0
;finalfire.c,65 :: 		angle = 0x00; // angle 0
	CLRF       _angle+0
	CLRF       _angle+1
;finalfire.c,66 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_checkFlameSensors:

;finalfire.c,68 :: 		void checkFlameSensors() {
;finalfire.c,69 :: 		if (moving_Forward == 0x00 && pumping == 0x00) {
	MOVF       _moving_Forward+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkFlameSensors6
	MOVF       _pumping+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkFlameSensors6
L__checkFlameSensors45:
;finalfire.c,70 :: 		moveTowardsFlame();
	CALL       _moveTowardsFlame+0
;finalfire.c,71 :: 		}
L_checkFlameSensors6:
;finalfire.c,72 :: 		}
L_end_checkFlameSensors:
	RETURN
; end of _checkFlameSensors

_moveTowardsFlame:

;finalfire.c,74 :: 		void moveTowardsFlame() {
;finalfire.c,76 :: 		if ((PORTA & 0x02) == 0) {
	MOVLW      2
	ANDWF      PORTA+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_moveTowardsFlame7
;finalfire.c,77 :: 		goToFire();
	CALL       _goToFire+0
;finalfire.c,78 :: 		}
	GOTO       L_moveTowardsFlame8
L_moveTowardsFlame7:
;finalfire.c,81 :: 		else if ((PORTA & 0x04) == 0) {
	MOVLW      4
	ANDWF      PORTA+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_moveTowardsFlame9
;finalfire.c,82 :: 		left();
	CALL       _left+0
;finalfire.c,83 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_moveTowardsFlame10:
	DECFSZ     R13+0, 1
	GOTO       L_moveTowardsFlame10
	DECFSZ     R12+0, 1
	GOTO       L_moveTowardsFlame10
	DECFSZ     R11+0, 1
	GOTO       L_moveTowardsFlame10
	NOP
	NOP
;finalfire.c,84 :: 		left();
	CALL       _left+0
;finalfire.c,85 :: 		}
	GOTO       L_moveTowardsFlame11
L_moveTowardsFlame9:
;finalfire.c,88 :: 		else if ((PORTA & 0x08) == 0) {
	MOVLW      8
	ANDWF      PORTA+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_moveTowardsFlame12
;finalfire.c,89 :: 		right();
	CALL       _right+0
;finalfire.c,90 :: 		}
	GOTO       L_moveTowardsFlame13
L_moveTowardsFlame12:
;finalfire.c,93 :: 		else if ((PORTA & 0x10) == 0) {
	MOVLW      16
	ANDWF      PORTA+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_moveTowardsFlame14
;finalfire.c,94 :: 		left();
	CALL       _left+0
;finalfire.c,95 :: 		}
	GOTO       L_moveTowardsFlame15
L_moveTowardsFlame14:
;finalfire.c,99 :: 		stopCar();
	CALL       _stopCar+0
;finalfire.c,100 :: 		}
L_moveTowardsFlame15:
L_moveTowardsFlame13:
L_moveTowardsFlame11:
L_moveTowardsFlame8:
;finalfire.c,101 :: 		}
L_end_moveTowardsFlame:
	RETURN
; end of _moveTowardsFlame

_startWaterPump:

;finalfire.c,104 :: 		void startWaterPump() {
;finalfire.c,105 :: 		PORTD = 0x80;
	MOVLW      128
	MOVWF      PORTD+0
;finalfire.c,106 :: 		angle = 0x00;
	CLRF       _angle+0
	CLRF       _angle+1
;finalfire.c,107 :: 		CCPR1L = 0x80;
	MOVLW      128
	MOVWF      CCPR1L+0
;finalfire.c,108 :: 		while((PORTA & 0x02) == 0){
L_startWaterPump16:
	MOVLW      2
	ANDWF      PORTA+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_startWaterPump17
;finalfire.c,109 :: 		if(angle == 0x00){
	MOVLW      0
	XORWF      _angle+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__startWaterPump51
	MOVLW      0
	XORWF      _angle+0, 0
L__startWaterPump51:
	BTFSS      STATUS+0, 2
	GOTO       L_startWaterPump18
;finalfire.c,110 :: 		angle = 0x01;
	MOVLW      1
	MOVWF      _angle+0
	MOVLW      0
	MOVWF      _angle+1
;finalfire.c,111 :: 		CCPR1L = 0x40;
	MOVLW      64
	MOVWF      CCPR1L+0
;finalfire.c,112 :: 		}
	GOTO       L_startWaterPump19
L_startWaterPump18:
;finalfire.c,114 :: 		angle = 0x00;
	CLRF       _angle+0
	CLRF       _angle+1
;finalfire.c,115 :: 		CCPR1L = 0xBF;
	MOVLW      191
	MOVWF      CCPR1L+0
;finalfire.c,116 :: 		}
L_startWaterPump19:
;finalfire.c,117 :: 		delay_ms(850);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      160
	MOVWF      R12+0
	MOVLW      195
	MOVWF      R13+0
L_startWaterPump20:
	DECFSZ     R13+0, 1
	GOTO       L_startWaterPump20
	DECFSZ     R12+0, 1
	GOTO       L_startWaterPump20
	DECFSZ     R11+0, 1
	GOTO       L_startWaterPump20
;finalfire.c,118 :: 		};
	GOTO       L_startWaterPump16
L_startWaterPump17:
;finalfire.c,119 :: 		stopWaterPump();
	CALL       _stopWaterPump+0
;finalfire.c,120 :: 		}
L_end_startWaterPump:
	RETURN
; end of _startWaterPump

_stopWaterPump:

;finalfire.c,123 :: 		void stopWaterPump() {
;finalfire.c,124 :: 		CCPR1L = 0x80; // Stop servo motor
	MOVLW      128
	MOVWF      CCPR1L+0
;finalfire.c,125 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;finalfire.c,126 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_stopWaterPump21:
	DECFSZ     R13+0, 1
	GOTO       L_stopWaterPump21
	DECFSZ     R12+0, 1
	GOTO       L_stopWaterPump21
	DECFSZ     R11+0, 1
	GOTO       L_stopWaterPump21
	NOP
	NOP
;finalfire.c,127 :: 		pumping = 0x00;
	CLRF       _pumping+0
;finalfire.c,128 :: 		}
L_end_stopWaterPump:
	RETURN
; end of _stopWaterPump

_right:

;finalfire.c,131 :: 		void right() {
;finalfire.c,132 :: 		moving_Forward = 0x01;
	MOVLW      1
	MOVWF      _moving_Forward+0
;finalfire.c,133 :: 		PORTC = PORTC | 0x01;
	BSF        PORTC+0, 0
;finalfire.c,134 :: 		ctr_return = 0x00;
	CLRF       _ctr_return+0
	CLRF       _ctr_return+1
;finalfire.c,135 :: 		PORTD = 0x04;
	MOVLW      4
	MOVWF      PORTD+0
;finalfire.c,136 :: 		while (ctr_return < 0x78) // Rotate 90 degree
L_right22:
	MOVLW      0
	SUBWF      _ctr_return+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__right54
	MOVLW      120
	SUBWF      _ctr_return+0, 0
L__right54:
	BTFSC      STATUS+0, 0
	GOTO       L_right23
;finalfire.c,138 :: 		ctr_return++;
	INCF       _ctr_return+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ctr_return+1, 1
;finalfire.c,139 :: 		delay_ms(3);
	MOVLW      8
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_right24:
	DECFSZ     R13+0, 1
	GOTO       L_right24
	DECFSZ     R12+0, 1
	GOTO       L_right24
	NOP
	NOP
;finalfire.c,140 :: 		}
	GOTO       L_right22
L_right23:
;finalfire.c,141 :: 		stopCar();
	CALL       _stopCar+0
;finalfire.c,142 :: 		}
L_end_right:
	RETURN
; end of _right

_left:

;finalfire.c,145 :: 		void left() {
;finalfire.c,146 :: 		moving_Forward = 0x01; // low speed
	MOVLW      1
	MOVWF      _moving_Forward+0
;finalfire.c,147 :: 		PORTC = PORTC | 0x01;
	BSF        PORTC+0, 0
;finalfire.c,148 :: 		ctr_return = 0x00;
	CLRF       _ctr_return+0
	CLRF       _ctr_return+1
;finalfire.c,149 :: 		PORTD = 0x01;
	MOVLW      1
	MOVWF      PORTD+0
;finalfire.c,150 :: 		while (ctr_return < 0x78) // Rotate 90 degree
L_left25:
	MOVLW      0
	SUBWF      _ctr_return+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__left56
	MOVLW      120
	SUBWF      _ctr_return+0, 0
L__left56:
	BTFSC      STATUS+0, 0
	GOTO       L_left26
;finalfire.c,152 :: 		ctr_return++;
	INCF       _ctr_return+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ctr_return+1, 1
;finalfire.c,153 :: 		delay_ms(3);
	MOVLW      8
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_left27:
	DECFSZ     R13+0, 1
	GOTO       L_left27
	DECFSZ     R12+0, 1
	GOTO       L_left27
	NOP
	NOP
;finalfire.c,154 :: 		}
	GOTO       L_left25
L_left26:
;finalfire.c,155 :: 		stopCar();
	CALL       _stopCar+0
;finalfire.c,156 :: 		}
L_end_left:
	RETURN
; end of _left

_forward:

;finalfire.c,159 :: 		void forward() {
;finalfire.c,160 :: 		moving_Forward = 0x01;
	MOVLW      1
	MOVWF      _moving_Forward+0
;finalfire.c,161 :: 		PORTC = PORTC | 0x01;
	BSF        PORTC+0, 0
;finalfire.c,162 :: 		PORTD = 0x0A;
	MOVLW      10
	MOVWF      PORTD+0
;finalfire.c,163 :: 		}
L_end_forward:
	RETURN
; end of _forward

_stopCar:

;finalfire.c,167 :: 		void stopCar() {
;finalfire.c,168 :: 		PORTC = PORTC & 0xFE;
	MOVLW      254
	ANDWF      PORTC+0, 1
;finalfire.c,169 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;finalfire.c,170 :: 		delay_ms(3);
	MOVLW      8
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_stopCar28:
	DECFSZ     R13+0, 1
	GOTO       L_stopCar28
	DECFSZ     R12+0, 1
	GOTO       L_stopCar28
	NOP
	NOP
;finalfire.c,171 :: 		moving_Forward = 0x00;
	CLRF       _moving_Forward+0
;finalfire.c,172 :: 		}
L_end_stopCar:
	RETURN
; end of _stopCar

_goToFire:

;finalfire.c,175 :: 		void goToFire() {
;finalfire.c,176 :: 		unsigned char going = 0x01;
	MOVLW      1
	MOVWF      goToFire_going_L0+0
	CLRF       goToFire_found_fire_L0+0
	CLRF       goToFire_fire_read_L0+0
	CLRF       goToFire_fire_read_L0+1
;finalfire.c,180 :: 		forward();
	CALL       _forward+0
;finalfire.c,183 :: 		while (going) {
L_goToFire29:
	MOVF       goToFire_going_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_goToFire30
;finalfire.c,184 :: 		fire_read = ATD_read(0x00);
	CLRF       FARG_ATD_read_channel_Number+0
	CLRF       FARG_ATD_read_channel_Number+1
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      goToFire_fire_read_L0+0
	MOVF       R0+1, 0
	MOVWF      goToFire_fire_read_L0+1
;finalfire.c,187 :: 		if (fire_read <= 0x0096) {  // 100
	MOVF       R0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__goToFire60
	MOVF       R0+0, 0
	SUBLW      150
L__goToFire60:
	BTFSS      STATUS+0, 0
	GOTO       L_goToFire31
;finalfire.c,188 :: 		going = 0x00;
	CLRF       goToFire_going_L0+0
;finalfire.c,189 :: 		found_fire = 0x01;
	MOVLW      1
	MOVWF      goToFire_found_fire_L0+0
;finalfire.c,190 :: 		}
	GOTO       L_goToFire32
L_goToFire31:
;finalfire.c,193 :: 		else if (fire_read  >= 900)  // 900
	MOVLW      3
	SUBWF      goToFire_fire_read_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__goToFire61
	MOVLW      132
	SUBWF      goToFire_fire_read_L0+0, 0
L__goToFire61:
	BTFSS      STATUS+0, 0
	GOTO       L_goToFire33
;finalfire.c,195 :: 		going = 0x00;
	CLRF       goToFire_going_L0+0
;finalfire.c,196 :: 		found_fire = 0x00;
	CLRF       goToFire_found_fire_L0+0
;finalfire.c,197 :: 		}
L_goToFire33:
L_goToFire32:
;finalfire.c,198 :: 		}
	GOTO       L_goToFire29
L_goToFire30:
;finalfire.c,201 :: 		if(found_fire == 0x01){
	MOVF       goToFire_found_fire_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_goToFire34
;finalfire.c,202 :: 		pumping = 0x01;
	MOVLW      1
	MOVWF      _pumping+0
;finalfire.c,203 :: 		}
L_goToFire34:
;finalfire.c,204 :: 		stopCar();
	CALL       _stopCar+0
;finalfire.c,205 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_goToFire35:
	DECFSZ     R13+0, 1
	GOTO       L_goToFire35
	DECFSZ     R12+0, 1
	GOTO       L_goToFire35
	DECFSZ     R11+0, 1
	GOTO       L_goToFire35
	NOP
	NOP
;finalfire.c,206 :: 		if(pumping == 0x01)
	MOVF       _pumping+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_goToFire36
;finalfire.c,208 :: 		startWaterPump();
	CALL       _startWaterPump+0
;finalfire.c,209 :: 		}
L_goToFire36:
;finalfire.c,210 :: 		}
L_end_goToFire:
	RETURN
; end of _goToFire

_ATD_start:

;finalfire.c,213 :: 		void ATD_start()
;finalfire.c,215 :: 		ADCON0 = 0x01;
	MOVLW      1
	MOVWF      ADCON0+0
;finalfire.c,216 :: 		ADCON1 = 0xCE; // right justified , FOSC/4 ,RA0 only analog
	MOVLW      206
	MOVWF      ADCON1+0
;finalfire.c,217 :: 		TRISA = 0xFF; // Set PORTA as input(s)
	MOVLW      255
	MOVWF      TRISA+0
;finalfire.c,218 :: 		}
L_end_ATD_start:
	RETURN
; end of _ATD_start

_ATD_read:

;finalfire.c,221 :: 		unsigned int ATD_read(unsigned int channel_Number)
;finalfire.c,223 :: 		channel_Number = channel_Number << 3;
	MOVF       FARG_ATD_read_channel_Number+0, 0
	MOVWF      R1+0
	MOVF       FARG_ATD_read_channel_Number+1, 0
	MOVWF      R1+1
	RLF        R1+0, 1
	RLF        R1+1, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	RLF        R1+1, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	RLF        R1+1, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      FARG_ATD_read_channel_Number+0
	MOVF       R1+1, 0
	MOVWF      FARG_ATD_read_channel_Number+1
;finalfire.c,224 :: 		ADCON0 = 0x01;
	MOVLW      1
	MOVWF      ADCON0+0
;finalfire.c,225 :: 		ADCON0 = ADCON0 | 0x04 | channel_Number; // go + this chanle number
	MOVLW      4
	IORWF      ADCON0+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 0
	MOVWF      ADCON0+0
;finalfire.c,226 :: 		while (ADCON0 & 0x04);
L_ATD_read37:
	BTFSS      ADCON0+0, 2
	GOTO       L_ATD_read38
	GOTO       L_ATD_read37
L_ATD_read38:
;finalfire.c,228 :: 		return ((ADRESH << 8) | ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;finalfire.c,229 :: 		}
L_end_ATD_read:
	RETURN
; end of _ATD_read

_delay_ms:

;finalfire.c,233 :: 		void delay_ms(unsigned int milliseconds) {
;finalfire.c,235 :: 		for (i = 0; i < milliseconds; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_delay_ms39:
	MOVF       FARG_delay_ms_milliseconds+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_ms65
	MOVF       FARG_delay_ms_milliseconds+0, 0
	SUBWF      R1+0, 0
L__delay_ms65:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_ms40
;finalfire.c,236 :: 		for (j = 0; j < 8000; j++) {
	CLRF       R3+0
	CLRF       R3+1
L_delay_ms42:
	MOVLW      31
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_ms66
	MOVLW      64
	SUBWF      R3+0, 0
L__delay_ms66:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_ms43
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;finalfire.c,239 :: 		}
	GOTO       L_delay_ms42
L_delay_ms43:
;finalfire.c,235 :: 		for (i = 0; i < milliseconds; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;finalfire.c,240 :: 		}
	GOTO       L_delay_ms39
L_delay_ms40:
;finalfire.c,241 :: 		}
L_end_delay_ms:
	RETURN
; end of _delay_ms

_PWM_Init:

;finalfire.c,244 :: 		void PWM_Init() {
;finalfire.c,245 :: 		CCPR1L = 0x80; // Stop servo motor
	MOVLW      128
	MOVWF      CCPR1L+0
;finalfire.c,246 :: 		CCP1CON = 0x0C;  // Configure CCP1 for PWM
	MOVLW      12
	MOVWF      CCP1CON+0
;finalfire.c,247 :: 		T2CON = 0x07; // Configure Timer2 for 50Hz PWM frequency with prescaler = 16
	MOVLW      7
	MOVWF      T2CON+0
;finalfire.c,248 :: 		}
L_end_PWM_Init:
	RETURN
; end of _PWM_Init
