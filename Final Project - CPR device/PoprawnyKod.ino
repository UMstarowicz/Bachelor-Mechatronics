#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>
//#include <SPI.h>
//#include <SD.h>
#define Blink_LED_1 13
#define Blink_LED_2 12
#define Blink_LED_3 11

Adafruit_MPU6050 mpu;
// bytes are half the size of int's, but restricted to a max value of 255
//byte button;
//byte oldbutton = 0;
//byte buttonpin = 2;
//byte state = 0;
//float prev_acc_z = 0.0;
unsigned long prevTime = 0;
//File myFile;
//unsigned long currentTime = 0;

float d;
//float r = 0.0;
//float prev_diff = 0.0;
bool sign_changed = false;
float prevAcceleration;
bool increasing = false;
bool decreasing = false;
unsigned long currentTime = millis();
//float frequency;
float t;
//float acc;
int changeCount = 0;
const int buzzer = 9;
// change this to match your SD shield or module:
// Adafruit SD shields and modules: pin 10
// Sparkfun SD shield: pin 8
//mega pin = 53;
const int chipSelect = 10;
char charRead;
char runMode;
byte i=0; //counter
char dataStr[100] = "";
 char buffer[7];

void setup(void) {
  Serial.begin(115200);
//  pinMode(buttonpin, INPUT);
  //pinMode(12, OUTPUT);
  pinMode(Blink_LED_1, OUTPUT);
pinMode(Blink_LED_2, OUTPUT);
pinMode(Blink_LED_3, OUTPUT);
 pinMode(buzzer, OUTPUT);
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
/*
   if (SD.begin(chipSelect))
  {
    Serial.println("SD card is present & ready");
  } 
  else
  {
    Serial.println("SD card missing or failure");
    while(1); //halt program
  }
  //clear out old data file
  if (SD.exists("csv.txt")) 
  {
    Serial.println("Removing simple.txt");
    SD.remove("csv.txt");
    Serial.println("Done");
  } 

  //write csv headers to file:
   myFile = SD.open("csv.txt", FILE_WRITE);  
   if (myFile) // it opened OK
    {
    Serial.println("Writing headers to csv.txt");
    myFile.println("Czas, Przyśpieszenie, Odległość, Częstotliwość");
    myFile.close(); 
    Serial.println("Headers written");
    }
  else 
    Serial.println("Error opening csv.txt");  

  Serial.println("");
  delay(100);

*/
}
void loop() {

 /*button = digitalRead(buttonpin);
  if(button && !oldbutton) // same as if(button == high && oldbutton == low)
  {
    //we have a new button press
    if(state == 0) // if the state is off, turn it on
    {
      digitalWrite(12, HIGH);
      state = 1;
    }
    else // if the state is on, turn it off
    {
      digitalWrite(12, LOW);
      state = 0; 
    }
    oldbutton = 1;
  }
  else if(!button && oldbutton) // same as if(button == low && oldbutton == high)
  {
    // the button was released
    oldbutton = 0;
  }*/

  /* Get new sensor events with the readings */
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);
//currentTime = millis();
  /* Print out the values */
  Serial.print("Acceleration Z: ");
  /*Serial.print(a.acceleration.x);
  Serial.print(", Y: ");
  Serial.print(a.acceleration.y);
  Serial.print(", Z: ");*/
  Serial.print(a.acceleration.z);
  Serial.println(" m/s^2");

  if (!increasing && !decreasing) {
    if (a.acceleration.z > prevAcceleration) {
      increasing = true;
    } else if (a.acceleration.z < prevAcceleration) {
      decreasing = true;
    }
 }

 float diffZacc = a.acceleration.z - prevAcceleration;

if (diffZacc > 0.5){
  if (increasing && a.acceleration.z < prevAcceleration) {
    // Change from increasing to decreasing
    Serial.println("Acceleration change: Increasing to Decreasing");
    Serial.print("Time before change: ");
    Serial.print(prevTime);
    Serial.print(" ms, Acceleration before change: ");
    Serial.println(prevAcceleration);
    increasing = false;
    decreasing = false;
    //changeCount++;
  } else if (decreasing && a.acceleration.z > prevAcceleration) {
    // Change from decreasing to increasing
    Serial.println("Acceleration change: Decreasing to Increasing");
    Serial.print("Time before change: ");
    Serial.print(prevTime);
    Serial.print(" ms, Acceleration before change: ");
    Serial.println(prevAcceleration);
    increasing = false;
    decreasing = false;
    //changeCount++;
  }

} 
else
{
  diffZacc = 0;
    increasing = false;
    decreasing = false;
}

