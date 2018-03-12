// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector position;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }
  
  int size() {
    return particles.size();
  }

  void addParticle() {
    float sideBool = random(0,1);
    
    if (sideBool < 0.25) {
      position = new PVector(random(0,width), 0);
    }
    else if (sideBool < 0.5) {
      position = new PVector(width, random(0,height));
    }
    else if (sideBool < 0.75) {
      position = new PVector(random(0,width), height);
    }
    else {
      position = new PVector(0, random(0, height));
    }
    
    particles.add(new Particle(position));
  }

  void run() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}