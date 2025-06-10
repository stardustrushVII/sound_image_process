import processing.sound.*;
SinOsc osc;

void setup() {
  size(1600, 900); // 900p res
  background(255); 
  noSmooth(); // anti-aliasing destroyed
  
  osc = new SinOsc(this);
  osc.freq(440);
  osc.amp(0.2);
  osc.play();
  
}

void draw() {
  background(255); // destroys animation smear
  stroke(0);
  noFill();
  
  // oscillator modulation
  float freq = map(sin(frameCount * 0.01), -1, 1, 200, 1000);
  osc.freq(freq);
  
  //frequency controlling wave depth
  float waveAmp = map(freq, 200, 1000, 5, 40);
  float waveSpeed = map(freq, 200, 1000, 1, 6); // anim speed
  
  // panoramic audio
  float panPos = sin(frameCount * 0.01); // smoothing between -1 and 1
  osc.pan(panPos);
  
  for (int y = 20; y <= height - 20; y += 10) { // draws horizontal lines top to bott
    beginShape();
    
    for (int x = 0; x <= width; x += 20) { // same but width
      float offset = waveAmp * sin(radians(x + y + frameCount * waveSpeed)); // animated wave pattern
      vertex(x, y + offset); // offset that creates the wave
    }
    endShape();
  }
}
