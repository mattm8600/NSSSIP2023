#include <Servo.h>
Servo servo; 
const int unlocked_pos = 110;
const int locked_pos = 10; 
const int loop_delay = 50; //milliseconds

bool new_command = true; 

void setup() {
  Serial.begin(115200); 
  pinMode(1, OUTPUT);
  pinMode(2, INPUT_PULLUP);
  servo.attach(1);
  servo.write(locked_pos);
}

int servo_state = 0; 
void loop() {

  unsigned long time_start = millis();

  while (Serial.available() > 0) {
    char inbyte[1];
    inbyte[0] = Serial.read(); 
    servo_state = atoi(inbyte); 
    //Serial.println("Received: " + String(servo_state)); 
  }
  
  if (servo_state == 0 && new_command) {
    servo.write(unlocked_pos);
  }
  else if (new_command) {
    servo.write(locked_pos); 
  }

  int claw_state = digitalRead(2);
  Serial.println(claw_state);
  
  while (millis() - time_start < loop_delay);
}
