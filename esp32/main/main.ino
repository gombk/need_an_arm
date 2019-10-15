#include <WiFi.h>  
#include <ESP32Servo.h>

// #include "SSD1306Wire.h" // legacy include: `#include "SSD1306.h"`

// SSD1306Wire display(0x3c, 5, 4);

Servo myservo;  // create servo object to control a servo
int pos = 0;    // variable to store the servo position
// Recommended PWM GPIO pins on the ESP32 include 2,4,12-19,21-23,25-27,32-33 
int servoPin = 4;

WiFiServer wifiServer(80);

const char* ssid = "PNCFDP-69";
const char* pass = "34997e4f";

// int buzzer_pin      = 4;
// int channel         = 0;
// int frequence       = 2000;
// int resolution      = 10;

/*void printBuffer(void) {
  // Initialize the log buffer
  // allocate memory to store 8 lines of text and 30 chars per line.
  display.setLogBuffer(5, 30);
  // Some test data

  for (uint8_t i = 0; i < 11; i++) {
    display.clear();
    // Print to the screen
    display.print('A');
    // Draw it to the internal screen buffer
    display.drawLogBuffer(0, 0);
    // Display it on the screen
    display.display();
    delay(500);
  }
}*/

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

  // ledcSetup(channel, frequence, resolution);
  // ledcAttachPin(buzzer_pin, channel);

  //  display.init();

  // display.setContrast(255);

  // display.print('A');
  // printBuffer();
  // delay(1000);
  // display.clear();
}

void loop() {
  WiFiClient client = wifiServer.available();
  if (client) {
    while (client.connected()) {
      while (client.available() > 0) {
        char cmd = client.read();
        Serial.write(cmd);
        //char cmd = Serial.read();

        float sinVal;
         int   toneVal;
  
        if(cmd == 'a') {

        //   for (byte x=0;x<180;x++){
        //     //converte graus em radianos
        //     sinVal = (sin(x*(3.1412/180)));
        //     //agora gera uma frequencia
        //     toneVal = 2000+(int(sinVal*100));
        //     //toca o valor no buzzer
        //     ledcWriteTone(channel,toneVal);
        //     //Serial.print("*");
        //     //atraso de 2ms e gera novo tom
        //     delay(4);
        // }
          
          //Serial.print(tone(2, 1000, 500));
          pos += 20;
          myservo.write(pos);
          Serial.print("cmd: ");
          Serial.println(cmd);
          Serial.print("pos: ");
          Serial.println(pos);
        }
      
        if(cmd == 'b') {
          /*for (byte x=0;x<180;x++){
            //converte graus em radianos
            sinVal = (sin(x*(3.1412/180)));
            //agora gera uma frequencia
            toneVal = 500+(int(sinVal*100));
            //toca o valor no buzzer
            ledcWriteTone(channel,toneVal);
            //Serial.print("*");
            //atraso de 2ms e gera novo tom
            delay(4);
        }*/
          //Serial.print(tone(2, 500, 500));
          pos -= 20;
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
