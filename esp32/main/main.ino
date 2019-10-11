#include <WiFi.h>  

WiFiServer wifiServer(80);

const char* ssid = "PNCFDP-69";
const char* pass = "34997e4f";

void setup() {
  Serial.begin(115200);
  delay(1000);
  WiFi.begin(ssid, pass);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connectando");
  }
  Serial.print("Conectado ao WiFi. IP:");
  Serial.println(WiFi.localIP());
  wifiServer.begin();

}

void loop() {
  WiFiClient client = wifiServer.available();
  if (client) {
    while (client.connected()) {
      while (client.available() > 0) {
        char c = client.read();
        Serial.write(c);
      }
      delay(10);
    }
    client.stop();
    Serial.println("Cliente disconectado");
  }

}
