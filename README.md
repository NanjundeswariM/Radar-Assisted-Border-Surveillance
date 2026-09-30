# 🚀 Radar-Assisted Border Surveillance for UAV Detection

## 📌 Overview
This project presents a low-cost radar-emulation system for detecting UAV intrusions using an ESP32 microcontroller and an ultrasonic sensor. It performs 360° sector scanning and provides real-time monitoring with MATLAB visualization.

## 📚 Publication

This work was presented and published at **ICTMIM 2026**.

**Title:**
*Sector-Scanning Ultrasonic Radar-Emulation System for Short-Range UAV Intrusion Detection*

**Conference:**
ICTMIM 2026 – International Conference

**Paper ID:** ICTMIM-237

**DOI:** [10.1109/ICTMIM68190.2026.11507855](https://doi.org/10.1109/ICTMIM68190.2026.11507855)

**Presentation:** Online Presentation

### Citation

 > Nanjundeswari M., Naveen G., Nisita M., “Sector-Scanning Ultrasonic Radar-Emulation System for Short-Range UAV Intrusion Detection,” *ICTMIM 2026*, Paper ID: ICTMIM-237, 2026. DOI: 10.1109/ICTMIM68190.2026.11507855.


## 🎯 Features
- 🔄 360° sector-based scanning (8 directions)
- 📡 Real-time intrusion detection
- 🌐 IoT-based wireless communication
- 📊 MATLAB radar visualization (polar plot)
- ⚡ Low-cost, power-efficient design
- 📈 High detection accuracy (~95%)

## 🛠️ Tech Stack
**Hardware:**
- ESP32
- Ultrasonic Sensor (HC-SR04)
- Stepper Motor
- LCD Display

**Software:**
- Arduino IDE
- MATLAB

**Communication:**
- Wi-Fi (IoT-based monitoring)
- UART
- SPI

## ⚙️ System Architecture
- Ultrasonic sensor scans the environment using a rotating mechanism
- ESP32 processes distance data
- Intrusion detection is based on a threshold distance
- Data is sent via Wi-Fi to MATLAB
- MATLAB displays radar-like visualization

## 🔍 Working Principle
The system uses Time-of-Flight (ToF) ultrasonic sensing:
- The sensor transmits ultrasonic waves
- Measures the echo return time
- Calculates the distance
- Detects intrusion if within a threshold range
- Continuously scans all 8 sectors

## 📊 Results
- 📏 Detection Range: ~4 meters
- ⏱️ Alert Latency: ~0.82 seconds
- 🎯 Detection Accuracy: ~95%
- 🔄 Continuous real-time monitoring

## 🚀 Applications
- Border surveillance
- UAV intrusion detection
- Security monitoring systems
- Smart defense systems

## 🔮 Future Improvements
- Integration with real radar modules
- Long-range detection capability
- AI-based UAV classification
- Cloud-based monitoring dashboard

## 👨‍💻 Authors
- Nanjundeswari M
- Naveen G
- Nisita M

## ✅ Conclusion
This project demonstrates an efficient and low-cost approach to UAV intrusion detection using a radar-emulation system. By integrating an ESP32 with an ultrasonic sensor and MATLAB visualization, the system achieves reliable real-time monitoring with high accuracy. The implementation proves that affordable embedded systems can be effectively used for surveillance applications. With further enhancements, this system can be scaled for advanced defense and security solutions.

## 📜 License
This project is intended for academic and research purposes.
