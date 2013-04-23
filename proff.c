#define PUMP GPIO.GP0
#define IN GPIO.GP3
#define INPUT 3
#define ON 1
#define OFF 0
const int TIME_BEFORE_STOP = 3;
const int TIME_BEFORE_WORK_AGAIN = 10;

const unsigned long MINUTE = 1000*60;          // 06 0000
/* NOT WORK
//long 4294967295
const unsigned long THREE_MINUTES = 3*1000*60; // 18 0000
const unsigned long FIVE_MINUTES  = 5*1000*60; // 30 0000
const unsigned long TEN_MINUTES   = 10*1000*60;// 60 0000
VDelay_ms(FIVE_MINUTES) - NOT WORK
*/

bit waterStatus;

void minuteDelay(int timeInMinutes);

void main() {
  CMCON  = 7; // Turn off the comparators
  INTCON = 0; // Turn off all interupts
  TRISIO = 0; // configure pins of GPIO as output
  GPIO = 0;   // Set to 0 / Clear all GPIO
  //0 = output, 1 = input
  TRISIO.B3 = 1; //Input from GP3
  waterStatus = 0;
  while(1){
     if (Button(&GPIO, INPUT, 250, 1)) {
        waterStatus = 1;
        PUMP = ON;
     }
     if (waterStatus && Button(&GPIO, INPUT, 250, 0)) {
      waterStatus = 0;
      minuteDelay(TIME_BEFORE_STOP);
      PUMP = OFF;
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
