#define BLYNK_TEMPLATE_ID "TMPL3Htj1QhxE"
#define BLYNK_TEMPLATE_NAME "Border Safety"
#define BLYNK_AUTH_TOKEN "dFC2N1skQcpNUPg4Stu4r_8Jlu7EStGu"

#define BLYNK_PRINT Serial

#include <WiFi.h>
#include <WiFiClient.h>
#include <BlynkSimpleEsp32.h>
#include <LiquidCrystal.h>
#include <Stepper.h>

char auth[] = BLYNK_AUTH_TOKEN;
const char* ssid = "PROJECT";
const char* password = "12341234";

// ===== LCD Pins =====
LiquidCrystal lcd(23, 19, 18, 17, 16, 15);

// ===== Stepper Motor =====
const int STEPS_PER_REV = 2048;   // 28BYJ-48
Stepper stepperMotor(STEPS_PER_REV, 14, 27, 26, 25);

// ===== Ultrasonic Sensor =====
#define trigPin 12
#define echoPin 13

long duration;
int distance;

// ===== Scan Settings =====
const int STEP_ANGLE = 5;                    // 5 degree step
const int STEPS_PER_ANGLE = STEPS_PER_REV / 72;

int currentAngle = 0;
bool clockwise = true;

String statuss = "";

// ================== SETUP ==================
void setup() {

  Serial.begin(115200);
  Blynk.begin(auth, ssid, password);

  lcd.begin(16, 2);
  lcd.clear();
  lcd.print("Radar Initializing");

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  stepperMotor.setSpeed(10);   // RPM

  delay(2000);
  lcd.clear();

  currentAngle = 0;   // Start facing EAST
}

// ================== LOOP ==================
void loop() {

  Blynk.run();

  // ----- CLOCKWISE -----
  if (clockwise) {
    currentAngle += STEP_ANGLE;
    stepperMotor.step(STEPS_PER_ANGLE);

    if (currentAngle >= 360) {
      currentAngle = 360;
      clockwise = false;
    }
  }
  // ----- ANTI-CLOCKWISE -----
  else {
    currentAngle -= STEP_ANGLE;
    stepperMotor.step(-STEPS_PER_ANGLE);

    if (currentAngle <= 0) {
      currentAngle = 0;
      clockwise = true;
    }
  }

  scanAndDisplay(currentAngle);

  delay(120);
}

// ================== SCAN FUNCTION ==================
void scanAndDisplay(int angle) {

  // Trigger ultrasonic
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH, 30000);
  distance = duration * 0.034 / 2;

  // Serial Output (for MATLAB Radar)
  Serial.print(angle);
  Serial.print(",");
  Serial.println(distance);

  // Send to Blynk
  Blynk.virtualWrite(V0, angle);
  Blynk.virtualWrite(V1, distance);

  // LCD Display
  lcd.setCursor(0, 0);
  lcd.print("Ang:");
  lcd.print(angle);
  lcd.print("   ");

  lcd.setCursor(0, 1);
  lcd.print("Dist:");
  lcd.print(distance);
  lcd.print("cm   ");

  // ===== Detection =====
  if (distance > 0 && distance < 10) {

    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Object Detected");

    statuss = getDirection(angle);

    lcd.setCursor(0, 1);
    lcd.print(statuss);

    // Send alert to Blynk
    Blynk.logEvent("alert", statuss);
    Blynk.virtualWrite(V2, statuss);

    delay(1000);
    lcd.clear();
  }
}

// ================== DIRECTION FUNCTION ==================
String getDirection(int angle) {

  if (angle >= 345 || angle < 15) return "East";
  else if (angle < 75)  return "North-East";
  else if (angle < 105) return "North";
  else if (angle < 165) return "North-West";
  else if (angle < 195) return "West";
  else if (angle < 255) return "South-West";
  else if (angle < 285) return "South";
  else return "South-East";
}

