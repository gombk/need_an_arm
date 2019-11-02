#include <WiFi.h>  
#include <ESP32Servo.h>

#include "FS.h"
#include "SPIFFS.h"

#include "SSD1306Wire.h" // legacy include: `#include "SSD1306.h"`

uint8_t ledPin = 16;

#ifdef __cplusplus
  extern "C" {
#endif
 
  uint8_t temprature_sens_read();
 
#ifdef __cplusplus
}
#endif
 
uint8_t temprature_sens_read();

SSD1306Wire display(0x3c, 5, 4);

#define FORMAT_SPIFFS_IF_FAILED true

// #include "SSD1306Wire.h" // legacy include: `#include "SSD1306.h"`

// SSD1306Wire display(0x3c, 5, 4);

Servo myservo_1;
Servo myservo_2;
Servo myservo_3;
Servo myservo_4;

int servoPin_1 = 2;
int servoPin_2 = 4;
int servoPin_3 = 12;
int servoPin_4 = 14;

int servo_1= 0; //ServoBase
int servo_2= 0; //ServoAnteBraço
int servo_3= 0; //ServoBraço
int servo_4= 0; //ServoGarra

bool FirstCommand = true;

WiFiServer wifiServer(80);

//const char* ssid = "PALINI";
//const char* pass = "us7pe10sf2pa5";

const char* ssid = "Heimskr";
const char* pass = "THEENDOFTIMES";


void drawLines() {
  
  for (int16_t i=0; i<display.getHeight(); i+=4) {
    display.drawLine(display.getWidth()-1, 0, 0, i);
    display.display();
    delay(10);
  }
  for (int16_t i=0; i<display.getWidth(); i+=4) {
    display.drawLine(display.getWidth()-1, 0, i, display.getHeight()-1);
    display.display();
    delay(10);
  }
  display.clear();
}

void listDir(fs::FS &fs, const char * dirname, uint8_t levels){
    Serial.printf("Listing directory: %s\r\n", dirname);

    File root = fs.open(dirname);
    if(!root){
        Serial.println("- failed to open directory");
        return;
    }
    if(!root.isDirectory()){
        Serial.println(" - not a directory");
        return;
    }

    File file = root.openNextFile();
    while(file){
        if(file.isDirectory()){
            Serial.print("  DIR : ");
            Serial.println(file.name());
            if(levels){
                listDir(fs, file.name(), levels -1);
            }
        } else {
            Serial.print("  FILE: ");
            Serial.print(file.name());
            Serial.print("\tSIZE: ");
            Serial.println(file.size());
        }
        file = root.openNextFile();
    }
}



void writeFile(fs::FS &fs, const char * path, const char * message){
    Serial.printf("Writing file: %s\r\n", path);

    File file = fs.open(path, FILE_WRITE);
    if(!file){
        Serial.println("- failed to open file for writing");
        return;
    }
    if(file.print(message)){
        //Serial.println("- file written");
    } else {
        //Serial.println("- frite failed");
    }
}

void appendFile(fs::FS &fs, const char * path, const char * message){
    Serial.printf("Appending to file: %s\r\n", path);

    File file = fs.open(path, FILE_APPEND);
    if(!file){
        Serial.println("- failed to open file for appending");
        return;
    }
    if(file.print(message)){
        //Serial.println("- message appended");
    } else {
        //Serial.println("- append failed");
    }
}


void setup() {
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, HIGH);
  Serial.begin(115200);
  display.init();
  drawLines();
  delay(100);
  WiFi.begin(ssid, pass);
  while (WiFi.status() != WL_CONNECTED) {
  Serial.print("IP:");
  Serial.println(WiFi.localIP());
    delay(1000);
    display.drawString(0, 0, "Connecting to: ");
    display.drawString(0, 10, String(ssid));
    display.display();
    Serial.println("Connectando");
  }
  display.clear();
  display.drawString(0, 0, "Connected to: ");
  display.drawString(0, 10, String(ssid));
  display.display();
  Serial.println(WiFi.localIP());
  wifiServer.begin();
  
  myservo_1.setPeriodHertz(50);    // standard 50 hz servo
  myservo_1.attach(servoPin_1, 1000, 2000); // attaches the servo on pin 18 to the servo object
  myservo_2.setPeriodHertz(50);    // standard 50 hz servo
  myservo_2.attach(servoPin_2, 1000, 2000); // attaches the servo on pin 18 to the servo object
  myservo_3.setPeriodHertz(50);    // standard 50 hz servo
  myservo_3.attach(servoPin_3, 1000, 2000); // attaches the servo on pin 18 to the servo object
  myservo_4.setPeriodHertz(50);    // standard 50 hz servo
  myservo_4.attach(servoPin_4, 1000, 2000); // attaches the servo on pin 18 to the servo object

  if(!SPIFFS.begin(FORMAT_SPIFFS_IF_FAILED)){
        Serial.println("SPIFFS Mount Failed");
        return;
    }
    
    //listDir(SPIFFS, "/", 0);
    //writeFile(SPIFFS, "/commands.txt", "");
}

