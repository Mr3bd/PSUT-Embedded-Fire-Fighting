#line 1 "C:/Users/20190270/Desktop/my fire fighting/finalfire.c"
void initialize();
void checkFlameSensors();
void moveTowardsFlame();
void stopAtFlame();
void startWaterPump();
void stopWaterPump();
unsigned int delay_ctr;
void ATD_start();
unsigned int ATD_read(unsigned int channel_Number);
unsigned char moving_Forward;
unsigned char pumping;
unsigned int angle;
unsigned char HL;
unsigned int ctr_return;
void delay_ms(unsigned int milliseconds);
void right();
void left();
void forward();
void stopCar();
void goToFire();
void PWM_Init();
unsigned int forwardSen;

void main() {

 initialize();


 delay_ms(750);


 while (1) {
 checkFlameSensors();
 }
}

void initialize() {

 ATD_start();


 OPTION_REG &= 0x87;


 TRISB = 0x00;
 PORTB = 0x00;


 TRISC = 0x00;
 PORTC = 0x00;



 TRISD = 0x00;
 PORTD = 0x00;

 delay_ms(500);

 PWM_Init();

 ctr_return = 0;
 moving_Forward = 0x00;
 pumping = 0x00;
 HL = 1;
 angle = 0x00;
}

void checkFlameSensors() {
 if (moving_Forward == 0x00 && pumping == 0x00) {
 moveTowardsFlame();
 }
}

void moveTowardsFlame() {

 if ((PORTA & 0x02) == 0) {
 goToFire();
 }


 else if ((PORTA & 0x04) == 0) {
 left();
 delay_ms(300);
 left();
 }


 else if ((PORTA & 0x08) == 0) {
 right();
 }


 else if ((PORTA & 0x10) == 0) {
 left();
 }


 else {
 stopCar();
 }
}


void startWaterPump() {
 PORTD = 0x80;
 angle = 0x00;
 CCPR1L = 0x80;
 while((PORTA & 0x02) == 0){
 if(angle == 0x00){
 angle = 0x01;
 CCPR1L = 0x40;
 }
 else{
 angle = 0x00;
 CCPR1L = 0xBF;
 }
 delay_ms(850);
 };
 stopWaterPump();
}


void stopWaterPump() {
 CCPR1L = 0x80;
 PORTD = 0x00;
 delay_ms(1000);
 pumping = 0x00;
}


void right() {
 moving_Forward = 0x01;
 PORTC = PORTC | 0x01;
 ctr_return = 0x00;
 PORTD = 0x04;
 while (ctr_return < 0x78)
 {
 ctr_return++;
 delay_ms(3);
 }
 stopCar();
}


void left() {
 moving_Forward = 0x01;
 PORTC = PORTC | 0x01;
 ctr_return = 0x00;
 PORTD = 0x01;
 while (ctr_return < 0x78)
 {
 ctr_return++;
 delay_ms(3);
 }
 stopCar();
}


void forward() {
 moving_Forward = 0x01;
 PORTC = PORTC | 0x01;
 PORTD = 0x0A;
}



void stopCar() {
 PORTC = PORTC & 0xFE;
 PORTD = 0x00;
 delay_ms(3);
 moving_Forward = 0x00;
}


void goToFire() {
 unsigned char going = 0x01;
 unsigned char found_fire = 0x00;
 unsigned int fire_read = 0x00;

 forward();


 while (going) {
 fire_read = ATD_read(0x00);


 if (fire_read <= 0x0096) {
 going = 0x00;
 found_fire = 0x01;
 }


 else if (fire_read >= 900)
 {
 going = 0x00;
 found_fire = 0x00;
 }
 }


 if(found_fire == 0x01){
 pumping = 0x01;
 }
 stopCar();
 delay_ms(500);
 if(pumping == 0x01)
 {
 startWaterPump();
 }
}


void ATD_start()
{
 ADCON0 = 0x01;
 ADCON1 = 0xCE;
 TRISA = 0xFF;
}


unsigned int ATD_read(unsigned int channel_Number)
{
 channel_Number = channel_Number << 3;
 ADCON0 = 0x01;
 ADCON0 = ADCON0 | 0x04 | channel_Number;
 while (ADCON0 & 0x04);

 return ((ADRESH << 8) | ADRESL);
}



void delay_ms(unsigned int milliseconds) {
 unsigned int i, j;
 for (i = 0; i < milliseconds; i++) {
 for (j = 0; j < 8000; j++) {


 }
 }
}


void PWM_Init() {
 CCPR1L = 0x80;
 CCP1CON = 0x0C;
 T2CON = 0x07;
}
