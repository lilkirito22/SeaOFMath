const int btn = 27;    //plug Joystick 'Button' into pin 8
const int X_pin = 34;  //plug joystick X direction into pin A0
const int Y_pin = 35;  //plug joystick Y direction into pin A1
int xc;
int yc;
int JSButton;

int flag = 0;

void setup() {

  pinMode(btn, INPUT_PULLUP);



  Serial.begin(9600);
}

void loop() {


  if (digitalRead(btn) == HIGH) {
    Serial.write("Pulou 1\n");
    flag = 1;
  }


  //int x = map(analogRead(X_pin), 0, 4095, -10, 10);
  int y = map(analogRead(Y_pin), 0, 4095, -10, 10);

  if (y == -10) {
    Serial.write("Esquerda 1\n");
  } else if (y == 10) {
    Serial.write("Direita 2\n");

  } else if (y == 0) {
    Serial.write("Afk 1\n");
  }


  //Serial.println((String ) y + "Andou\n" );

  delay(100);
}