// Odległość
t = (currentTime - prevTime) * (currentTime - prevTime);
//float acc = a.acceleration.z - prevAcceleration;
d = 0.5 * diffZacc * t / 10000;
//Serial.print("T: ");
//Serial.print(t);
Serial.print("A: ");
Serial.print(diffZacc);
Serial.print("m/s^2  D: ");
Serial.println(d);

// Częstotliwość

  prevAcceleration = a.acceleration.z;

  /*if (currentTime - prevTime >= 100) {  //Co to?
    //prevTime = currentTime;
    // Log the current time and acceleration
    Serial.print("Time: ");
    Serial.print(currentTime);
    Serial.print(" ms, Acceleration: ");
    Serial.println(a.acceleration.z);
  }*/
float frequency = changeCount / 5.0;
if (currentTime - prevTime >= 5000) {
Serial.print("Change count: ");
Serial.println(changeCount);
 // Calculate frequency
Serial.print("Frequency: ");
Serial.print(frequency);
Serial.println(" Hz");

if (frequency > 100){
 digitalWrite(Blink_LED_1, HIGH);
digitalWrite(Blink_LED_2, LOW);
digitalWrite(Blink_LED_3, LOW);
//Serial.println("Za wolno");
//delay(500);
}else if (frequency > 100 && frequency < 120){
digitalWrite(Blink_LED_1, LOW);
digitalWrite(Blink_LED_2, HIGH);
digitalWrite(Blink_LED_3, LOW);
//Serial.println("Dobre tempo");
//delay(500);

}else if (frequency > 120) {
digitalWrite(Blink_LED_1, LOW);
digitalWrite(Blink_LED_2, LOW);
digitalWrite(Blink_LED_3, HIGH);
//Serial.println("Za szybko");
//delay(500);
    }
    changeCount = 0; // Reset change count
    //prevTime = currentTime; // Reset timer
  }
/*
// Buzzer
  tone(buzzer, 1000); // Send 1KHz sound signal...
  delay(1000);        // ...for 1 sec
  noTone(buzzer);     // Stop sound...
  delay(1000); 

  dataStr[0] = 0;
//----------------------- using c-type ---------------------------
 //convert floats to string and assemble c-type char string for writing:
 ltoa(currentTime,buffer,10); //conver long to charStr
 strcat(dataStr, buffer);//add it onto the end
 strcat( dataStr, ", "); //append the delimeter
 
 //dtostrf(floatVal, minimum width, precision, character array);
 dtostrf(a.acceleration.z, 5, 1, buffer);  //5 is mininum width, 1 is precision; float value is copied onto buff
 strcat( dataStr, buffer); //append the coverted float
 strcat( dataStr, ", "); //append the delimeter

 dtostrf(d, 5, 1, buffer);  //5 is mininum width, 1 is precision; float value is copied onto buff
 strcat( dataStr, buffer); //append the coverted float
 strcat( dataStr, ", "); //append the delimeter

dtostrf(frequency, 5, 1, buffer);  //5 is mininum width, 1 is precision; float value is copied onto buff
 strcat( dataStr, buffer); //append the coverted float
 strcat( dataStr, 0); //terminate correctly 
 //Serial.println(dataStr);
 //create a loop to read from the keyboard a command character
 //this will be 'r' for read, 'w' for write and 'd' for delete.

  if (Serial.available()) //get command from keyboard:
     {
      charRead = tolower(Serial.read());  //force ucase
      Serial.write(charRead); //write it back to Serial window
      Serial.println();
     }

  if(runMode == 'W') //write to file
  {     
   //----- display on local Serial monitor: ------------
   Serial.print(currentTime); Serial.print("ms  ");
   Serial.print(a.acceleration.z); 
   //Serial.write(0xC2);  //send degree symbol
   //Serial.write(0xB0);  //send degree symbol
   Serial.print("m/s2   ");  
   Serial.print(d); Serial.println("cm");
   Serial.print(frequency); Serial.println("Hz");

   // open the file. note that only one file can be open at a time,
    myFile = SD.open("csv.txt", FILE_WRITE);     
    // if the file opened okay, write to it:
    if (myFile) 
    {
      Serial.println("Writing to csv.txt");
      myFile.println(dataStr); 
      myFile.println(dataStr); 
      myFile.close();
    } 
    else 
    {
      Serial.println("error opening csv.txt");
    }
    delay(1000);  
  }
*/
prevTime = currentTime;
  delay(100);
}
