#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>
#define Blink_LED_1 10
#define Blink_LED_2 9
#define Blink_LED_3 8
#include <SPI.h>
#include <SD.h>

File myFile;

Adafruit_MPU6050 mpu;
unsigned long prevTime = 0;
float d;
bool sign_changed = false;
float prevAcceleration;
bool increasing = false;
bool decreasing = false;
float t;
int changeCount = 0; // Variable to count changes
unsigned long prevTime2 = 0;
float diffZacc;
const int buzzer = 7; // Buzzer is connected to Arduino pin 9
const unsigned long duration = 120000; // Duration in milliseconds (2 minutes)
boolean soundPlayed = false;


void setup(void) {
  pinMode(buzzer, OUTPUT); // Set the buzzer pin as an output
  Serial.begin(115200);
  while (!Serial)
    delay(10); // will pause Zero, Leonardo, etc until serial console opens

  Serial.println("Adafruit MPU6050 test!");

  // Try to initialize!
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  Serial.println("MPU6050 Found!");

  mpu.setAccelerometerRange(MPU6050_RANGE_8_G);
  Serial.print("Accelerometer range set to: ");
  switch (mpu.getAccelerometerRange()) {
  case MPU6050_RANGE_2_G:
    Serial.println("+-2G");
    break;
  case MPU6050_RANGE_4_G:
    Serial.println("+-4G");
    break;
  case MPU6050_RANGE_8_G:
    Serial.println("+-8G");
    break;
  case MPU6050_RANGE_16_G:
    Serial.println("+-16G");
    break;
  }
  mpu.setGyroRange(MPU6050_RANGE_500_DEG);
  Serial.print("Gyro range set to: ");
  switch (mpu.getGyroRange()) {
  case MPU6050_RANGE_250_DEG:
    Serial.println("+- 250 deg/s");
    break;
  case MPU6050_RANGE_500_DEG:
    Serial.println("+- 500 deg/s");
    break;
  case MPU6050_RANGE_1000_DEG:
    Serial.println("+- 1000 deg/s");
    break;
  case MPU6050_RANGE_2000_DEG:
    Serial.println("+- 2000 deg/s");
    break;
  }

  mpu.setFilterBandwidth(MPU6050_BAND_5_HZ);
  Serial.print("Filter bandwidth set to: ");
  switch (mpu.getFilterBandwidth()) {
  case MPU6050_BAND_260_HZ:
    Serial.println("260 Hz");
    break;
  case MPU6050_BAND_184_HZ:
    Serial.println("184 Hz");
    break;
  case MPU6050_BAND_94_HZ:
    Serial.println("94 Hz");
    break;
  case MPU6050_BAND_44_HZ:
    Serial.println("44 Hz");
    break;
  case MPU6050_BAND_21_HZ:
    Serial.println("21 Hz");
    break;
  case MPU6050_BAND_10_HZ:
    Serial.println("10 Hz");
    break;
  case MPU6050_BAND_5_HZ:
    Serial.println("5 Hz");
    break;
  }

  // SD card initialization
Serial.print("Initializing SD card...");

  if (!SD.begin(4)) {
    Serial.println("initialization failed!");
    while (1);
  }
  Serial.println("initialization done.");
  myFile = SD.open("tekst.txt", FILE_WRITE); // Open file for writing

  if (myFile) {
    // Write header to the file
    myFile.println("Time (ms), Distance (cm), Frequency (Hz)");
    myFile.close();
  } else {
    Serial.println("Error opening data.csv for writing.");
  }

  myFile = SD.open("test.txt");
  if (myFile) {
    Serial.println("test.txt:");

    // read from the file until there's nothing else in it:
    while (myFile.available()) {
      Serial.write(myFile.read());
    }
    // close the file:
    myFile.close();
  } else {
    // if the file didn't open, print an error:
    Serial.println("error opening test.txt");
  }
}
void loop() {
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);
  unsigned long currentTime = millis();

