#include <WiFi.h>  
#include <ESP32Servo.h>

Servo myservo;  // create servo object to control a servo
int pos = 0;    // variable to store the servo position
// Recommended PWM GPIO pins on the ESP32 include 2,4,12-19,21-23,25-27,32-33 
int servoPin = 4;

WiFiServer wifiServer(80);

const char* ssid = "MatheusFPrado";
const char* pass = "40302010";

void setup() {
  Serial.begin(115200);
  delay(1000);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
      Serial.print("IP:");
  Serial.println(WiFi.localIP());
    delay(1000);
    Serial.println("Connectando");
  }
  Serial.print("Conectado ao WiFi. IP:");
  Serial.println(WiFi.localIP());
  wifiServer.begin();
  myservo.setPeriodHertz(50);    // standard 50 hz servo
  myservo.attach(servoPin, 1000, 2000); // attaches the servo on pin 18 to the servo object
}

void loop() {
  WiFiClient client = wifiServer.available();
  if (client) {
    while (client.connected()) {
      while (client.available() > 0) {
        char cmd = client.read();
        Serial.write(cmd);
        //char cmd = Serial.read();
  
        if(cmd == 'a') {
          pos = 180;
          myservo.write(pos);
          Serial.print("cmd: ");
          Serial.println(cmd);
          Serial.print("pos: ");
          Serial.println(pos);
        }
      
        if(cmd == 'b') {
          pos = 0;
          myservo.write(pos);
          Serial.print("cmd: ");  
          Serial.println(cmd);
          Serial.print("pos: ");
          Serial.println(pos);
        }
      }
      delay(10);
    }
    client.stop();
    Serial.println("Cliente disconectado");
  }

}
