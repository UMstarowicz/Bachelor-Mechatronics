const int xpin = A1; // x-axis of the accelerometer
const int ypin = A2; // y-axis
const int zpin = A3; // z-axis (only on 3-axis models)

void setup() {
  // Initialize the serial communications:
  Serial.begin(9600);
}

void loop() {
  int x = analogRead(xpin); // Read from xpin
  int y = analogRead(ypin); // Read from ypin
  int z = analogRead(zpin); // Read from zpin

  // Scale factors and zero-g offsets
  float zero_G = 512.0; // ADC midpoint
  float scale = 102.3;  // Sensitivity (mV/g)
  float dt = 0.5;       // Time interval in seconds (adjust as needed)

  // Calculate acceleration in g-force units
  float x_acceleration = ((float)x - zero_G) / scale;
  float y_acceleration = ((float)y - zero_G) / scale;
  float z_acceleration = ((float)z - zero_G) / scale;

  // Calculate velocity by integrating acceleration (discrete integral)
  static float x_velocity = 0.0;
  static float y_velocity = 0.0;
  static float z_velocity = 0.0;

  x_velocity += x_acceleration * dt;
  y_velocity += y_acceleration * dt;
  z_velocity += z_acceleration * dt;

  // Calculate displacement by integrating velocity (discrete integral)
  static float x_displacement = 0.0;
  static float y_displacement = 0.0;
  static float z_displacement = 0.0;

  x_displacement += x_velocity * dt;
  y_displacement += y_velocity * dt;
  z_displacement += z_velocity * dt;

  // Print the displacement values to the serial monitor
  Serial.print("X Displacement: ");
  Serial.print(x_displacement);
  Serial.print("\tY Displacement: ");
  Serial.print(y_displacement);
  Serial.print("\tZ Displacement: ");
  Serial.println(z_displacement);

  delay(500); // Adjust the delay as needed for your application
}
