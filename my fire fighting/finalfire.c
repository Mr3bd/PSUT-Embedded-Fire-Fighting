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
  // Initialize all peripherals
  initialize();

  // Delay to avoid sensors detection
  delay_ms(750);

  // Continuously check flame sensors
  while (1) {
    checkFlameSensors();
  }
}

void initialize() {
  // Initialize the ANALOG TO DIGITAL
  ATD_start();

  // Fosc/4 with 256 prescaler => incremetn every 0.5us*256=128us ==>
  OPTION_REG &= 0x87;

  // Set PORTB as output
  TRISB = 0x00;
  PORTB = 0x00;

  // Set PORTC as output
  TRISC = 0x00;
  PORTC = 0x00;


  // Set PORTD as output for motors and water pump
  TRISD = 0x00;
  PORTD = 0x00;

  delay_ms(500);
  // Initialize PWM for servo motor
  PWM_Init();

  ctr_return = 0; // Counter for rotation
  moving_Forward = 0x00; // Car initially Stopped
  pumping = 0x00; // Pump initially Stopped
  HL = 1; // start high
  angle = 0x00; // angle 0
}

void checkFlameSensors() {
  if (moving_Forward == 0x00 && pumping == 0x00) {
    moveTowardsFlame();
  }
}

void moveTowardsFlame() {
  // Front: RA1
  if ((PORTA & 0x02) == 0) {
    goToFire();
  }

  // BACK: RA2
  else if ((PORTA & 0x04) == 0) {
    left();
    delay_ms(300);
    left();
  }

  // RIGHT: RA3
  else if ((PORTA & 0x08) == 0) {
    right();
  }

  // LEFT: RA4
  else if ((PORTA & 0x10) == 0) {
    left();
  }

  // IDLE
  else {
    stopCar();
  }
}

// Turn on the water pump
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

// Turn off the water pump
void stopWaterPump() {
  CCPR1L = 0x80; // Stop servo motor
  PORTD = 0x00;
  delay_ms(1000);
  pumping = 0x00;
}

// Car goes right
void right() {
  moving_Forward = 0x01;
  PORTC = PORTC | 0x01;
  ctr_return = 0x00;
  PORTD = 0x04;
  while (ctr_return < 0x78) // Rotate 90 degree
  {
    ctr_return++;
    delay_ms(3);
  }
  stopCar();
}

// Car goes left
void left() {
  moving_Forward = 0x01; // low speed
  PORTC = PORTC | 0x01;
  ctr_return = 0x00;
  PORTD = 0x01;
  while (ctr_return < 0x78) // Rotate 90 degree
  {
    ctr_return++;
    delay_ms(3);
  }
  stopCar();
}

// Car goes forward
void forward() {
  moving_Forward = 0x01;
  PORTC = PORTC | 0x01;
  PORTD = 0x0A;
}


// Stop car wheels
void stopCar() {
  PORTC = PORTC & 0xFE;
  PORTD = 0x00;
  delay_ms(3);
  moving_Forward = 0x00;
}

// Go forward to Fire
void goToFire() {
  unsigned char going = 0x01;
  unsigned char found_fire = 0x00;
  unsigned int fire_read = 0x00;

  forward();

  // Keep Forward
  while (going) {
     fire_read = ATD_read(0x00);

     // Stop car "with" detect the Fire
     if (fire_read <= 0x0096) {  // 100
        going = 0x00;
        found_fire = 0x01;
      }

      // Stop car "without" detect the Fire
      else if (fire_read  >= 900)  // 900
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

// SET ADCON0, ADCON1 to start ATD reading
void ATD_start()
{
  ADCON0 = 0x01;
  ADCON1 = 0xCE; // right justified , FOSC/4 ,RA0 only analog
  TRISA = 0xFF; // Set PORTA as input(s)
}

// Reading analog sensor with channel number
unsigned int ATD_read(unsigned int channel_Number)
{
  channel_Number = channel_Number << 3;
  ADCON0 = 0x01;
  ADCON0 = ADCON0 | 0x04 | channel_Number; // go + this chanle number
  while (ADCON0 & 0x04);

  return ((ADRESH << 8) | ADRESL);
}


// Delay function regarding to OSC
void delay_ms(unsigned int milliseconds) {
  unsigned int i, j;
  for (i = 0; i < milliseconds; i++) {
    for (j = 0; j < 8000; j++) {
      // This inner loop introduces a delay of approximately 1 millisecond
      // for an 8 MHz clock
    }
  }
}

// Initialize PWM
void PWM_Init() {
    CCPR1L = 0x80; // Stop servo motor
    CCP1CON = 0x0C;  // Configure CCP1 for PWM
    T2CON = 0x07; // Configure Timer2 for 50Hz PWM frequency with prescaler = 16
}