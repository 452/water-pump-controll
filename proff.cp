#line 1 "C:/projects/proff.c"




const int TIME_BEFORE_STOP = 3;
const int TIME_BEFORE_WORK_AGAIN = 10;

const unsigned long MINUTE = 1000*60;
#line 17 "C:/projects/proff.c"
bit waterStatus;

void minuteDelay(int timeInMinutes);
void test();

void main() {
 CMCON = 7;
 INTCON = 0;
 TRISIO = 0;
 GPIO = 0;

 TRISIO.B3 = 1;
 waterStatus = 0;
 while(1){
#line 34 "C:/projects/proff.c"
 if (Button(&GPIO, 3, 250, 1)) {
 waterStatus = 1;
  GPIO.GP0  =  1 ;
 }
 if (waterStatus && Button(&GPIO, 3, 250, 0)) {
 waterStatus = 0;

 minuteDelay(TIME_BEFORE_STOP);
  GPIO.GP0  =  0 ;

 minuteDelay(TIME_BEFORE_WORK_AGAIN);
 }
 }
}

void minuteDelay(int timeInMinutes) {
 int i;
 for (i = 0; i < timeInMinutes; i++) {
 VDelay_ms(MINUTE);
 }
}

void test() {
  GPIO.GP0  = ~ GPIO.GP0 ;
 Delay_ms(1000);
}
