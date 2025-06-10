void setup() {
  size(1600, 900); // 900p res
  background(255); 
  stroke(0);
  noSmooth(); // anti-aliasing destroyed
  noFill();
  
}

void draw() {
  background(255); // destroys animation smear
  
  for (int y = 20; y <= height - 20; y += 10) { // draws horizontal lines top to bott
    beginShape();
    
    for (int x = 0; x <= width; x += 20) { // same but width
      float offset = 28 * sin(radians(x + y - frameCount * 1.1)); // animated wave pattern
      vertex(x, y + offset); // offset that creates the wave
    }
    endShape();
  }
}
