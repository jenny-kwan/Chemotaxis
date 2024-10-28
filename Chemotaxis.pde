// Define colors and settings
color backgroundColor = color(0, 0, 0); // Black background
int numDots = 100; // Initial number of dots
PacMan pacman; // Pac-Man instance
Dot[] dots; // Array of dots

// Dot class
class Dot {
  float x, y; // Position
  boolean eaten; // Status of dot

  Dot() { // Constructor
    x = random(width);
    y = random(height);
    eaten = false; // Dot is initially not eaten
  }
  
  void show() {
    if (!eaten) {
      fill(255); // White color for dots
      noStroke();
      ellipse(x, y, 10, 10); // Draw the dot
    }
  }

  void move() {
    // Dots move randomly
    x += random(-1, 1); // Random horizontal movement
    y += random(-1, 1); // Random vertical movement

    // Keep dots within the bounds
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
}

// Pac-Man class
class PacMan {
  float x, y; // Position
  float size; // Size of Pac-Man

  PacMan() { // Constructor
    x = width / 2;
    y = height / 2;
    size = 40; // Size of Pac-Man
  }
  
  void move() {
    x = mouseX; // Pac-Man follows the mouse horizontally
    y = mouseY; // Pac-Man follows the mouse vertically

    // Keep Pac-Man within bounds
    x = constrain(x, size / 2, width - size / 2);
    y = constrain(y, size / 2, height - size / 2);
  }
  
  void show() {
    fill(255, 255, 0); // Yellow color for Pac-Man
    noStroke();
    arc(x, y, size, size, radians(45), radians(315), PIE); // Draw Pac-Man as an arc
  }
}

// Initialize arrays and setup
void setup() {
  size(600, 400);
  background(backgroundColor);
  
  // Initialize dots array
  dots = new Dot[numDots];
  
  for (int i = 0; i < numDots; i++) {
    dots[i] = new Dot();
  }
  
  pacman = new PacMan(); // Create Pac-Man instance
}

void draw() {
  background(backgroundColor); // Clear background for each frame

  // Move and show Pac-Man
  pacman.move();
  pacman.show();

  // Show and check for collisions with dots
  for (int i = 0; i < dots.length; i++) {
    dots[i].move(); // Move each dot
    dots[i].show(); // Draw each dot
    if (!dots[i].eaten) {
      // Check for collision with Pac-Man
      if (dist(pacman.x, pacman.y, dots[i].x, dots[i].y) < pacman.size / 2 + 5) {
        dots[i].eaten = true; // Mark dot as eaten
      }
    }
  }

  // Spawn new dots
  if (frameCount % 60 == 0) { // Every 60 frames
    spawnNewDot();
  }
}

// Function to spawn a new dot
void spawnNewDot() {
  Dot[] tempDots = new Dot[dots.length + 1]; // Create new array with an additional dot
  for (int i = 0; i < dots.length; i++) {
    tempDots[i] = dots[i]; // Copy existing dots
  }
  tempDots[dots.length] = new Dot(); // Add a new dot
  dots = tempDots; // Update the dots array
}
