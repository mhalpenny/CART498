import org.openkinect.processing.*;

Kinect2 kinect2;
ParticleSystem ps;

int skip = 20;

PImage img;
float threshholdMin = 550;
float threshholdMax = 1000;

ArrayList<PVector> body = new ArrayList<PVector>();

void setup() {
  noStroke();
  colorMode(HSB,360,100,100);
  size(512, 424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  ps = new ParticleSystem();
  
  delay(1000);

  background(0); 
}

void draw() {
  background(0); 
  body.clear();  // clear the arraylist of body points
  img.loadPixels();

  int[] depth = kinect2.getRawDepth();
  
  for (int x = 0; x < kinect2.depthWidth; x+=skip) {
    for (int y = 0; y < kinect2.depthHeight; y+=skip) {
      int index = x + y * kinect2.depthWidth;
      int dep = depth[index];
      
      if (dep > threshholdMin && dep < threshholdMax) {
        //img.pixels[index] = color(50, 255, 200);
        
        body.add(new PVector(x,y));  // add the pixel location to the arraylist of bodypoints
        
      } else {
        img.pixels[index] = color(0);
      }
    }
  }

  img.updatePixels();
  image(img, 0, 0);
  
  ps.addParticle();
  ps.run();
  
  text(threshholdMax, 10, height -20);
  text(threshholdMin, 10, height -10);
  text(frameRate, 7, 10);
  text(ps.size(), 10, 20);
}