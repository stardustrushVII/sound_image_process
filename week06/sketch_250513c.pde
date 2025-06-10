import processing.sound.*;

SinOsc bassOsc, midOsc, highOsc;

void setup() {
  size(600, 400);
  
  // Create oscillator objects
  bassOsc = new SinOsc(this);
  midOsc = new SinOsc(this);
  highOsc = new SinOsc(this);
  
  // Set initial frequencies
  bassOsc.freq(110);    // Deep rumble
  midOsc.freq(440);     // Mid-tone
  highOsc.freq(880);    // High-pitched
  
  // Set volumes
  bassOsc.amp(0.3);
  midOsc.amp(0.2);
  highOsc.amp(0.1);
  
  // Play them
  bassOsc.play();
  midOsc.play();
  highOsc.play();
}

void draw() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  
  // Modulate the mid oscillator over time
  float modFreq = map(sin(frameCount * 0.02), -1, 1, 300, 600);
  midOsc.freq(modFreq);
  
  // Visual: pulsing ellipse based on modulation
  float size = map(sin(frameCount * 0.02), -1, 1, 100, 200);
  ellipse(width/2, height/2, size, size);
  
  text("Mid Oscillator Frequency: " + nf(modFreq, 0, 2) + " Hz", width/2, height - 30);
}
