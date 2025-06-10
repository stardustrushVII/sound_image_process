import processing.sound.*;
SoundFile ringSfx;
SoundFile winTheme;

PVector gravity = new PVector(0, 0.4);
ArrayList<Ring> rings = new ArrayList<Ring>();
Spring launcher;
Sonic sonic;
GoalRing goal;
boolean gameOver = false;

void setup() {
  size(1920, 1080); // 1080p res
  sonic = new Sonic(100, 300);
  launcher = new Spring(20, height - 10); // bottom left spring
  goal = new GoalRing(1700, 700);
  ringSfx = new SoundFile(this, "ring.wav");
  winTheme = new SoundFile(this, "victory.wav");

  // ring placement
  for (int i = 0; i < 5; i++) {
    rings.add(new Ring(200 + i * 100, height - 30, ringSfx));
  }
}

float slopeX1 = 600; // width
float slopeY1 = 1100;
float slopeX2 = 1500; // width
float slopeY2 = 750;

float slopeM = (slopeY2 - slopeY1) / (slopeX2 - slopeX1);
float slopeB = slopeY1 - slopeM * slopeX1;

void draw() {
  background(200, 240, 255);
  fill(100, 200, 100);
  noStroke();
  triangle(slopeX1, slopeY1, slopeX2, slopeY1, slopeX2, slopeY2);
  stroke(0);
  line(slopeX1, slopeY1, slopeX2, slopeY2);

  // gravity
  sonic.applyForce(gravity);

  // controls
  if (keyPressed) {
    if (key == 'a') sonic.applyForce(new PVector(-0.2, 0));
    if (key == 'd') sonic.applyForce(new PVector(0.2, 0));
  }
  
  float slopeLineY = slopeM * sonic.position.x + slopeB; // boosting Sonikku if he below slope libe

if (sonic.position.x > slopeX1 && sonic.position.x < slopeX2 &&
    sonic.position.y > slopeLineY) {
  sonic.applyForce(new PVector(0.3, -0.5));
}

// get Y at Sonic current X(box)
float slopeYatX = slopeM * sonic.position.x + slopeB;

// Only apply boost if Sonic is below line
if (sonic.position.x > slopeX1 && sonic.position.x < slopeX2 &&
    sonic.position.y > slopeYatX && sonic.position.y < slopeY1) {

  // Instead of jumping, push Sonic along
  float pushX = 0.4;
  float pushY = -0.4;
  sonic.applyForce(new PVector(pushX, pushY));
}



  sonic.update();
  sonic.display();

  launcher.checkBounce(sonic);
  launcher.display();
  goal.checkWin(sonic);
  if (goal.reached && !gameOver) {
    winTheme.play();
    gameOver = true;
  }
  goal.display();

  // Ring collision
  for (Ring r : rings) {
    r.checkCollisionChaos(sonic);
    r.display();
  }

  fill(0);
  textSize(20);
  text("RINGS: " + sonic.collectedRings, 20, 30);
  
  if (gameOver) {
    textSize(48);
    text("YOU WIN!", width / 2 - 120, height / 2);
    textSize(24);
    text("Press R to Restart", width / 2 - 100, height / 2 + 40);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}

void resetGame() {
  sonic = new Sonic(100, 300);
  launcher = new Spring(20, height - 10);
  rings.clear();
  for (int i = 0; i < 5; i++) {
    rings.add(new Ring(200 + i * 100, height - 30, ringSfx));
  }
  goal = new GoalRing(1700, 700);
  gameOver = false;
}



// --------------------- Sonic class ---------------------
class Sonic {
  PVector position, velocity, acceleration;
  int collectedRings = 0;

  Sonic(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.mult(0.98); // friction

    // boundaries
    if (position.x < 15) {
      position.x = 15;
      velocity.x = 0;
    }
    if (position.x > width - 15) {
      position.x = width - 15;
      velocity.x = 0;
    }

    // ground collision
    if (position.y > height - 20) {
      position.y = height - 20;
      velocity.y *= -0.3;
    }
  }

  void display() {
    fill(0, 50, 200);
    ellipse(position.x, position.y, 30, 30);
  }
}

// --------------------- Ring class ---------------------
class Ring {
  PVector pos;
  boolean collected = false;
  SoundFile sfx; // sound

  Ring(float x, float y, SoundFile sound) {
    pos = new PVector(x, y);
    sfx = sound;
  }

  void display() {
    if (!collected) {
      noFill();
      stroke(255, 204, 0);
      strokeWeight(4);
      ellipse(pos.x, pos.y, 20, 20);
    }
  }

  void checkCollisionChaos(Sonic s) {
    if (!collected && dist(s.position.x, s.position.y, pos.x, pos.y) < 20) {
      collected = true;
      s.collectedRings++;
      sfx.play();
    }
  }
}

// --------------------- Spring class ---------------------
class Spring {
  PVector pos;
  float h = 20;
  float w = 10;
  boolean ready = true;

  Spring(float x, float y) {
    pos = new PVector(x, y);
  }

  void display() {
    fill(255, 0, 0);
    rect(pos.x, pos.y, w, h);
  }

  void checkBounce(Sonic s) {
    if (
      s.position.x > pos.x &&
      s.position.x < pos.x + w &&
      s.position.y > pos.y - 15 &&
      s.position.y < pos.y + h
    ) {
      if (ready) {
        s.applyForce(new PVector(12, 0)); // launch Sonic
        ready = false;
      }
    } else {
      ready = true;
      

    }
  }
}

class GoalRing {
  PVector pos;
  boolean reached = false;

  GoalRing(float x, float y) {
    pos = new PVector(x, y);
  }

  void display() {
    if (!reached) {
      noFill();
      stroke(0, 255, 255);
      strokeWeight(6);
      ellipse(pos.x, pos.y, 40, 40);
    }
  }

  void checkWin(Sonic s) {
    if (!reached && dist(s.position.x, s.position.y, pos.x, pos.y) < 30) {
      reached = true;
    }
  }
}
