# Need an arm?

Mobile application and source code ESP32 (.ino), for controlling a robotic arm using ESP32, by Servo

Aplicativo móvel e código-fonte ESP32 (.ino), para controle de braço robótico usando o ESP32, utilizando Servos

Desenvolvido na Faculdade de Engenharia de Computação da UNIPINHAL (https://www.unipinhal.edu.br/)

Orientado por: Professor Jean Vieira

Matéria: Tópicos Especiais em Engenharia de Compoutação 2 - 2019

# Precisa de um braço?

Aplicativo móvel para controlar um braço robótico usando ESP32 ou Arduino por WIFI

# Escopo do aplicativo
Este aplicativo é responsável por controlar um braço robótico via soquete na sua rede local / remota (para conexões remotas, você precisa configurar a porta nas configurações do aplicativo ou na fonte). O aplicativo está configurado para controlar um braço robótico com 3 servomotores.

# FAÇAM
Para fazer a lista |
------------------ |
Concluir o recurso de gravação |
Conclua a tela de opções |

# Software e equipamentos necessários
1. ESP-32
2. Braço robótico com 3 servos ou mais
3. Estrutura de vibração para compilar o aplicativo no seu dispositivo móvel (Android / iOS)
4. Arduino IDE com o ESP-32 e [Servo library] (https://platformio.org/lib/show/4744/ESP32Servo) instalado

# Compilando o aplicativo móvel
1. Clone o projeto usando `git clone https://github.com/gombk/need_an_arm.git`
2. Instale a estrutura do Flutter no seu computador, use [este guia] (https://flutter.dev/docs/get-started/install) para obter referência sobre como instalar o Flutter
3. Usando o terminal de sua preferência, navegue até o diretório em que você clonou o projeto (ou seja, i.e cd `c:\need_an_arm`)
4. Conecte seu dispositivo móvel ou emulador de preferência ao seu computador
5. Digite `flutter run` no terminal para compilar o aplicativo

# Compilando o projeto ESP-32
1. Clone o projeto usando `git clone https://github.com/gombk/need_an_arm.git`
2. Instale o [Arduino IDE] (https://www.arduino.cc/en/Main/Software) e a biblioteca ESP-32 usando o downloader de bibliotecas no Arduino IDE
3. Navegue até a pasta esp32 / main e abra o ** main.ino ** no IDE do Arduino
4. Carregue o código no dispositivo ESP-32
5. Instale a biblioteca ServoESP32 [Arduino IDE Scketch - Biblioteca - Gerenciar bibliotecas] (https://github.com/jkb-git/ESP32Servo)
5. Se isso for feito corretamente, o braço robótico deve fazer um loop de movimento menor, até você se conectar ao aplicativo no IP fornecido pelo IDE do Arduino.




# Application scope
This is app is responsible to control a robotic arm via socket on your local/remote network (for remote connections you need to setup the port in the configurations of the app or in the source). The app is configured to control a robotic arm with 3 servo-motors.

# TODO
To do list    |
------------- |
Finish the recording feature  |
Finish the options screen  |

# Required software & equipments 
1. ESP-32
2. Robotic arm with 3 servos or more
3. Flutter framework to compile the app on your mobile device (Android/iOS)
4. Arduino IDE with the ESP-32 and [Servo library](https://platformio.org/lib/show/4744/ESP32Servo) installed

# Compiling the mobile app
1. Clone the project using `git clone https://github.com/gombk/need_an_arm.git`
2. Install the Flutter framework in your computer, use [this guide](https://flutter.dev/docs/get-started/install) for reference on how to install Flutter
3. Using the terminal of your preference, navigate to the directory on which you've cloned the project (i.e `cd c:\need_an_arm`)
4. Connect your mobile device or emulator of preference into your computer
5. Type `flutter run` into the terminal to compile the app

# Compiling the ESP-32 project
1. Clone the project using `git clone https://github.com/gombk/need_an_arm.git`
2. Install the [Arduino IDE](https://www.arduino.cc/en/Main/Software) and the ESP-32 library using the library downloader in the Arduino IDE
3. Navigate into the esp32/main folder and open the **main.ino** into the Arduino IDE
4. Load the code into the ESP-32 device
5. If it's done correctly, the robotic arm should be making a minor movement loop, until you connect with the app into the provided IP by the Arduino IDE
