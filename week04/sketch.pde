PImage img;  // Image hold

void setup() {
  size(800, 800);  // 800p res
  img = loadImage("cyberpunk77.jpg");
  img.resize(width, height);    // ccale image to fit canvas
}

void draw() {
  loadPixels();       
  img.loadPixels();   

  // Loop
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int index = x + y * width; // 1D array index from 2D x/y
      color c = img.pixels[index]; // Grab the original color at this pixel

      // calculate the dist mouse
      float d = dist(x, y, mouseX, mouseY);
      float radius = 100; // Set the mask size around the mouse

      // filter
      if (d < radius) {
        // invert colours inside mask
        float r = 255 - red(c);     // invert red
        float g = 255 - green(c);   // invert green
        float b = 255 - blue(c);    // invert blue
        pixels[index] = color(r, g, b); // assigning new colour
        if (x == mouseX && y == mouseY) {
  println("r:", red(c), "g:", green(c), "b:", blue(c));
}

      } else {
        // 🌫️ OUTSIDE MASK: Grayscale using brightness
        float b = brightness(c);    // Get brightness of colour (0–255)
        pixels[index] = color(b);   // Set grayscale colour
      }
    }
  }

  updatePixels(); 
}
