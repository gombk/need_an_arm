# Need an arm?

Mobile application for controlling a robotic arm.

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