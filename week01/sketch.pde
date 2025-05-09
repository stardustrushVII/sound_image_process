void setup() {
  size(640, 480); // 480p res
  background(255); // white bg
  
  fill(0, 128, 255); // blue
  
}

void draw() {
  background(255); // white bg
  fill(mouseX % 255, mouseY % 255, 150); // colour change via mouse
  ellipse(mouseX, mouseY, 50, 70);
}
