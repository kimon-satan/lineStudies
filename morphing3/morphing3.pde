//Morphing between lissajous and noise

int [][] ratios;
float [] gradients; 
PVector [] points; 
float maxDist;
int numPoints;

void setup()
{
  size(512,512);
  
  //lissajous
  ratios = new int [][] {{2,3},{1,2},{1,1},{8,9}};
  
  //noiselines
  gradients = new float [] {0,1,-1};
  
  points = new PVector [5];
  
  for(int i = 0; i < 5; i ++)
  {
    points[i] = new PVector(
    width/2 + sin((float)i * TWO_PI/5.0) * width/3,
    height/2 + cos((float)i * TWO_PI/5.0) * height/3
    ); 
  }
  

  
  maxDist = sqrt(pow(width,2) + pow(height,2));
  numPoints = 100; 
  
}


void draw()
{
  background(255);
  
  float noiseInc = frameCount * 0.01;
  float [] distances = new float [5];
  
  PVector interPos = new PVector();
  interPos.x = noise(noiseInc) * width;
  interPos.y = noise(1000 + noiseInc) * height;
  
  for(int i = 0 ; i < 5; i++)
  {
    ellipse(points[i].x, points[i].y,5,5);
    distances[i] = maxDist - dist(mouseX, mouseY, points[i].x, points[i].y);
    distances[i] = pow(distances[i],10);
  }
   
  normaliseSum(distances, 5);
 
  

  
  translate(width/2, height/2);
  
  beginShape();
  for(int i = 0; i < numPoints; i++)
  {
 
    
    PVector total = new PVector(0,0);
    
    for(int j= 0; j < 4; j++)
    {
      PVector component = lissajous(ratios[j][0], ratios[j][1], i * TWO_PI/numPoints, 100);
      component.mult(distances[j]);
      total.add(component);
    }
    
    PVector component = noiseLine(PI/2, (float)i/numPoints, (float)frameCount * 0.01 , 2,512, 100.0);
    component.mult(distances[4]);
    total.add(component);
    
    curveVertex(total.x,total.y);


  }
  endShape();
}

PVector lissajous(int r1, int r2, float theta, int radius)
{
    PVector p = new PVector(0,0);
    p.x = map(sin(theta * r1),-1,1,-radius, radius);
    p.y = map(cos(theta * r2),-1,1,-radius, radius);
    return p;
}

PVector noiseLine(float theta, float progress, float noiseInput, float noiseStep, int mag, float amp)
{

  PVector p = new PVector(
    sin(theta) * progress * mag,
    cos(theta) * progress * mag
  );
  
  PVector offset = new PVector(
    -sin(theta) * mag/2,
    -cos(theta) * mag/2
  );
  
  p.add(offset);
  
  PVector n = new PVector(cos(theta),-sin(theta));
  float noiseVal = noise(progress * noiseStep + noiseInput, progress * noiseStep - noiseInput);
  float mul = map(noiseVal,0.0,1.0,-amp, amp);
  n.normalize();
  n.mult(mul);
  p.add(n);

  return p;
}
