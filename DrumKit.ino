const int kick = A0;
const int snare = A1;

const int volume = A3;
const int type = A2;

int kickReading = 0;
int snareReading = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(kick, INPUT);
  pinMode(snare, INPUT);
  pinMode(volume, INPUT);
  pinMode(type, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorReadingKick = analogRead(kick);
  int sensorReadingSnare = analogRead(snare);

  int volumeValue = analogRead(volume);
  int typeValue = analogRead(type);

  Serial.print("kick:");
  Serial.print(sensorReadingKick);
  Serial.print(";");

  Serial.print("snare:");
  Serial.print(sensorReadingSnare);
  Serial.print(";");

  Serial.print("volume:");
  Serial.print(volumeValue);
  Serial.print(";");

  Serial.print("type:");
  Serial.print(typeValue);
  Serial.println(";");
}
