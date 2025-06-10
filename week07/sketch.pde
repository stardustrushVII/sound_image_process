import processing.sound.*;

SoundFile kick, snare, hihat, clap;

void setup() {
  size(600, 400);
  frameRate(60); 

  kick = new SoundFile(this, "kick.wav");
  snare = new SoundFile(this, "snare.wav");
  hihat = new SoundFile(this, "hihat.wav");
  clap = new SoundFile(this, "clap.wav");
}

void draw() {
  background(0);
  fill(255);
  textSize(16);
  text("Frame: " + frameCount, 20, 30);
  text("Kick every 30 frames, Snare every 60, Hi-hat every 15, Clap randomly", 20, 60);

  // kick / beat
  if (frameCount % 30 == 0) {
    kick.play();
  }

  // snare per 2nd beat
  if (frameCount % 60 == 0) {
    snare.play();
  }

  // Hi-hat per 8th frametim
  if (frameCount % 15 == 0) {
    hihat.play();
  }

  // clap randomly / bar
  if (frameCount % 60 == 0 && random(1) > 0.6) {
    clap.play();
  }
}
