#include <SimpleDHT.h>

#define a 4
#define b 5
#define c 6
#define d 7
#define e 10
#define f 11
#define g 12
#define h 13

#define LEDS 8
#define buzzer 9

#define SH_INPUT 2
#define SH_CLOCK 3

int temp = 0;
int firstDigit = 0;
int secondDigit = 0;

SimpleDHT11 dht11(A0);

byte temperature = 0;
const byte pattern[10] = {
  B00111111, // 0 
  B00000110, // 1 
  B01011011, // 2 
  B01001111, // 3 
  B01100110, // 4 
  B01101101, // 5 
  B01111101, // 6 
  B00000111, // 7 
  B01111111, // 8 
  B01101111, // 9 
};

void writeDigit(int value){
  if(value == 0){
    digitalWrite(a, LOW);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, LOW);
    digitalWrite(e, LOW);
    digitalWrite(f, LOW);
    digitalWrite(g, HIGH);
    digitalWrite(h, HIGH);
  }

  else if(value == 1){
    digitalWrite(a, HIGH);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, HIGH);
    digitalWrite(e, HIGH);
    digitalWrite(f, HIGH);
    digitalWrite(g, HIGH);
    digitalWrite(h, HIGH);
  }
  
  else if(value == 2){
    digitalWrite(a, LOW);
    digitalWrite(b, LOW);
    digitalWrite(c, HIGH);
    digitalWrite(d, LOW);
    digitalWrite(e, LOW);
    digitalWrite(f, HIGH);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }

  else if(value == 3){
    digitalWrite(a, LOW);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, LOW);
    digitalWrite(e, HIGH);
    digitalWrite(f, HIGH);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }

  else if(value == 4){
    digitalWrite(a, HIGH);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, HIGH);
    digitalWrite(e, HIGH);
    digitalWrite(f, LOW);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }

  else if(value == 5){
    digitalWrite(a, LOW);
    digitalWrite(b, HIGH);
    digitalWrite(c, LOW);
    digitalWrite(d, LOW);
    digitalWrite(e, HIGH);
    digitalWrite(f, LOW);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }

  else if(value == 6){
    digitalWrite(a, LOW);
    digitalWrite(b, HIGH);
    digitalWrite(c, LOW);
    digitalWrite(d, LOW);
    digitalWrite(e, LOW);
    digitalWrite(f, LOW);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }

  else if(value == 7){
    digitalWrite(a, LOW);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, HIGH);
    digitalWrite(e, HIGH);
    digitalWrite(f, HIGH);
    digitalWrite(g, HIGH);
    digitalWrite(h, HIGH);
  }

  else if(value == 8){
    digitalWrite(a, LOW);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, LOW);
    digitalWrite(e, LOW);
    digitalWrite(f, LOW);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }

  else if(value == 9){
    digitalWrite(a, LOW);
    digitalWrite(b, LOW);
    digitalWrite(c, LOW);
    digitalWrite(d, LOW);
    digitalWrite(e, HIGH);
    digitalWrite(f, LOW);
    digitalWrite(g, LOW);
    digitalWrite(h, HIGH);
  }
}

void setup() {
  Serial.begin(9600);

  pinMode(SH_CLOCK, OUTPUT);
  pinMode(SH_INPUT, OUTPUT);
  pinMode(LEDS, OUTPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(a, OUTPUT);
  pinMode(b, OUTPUT);
  pinMode(c, OUTPUT);
  pinMode(d, OUTPUT);
  pinMode(e, OUTPUT);
  pinMode(f, OUTPUT);
  pinMode(g, OUTPUT);
  pinMode(h, OUTPUT);
}

void loop() {
  // Get temperature value
  dht11.read(&temperature, NULL, NULL);
  temp = (int)temperature;

  // Below zero
  if(temp < 0){
    digitalWrite(LEDS, LOW);
    digitalWrite(buzzer, LOW);

    firstDigit = (temp * (-1)) / 10;
    secondDigit = (temp * (-1)) % 10;

    writeDigit(firstDigit);
    shiftOut(SH_INPUT, SH_CLOCK, MSBFIRST, (byte)255 - pattern[secondDigit]);
  }

  digitalWrite(LEDS, HIGH);
  
  // Activate buzzer if temperature is above 30
  if(temperature >= 30){
    for(int i = 0; i < temperature/2; i++){
      digitalWrite(buzzer, HIGH);
      digitalWrite(buzzer, LOW);
    }
   } else{
    digitalWrite(buzzer, LOW);  
  }
    
  firstDigit = temp / 10;
  secondDigit = temp % 10;

  writeDigit(firstDigit);
  shiftOut(SH_INPUT, SH_CLOCK, MSBFIRST, (byte)255 - pattern[secondDigit]);
}
