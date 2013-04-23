
_main:

;proff.c,22 :: 		void main() {
;proff.c,23 :: 		CMCON  = 7; // Turn off the comparators
	MOVLW      7
	MOVWF      CMCON+0
;proff.c,24 :: 		INTCON = 0; // Turn off all interupts
	CLRF       INTCON+0
;proff.c,25 :: 		TRISIO = 0; // configure pins of GPIO as output
	CLRF       TRISIO+0
;proff.c,26 :: 		GPIO = 0;   // Set to 0 / Clear all GPIO
	CLRF       GPIO+0
;proff.c,28 :: 		TRISIO.B3 = 1; //Input from GP3
	BSF        TRISIO+0, 3
;proff.c,29 :: 		waterStatus = 0;
	BCF        _waterStatus+0, BitPos(_waterStatus+0)
;proff.c,30 :: 		while(1){
L_main0:
;proff.c,34 :: 		if (Button(&GPIO, 3, 250, 1)) {
	MOVLW      GPIO+0
	MOVWF      FARG_Button_port+0
	MOVLW      3
	MOVWF      FARG_Button_pin+0
	MOVLW      250
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;proff.c,35 :: 		waterStatus = 1;
	BSF        _waterStatus+0, BitPos(_waterStatus+0)
;proff.c,36 :: 		PUMP = ON;
	BSF        GPIO+0, 0
;proff.c,37 :: 		}
L_main2:
;proff.c,38 :: 		if (waterStatus && Button(&GPIO, 3, 250, 0)) {
	BTFSS      _waterStatus+0, BitPos(_waterStatus+0)
	GOTO       L_main5
	MOVLW      GPIO+0
	MOVWF      FARG_Button_port+0
	MOVLW      3
	MOVWF      FARG_Button_pin+0
	MOVLW      250
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
L__main10:
;proff.c,39 :: 		waterStatus = 0;
	BCF        _waterStatus+0, BitPos(_waterStatus+0)
;proff.c,41 :: 		minuteDelay(TIME_BEFORE_STOP);
	MOVLW      3
	MOVWF      FARG_minuteDelay_timeInMinutes+0
	MOVLW      0
	MOVWF      FARG_minuteDelay_timeInMinutes+1
	CALL       _minuteDelay+0
;proff.c,42 :: 		PUMP = OFF;
	BCF        GPIO+0, 0
;proff.c,44 :: 		minuteDelay(TIME_BEFORE_WORK_AGAIN);
	MOVLW      10
	MOVWF      FARG_minuteDelay_timeInMinutes+0
	MOVLW      0
	MOVWF      FARG_minuteDelay_timeInMinutes+1
	CALL       _minuteDelay+0
;proff.c,45 :: 		}
L_main5:
;proff.c,46 :: 		}
	GOTO       L_main0
;proff.c,47 :: 		}
	GOTO       $+0
; end of _main

_minuteDelay:

;proff.c,49 :: 		void minuteDelay(int timeInMinutes) {
;proff.c,51 :: 		for (i = 0; i < timeInMinutes; i++) {
	CLRF       minuteDelay_i_L0+0
	CLRF       minuteDelay_i_L0+1
L_minuteDelay6:
	MOVLW      128
	XORWF      minuteDelay_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_minuteDelay_timeInMinutes+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__minuteDelay11
	MOVF       FARG_minuteDelay_timeInMinutes+0, 0
	SUBWF      minuteDelay_i_L0+0, 0
L__minuteDelay11:
	BTFSC      STATUS+0, 0
	GOTO       L_minuteDelay7
;proff.c,52 :: 		VDelay_ms(MINUTE);
	MOVLW      96
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVLW      234
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;proff.c,51 :: 		for (i = 0; i < timeInMinutes; i++) {
	INCF       minuteDelay_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       minuteDelay_i_L0+1, 1
;proff.c,53 :: 		}
	GOTO       L_minuteDelay6
L_minuteDelay7:
;proff.c,54 :: 		}
	RETURN
; end of _minuteDelay

_test:

;proff.c,56 :: 		void test() {
;proff.c,57 :: 		PUMP = ~PUMP;
	MOVLW      1
	XORWF      GPIO+0, 1
;proff.c,58 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_test9:
	DECFSZ     R13+0, 1
	GOTO       L_test9
	DECFSZ     R12+0, 1
	GOTO       L_test9
	DECFSZ     R11+0, 1
	GOTO       L_test9
	NOP
	NOP
;proff.c,59 :: 		}
	RETURN
; end of _test