void Movement(char* command, String modeOp)
{

              display.clear();
              Serial.println(command);
              String WServo = getValue(command, ':', 0);
              String PServo = getValue(command, ':', 1);
              String VServo = getValue(command, ':', 2);

              Serial.println(WServo);
              int PosServo = PServo.toInt();
              Serial.println(PosServo);
              int VelServo = VServo.toInt();
              Serial.println(VelServo);

              

              /*Para fazer a gravação primeiro deve ser enviado um comando E sozinho para ele recriar o arquivo e após isso 
               *enviar o comando da seguinte maneira W:A:0:0 sendo q o W é o comando de escrita e os seguintes são os
               *comandos que serão gravados no arquivo.
               */
              
              if(WServo == "A")
              {
                myservo_1.write(PosServo);
                servo_1 = PosServo;
                Serial.print("Servo 1: ");
                Serial.println(PosServo);                
              }else if(WServo == "B")
              {
                myservo_2.write(PosServo);
                servo_2 = PosServo;
                Serial.print("Servo 1: ");
                Serial.println(PosServo); 
              }else if(WServo == "C")
              {
                myservo_3.write(PosServo);
                servo_3 = PosServo;
                Serial.print("Servo 3: ");
                Serial.println(PosServo); 
              }else if(WServo == "D")
              {
                myservo_4.write(PosServo);
                servo_4 = PosServo;
                Serial.print("Servo 4: ");
                Serial.println(PosServo); 
              }else if(WServo == "E") //Executa comando de WriteFile
              {
                Serial.print("Erasing file");
                writeFile(SPIFFS, "/commands.txt",  "A:0:0"); //Cria um arquivo vazio para depois ser carregado com os comandos
                writeFile(SPIFFS, "/commands.txt",  "B:0:0");
                writeFile(SPIFFS, "/commands.txt",  "C:0:0");
                writeFile(SPIFFS, "/commands.txt",  "D:0:0");
              }else if(WServo == "W") //Adiciona comandos ao arquivo existente
              {
                WServo = getValue(command, ':', 1);
                PServo = getValue(command, ':', 2);
                VServo = getValue(command, ':', 3);

                
                String commandConcat = WServo + ":" + PServo + ":" + VServo;

                char commandConcatChar[50];
                commandConcat.toCharArray(commandConcatChar, 50); 
                
                Serial.print("Writing: ");
                Serial.println(commandConcatChar);
                
                appendFile(SPIFFS, "/commands.txt", commandConcatChar); //Grava no arquivo o comando recebido

                Serial.println("Pulando linha");
                
                appendFile(SPIFFS, "/commands.txt", "\r\n"); //Pula uma linha pra o proximo comando
              }else{
                Serial.println("Command not found");
              }
              
              
              display.drawString(0, 0, "IP: " + WiFi.localIP().toString());
              display.drawString(0, 15, "Mode: " + modeOp);
              display.drawString(0, 30, "Servo_1: " + String(servo_1));
              display.drawString(0, 40, "Servo_2: " + String(servo_2));
              display.drawString(0, 50, "Servo_3: " + String(servo_3));
              display.drawString(65, 30, "Claw: " +   String(servo_3));
              display.drawString(65, 40, "Vel: " +   String(VelServo));
              display.drawString(65, 50, "Temp: " + String(((temprature_sens_read() - 32) / 1.8)));
              display.display();
              
              delay(VelServo);
}

String getValue(String data, char separator, int index)
{
    int found = 0;
    int strIndex[] = { 0, -1 };
    int maxIndex = data.length() - 1;

    for (int i = 0; i <= maxIndex && found <= index; i++) {
        if (data.charAt(i) == separator || i == maxIndex) {
            found++;
            strIndex[0] = strIndex[1] + 1;
            strIndex[1] = (i == maxIndex) ? i+1 : i;
        }
    }
    return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}

WiFiClient client;

void readFile(fs::FS &fs, const char * path){
    Serial.printf("Reading file: %s\r\n", path);

    File file = fs.open(path);
    if(!file || file.isDirectory()){
        Serial.println("- failed to open file for reading");
        return;
    }

    char buffer[64];
        while (file.available()) {
        //client = wifiServer.available();
        if(!client.connected())
        {
          int l = file.readBytesUntil('\n', buffer, sizeof(buffer));
          buffer[l] = 0;
          //Serial.println("Message Received: ");
          //Serial.write(buffer);    
          Movement(buffer, "Standalone");  
        }else{
          Serial.print("Client Connected");
          digitalWrite(ledPin, LOW);
          break;
        }
      }
}



void loop() { 
  display.init();
  client = wifiServer.available();    
  if (client) {
    while (client.connected()) {
      while (client.available() > 0) {
        digitalWrite(ledPin, LOW);
        String command = String(client.readString());
        char copy[50];
        command.toCharArray(copy, 50);
        Movement(copy, "Live");
      }
    }
    client.stop();
    Serial.println("Client disconnected");
    digitalWrite(ledPin, HIGH);
  }else{
    Serial.println("No Client Connected");
    digitalWrite(ledPin, HIGH);
    readFile(SPIFFS, "/commands.txt");
  }
}
