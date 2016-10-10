int sensorValue1;
int sensorValue2;
int sensorValue3;
int sensorValueAverage;

char command;

void setup() {
  Serial.begin(9600);

  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);

  Serial.flush();
  while(!Serial);
  Serial.write(0);
}

void loop() {
  if (Serial.available() > 0) {
    command = Serial.read();

    if (command == 'r') { // Read from the light sensor
      sensorValue1 = analogRead(A0);
      sensorValue2 = analogRead(A1);
      sensorValue3 = analogRead(A2);
      sensorValueAverage = (sensorValue1 + sensorValue2 + sensorValue3) / 3;

      Serial.write(sensorValueAverage);
    }
  }
}
