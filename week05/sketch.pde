PImage img;                   
PImage result;                


float[][] kernel = {
  { -1, -1, -1 },
  { -1,  8, -1 },
  { -1, -1, -1 }
};

void setup() {
  size(800, 800);
  img = loadImage("malenia.jpg");   
  img.resize(width, height);      
  result = createImage(width, height, RGB); 
  result.loadPixels();
  img.loadPixels();

  
  for (int y = 1; y < height - 1; y++) {
    for (int x = 1; x < width - 1; x++) {
      
      float sum = 0; 


      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int ix = x + kx;
          int iy = y + ky;
          int idx = ix + iy * width;

          float brightnessAtPixel = brightness(img.pixels[idx]);
          float weight = kernel[ky + 1][kx + 1];

          sum += brightnessAtPixel * weight;
        }
      }

 
      sum = constrain(sum, 0, 255);

  
      result.pixels[x + y * width] = color(sum);
    }
  }

  result.updatePixels(); 
  image(result, 0, 0);   
}
