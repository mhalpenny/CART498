// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float hue;
  
  PVector center = new PVector(width/2, height/2);
  float magnitude = 20;

  Particle(PVector l) {
    acceleration = ((center.sub(l)).normalize()).div(20);
    velocity = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    position = l.copy();
    hue = random(20) + 160;
    lifespan = 255.0;
  }

  void run() {
    float min=1000;
    int index=0;
    for (int i = 0; i < body.size(); i++) {
      float dist = dist(position.x, position.y, body.get(i).x, body.get(i).y);
      if (dist < min) {
        min = dist;
        index = i;
      }
    }
    if(body.size() > 0) update(body.get(index).x, body.get(index).y);
    else update();
    display();
  }

  // Method to update position
  void update(float x, float y) {
    center = new PVector(x,y);  // pull towards mouse posiiton
    float distance = dist(center.x,center.y,position.x,position.y);  // find the distance between the particles position and the destination
    if (distance > 3) acceleration = (((center.sub(position)).mult(magnitude)).div(distance * distance));  // pull the particle harder the closer it is to the destination, but cap the acceleration at a certain proximity
    velocity.add(acceleration);
    velocity.mult(0.9);  // trim the velocity so that particles get "trapped" by the center pull
    position.add(velocity);
    lifespan -= 0.5;
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.mult(0.9);  // trim the velocity so that particles get "trapped" by the center pull
    position.add(velocity);
    lifespan -= 0.5;
  }

  // Method to display
  void display() {
    hue += 0.5;
    if (hue > 360) hue = 0;
    fill(hue, 100, 100);  // (hue, saturation, brightnesss)
    ellipse(position.x, position.y, 3, 3);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}