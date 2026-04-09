##🚀 **Radar-Assisted Border Surveillance for UAV Detection**

##📌 **Overview**
This project presents a low-cost radar-emulation system for detecting UAV intrusions using an ESP32 microcontroller and ultrasonic sensor. It performs 360° sector scanning and provides real-time monitoring with MATLAB visualization.

##🎯 **Features**
 - 🔄 360° sector-based scanning (8 directions)
 - 📡 Real-time intrusion detection
 - 🌐 IoT-based wireless communication
 - 📊 MATLAB radar visualization (polar plot)
 - ⚡ Low-cost, power-efficient design
 - 📈 High detection accuracy (~95%)

##🛠️ **Tech Stack**
**Hardware:** ESP32, Ultrasonic Sensor (HC-SR04), Stepper Motor, LCD
**Software:** Arduino IDE, MATLAB
**Communication:** Wi-Fi (IoT-based monitoring), UART, SPI

##⚙️ **System Architecture**
 - Ultrasonic sensor scans environment using rotating mechanism
 - ESP32 processes distance data
 - Intrusion detection based on threshold distance
 - Data sent via Wi-Fi to MATLAB
 - MATLAB displays radar-like visualization
   
##🔍 **Working Principle**
-The system uses Time-of-Flight (ToF) ultrasonic sensing:
 - Sensor sends ultrasonic waves
 - Measures echo return time
 - Calculates distance
 - Detects intrusion if within threshold range
 - Continuously scans all 8 sectors

##📊 **Results**
 - 📏 Detection Range: ~4 meters
 - ⏱️ Alert Latency: ~0.82 seconds
 - 🎯 Detection Accuracy: ~95%
 - 🔄 Continuous real-time monitoring

##🚀 **Applications**
 - Border surveillance
 - UAV intrusion detection
 - Security monitoring systems
 - Smart defense systems

##🔮 **Future Improvements**
 - Integration with real radar modules
 - Long-range detection
 - AI-based UAV classification
 - Cloud-based monitoring dashboard

##👨‍💻 **Authors**
 - Nanjundeswari M
 - Naveen G
 - Nisita M

##📜 **License**
This project is for academic and research purposes.
