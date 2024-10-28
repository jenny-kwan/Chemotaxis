color backgroundColor = color(0, 0, 0);
int numDots = 100;
PacMan pacman;
Dot[] dots;

class Dot {
  float x, y;
  boolean eaten;

  Dot() {
    x = random(width);
    y = random(height);
    eaten = false;
  }
  
  void show() {
    if (!eaten) {
      fill(255);
      noStroke();
      ellipse(x, y, 10, 10);
    }
  }

  void move() {
    x += random(-1, 1);
    y += random(-1, 1);
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
}

class PacMan {
  float x, y;
  float size;

  PacMan() {
    x = width / 2;
    y = height / 2;
    size = 40;
  }
  
  void move() {
    x = mouseX;
    y = mouseY;
    x = constrain(x, size / 2, width - size / 2);
    y = constrain(y, size / 2, height - size / 2);
  }
  
  void show() {
    fill(255, 255, 0);
    noStroke();
    arc(x, y, size, size, radians(45), radians(315), PIE); // Use PIE for a filled arc
  }
}

void setup() {
  size(600, 400);
  background(backgroundColor);
  
  dots = new Dot[numDots];
  for (int i = 0; i < numDots; i++) {
    dots[i] = new Dot();
  }
  
  pacman = new PacMan();
}

void draw() {
  background(backgroundColor);
  pacman.move();
  pacman.show();

  for (int i = 0; i < dots.length; i++) {
    dots[i].move();
    dots[i].show();
    if (!dots[i].eaten) {
      if (dist(pacman.x, pacman.y, dots[i].x, dots[i].y) < pacman.size / 2 + 5) {
        dots[i].eaten = true;
      }
    }
  }

  if (frameCount % 60 == 0) {
    spawnNewDot();
  }
}

void spawnNewDot() {
  Dot[] tempDots = new Dot[dots.length + 1];
  for (int i = 0; i < dots.length; i++) {
    tempDots[i] = dots[i];
  }
  tempDots[dots.length] = new Dot();
  dots = tempDots;
}
