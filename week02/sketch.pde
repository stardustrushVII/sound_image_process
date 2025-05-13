PImage img;

void setup() {
  size(267, 373);
  img = loadImage("input.jpg");
  img.loadPixels();

  color c1 = color(0);      // black
  color c2 = color(255);    // white
  float threshold = 127;

  for (int i = 0; i < img.pixels.length; i++) {
    float b = brightness(img.pixels[i]);
    img.pixels[i] = b > threshold ? c1 : c2;
  }

  img.updatePixels();
  image(img, 0, 0);
}