if (!soundPlayed) {
    // Play the sound sequence only once
    for (int i = 0; i <= 2; i++) {
      tone(buzzer, 494);
      delay(1000);
      noTone(buzzer);
      delay(1000);
    }

    tone(buzzer, 988);
    delay(100);
    noTone(buzzer);
    delay(500);

  

  while (millis() - currentTime < duration) {
    tone(buzzer, 1200);
    delay(200);
    noTone(buzzer);
    delay(500);}
  

  tone(buzzer, 494);
  delay(2000);
soundPlayed = true; // Set the flag to true to indicate that the sound has been played.
  }
  // After 2 minutes, the loop will exit, and the buzzer will stop.
  noTone(buzzer);

  if (!increasing && !decreasing) {
    if (a.acceleration.z > prevAcceleration) {
      increasing = true;
    } else if (a.acceleration.z < prevAcceleration) {
      decreasing = true;
    }
  }

  if (sqrt((a.acceleration.z - prevAcceleration)*(a.acceleration.z - prevAcceleration)) > 0.9969) {
    if (increasing && a.acceleration.z < prevAcceleration) {
      // Change from increasing to decreasing
      Serial.println("Acceleration change: Increasing to Decreasing");
      Serial.print("Time before change: ");
      Serial.print(prevTime);
      Serial.print(" ms, Acceleration before change: ");
      Serial.println(prevAcceleration);
      increasing = false;
      decreasing = false;
      diffZacc = sqrt((a.acceleration.z - prevAcceleration)*(a.acceleration.z - prevAcceleration));
      changeCount++;
    } else if (decreasing && a.acceleration.z > prevAcceleration) {
      // Change from decreasing to increasing
      Serial.println("Acceleration change: Decreasing to Increasing");
      Serial.print("Time before change: ");
      Serial.print(prevTime);
      Serial.print(" ms, Acceleration before change: ");
      Serial.println(prevAcceleration);
      increasing = false;
      decreasing = false;
      diffZacc = sqrt((a.acceleration.z - prevAcceleration)*(a.acceleration.z - prevAcceleration));
      changeCount++;
    } else {
      diffZacc = 0;
    }

    // Odległość (Distance)
    t = currentTime - prevTime;
    d = 0.5 * diffZacc * t * t / 10000;
    Serial.print("T: ");
    Serial.print(t);
    Serial.print("ms  A: ");
    Serial.print(diffZacc);
    Serial.print("m/s^2  D: ");
    Serial.println(d);

    prevAcceleration = a.acceleration.z;

    if (currentTime - prevTime >= 100) {
      prevTime = currentTime;
      // Log the current time and acceleration
      Serial.print("Time: ");
      Serial.print(currentTime);
      Serial.print(" ms, Acceleration: ");
      Serial.println(a.acceleration.z);
      myFile = SD.open("data.txt", FILE_WRITE);
    if (myFile) {
      myFile.print("Time: ");
      myFile.print(currentTime);
      myFile.print(" ms, Distance: ");
      myFile.print(d);
      myFile.print(" m, Frequency: ");
      myFile.print(changeCount / 5.0); // Calculate and write frequency
      myFile.println(" Hz");
      myFile.close();
    } else {
      Serial.println("Error opening file for writing");
    }

    // Display change count and frequency every 5 seconds (5000 milliseconds)
    if (currentTime - prevTime2 >= 5000) {
      Serial.print("Change count: ");
      Serial.println(changeCount);
      float frequency = changeCount / 5*2;// Calculate frequency
      Serial.print("Frequency: ");
      Serial.print(frequency);
      Serial.println(" Hz");
      changeCount = 0; // Reset change count
      prevTime2 = currentTime; // Reset timer
    
         if (frequency < 1.6) {
         digitalWrite(Blink_LED_1, HIGH);
         digitalWrite(Blink_LED_2, LOW);
         digitalWrite(Blink_LED_3, LOW);
         Serial.println("Za wolno");
         delay(500);
         }else if (frequency >= 1.6 && frequency <= 2){
          digitalWrite(Blink_LED_1, LOW);
          digitalWrite(Blink_LED_2, HIGH);
          digitalWrite(Blink_LED_3, LOW);
          Serial.println("Dobre tempo");
          delay(500);
          }else if (frequency > 2) {
            digitalWrite(Blink_LED_1, LOW);
            digitalWrite(Blink_LED_2, LOW);
            digitalWrite(Blink_LED_3, HIGH);
            Serial.println("Za szybko");
            delay(500);
          }
      }
    }
  delay(100);
}
}