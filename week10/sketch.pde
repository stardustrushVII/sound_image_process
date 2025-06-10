ArrayList<Particle> particles;

void setup() {
  size(800, 800);             
  background(0);               
  particles = new ArrayList<Particle>(); 
}

void draw() {
  background(0, 20);           


  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i); 
    p.update();                    
    p.display();                   
    if (p.isDead()) {             
      particles.remove(i);       
    }
  }
}


void mousePressed() {
  for (int i = 0; i < 100; i++) {
    particles.add(new Particle(new PVector(mouseX, mouseY)));
  }
}


class Particle {
  PVector pos;      
  PVector vel;      
  PVector acc;      
  float lifespan;   


  Particle(PVector start) {
    pos = start.copy();                         
    float angle = random(TWO_PI);               
    float speed = random(1, 5);                 
    vel = new PVector(cos(angle), sin(angle)).mult(speed); 
    acc = new PVector(random(-0.01, 0.01), random(-0.01, 0.01)); 
    lifespan = 255;                              
  }

  void update() {
    vel.add(acc);     
    pos.add(vel);     
    lifespan -= 2;    
  }

  
  void display() {
    noStroke();
    fill(150, 0, 255, lifespan); 
    ellipse(pos.x, pos.y, 6, 6); 
  }


  boolean isDead() {
    return lifespan <= 0;
  }
}
