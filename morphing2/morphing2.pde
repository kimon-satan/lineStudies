//Morphing between several shapes

int [][] ratios;
PVector [] points; 
float maxDist;

void setup()
{
  size(512,512);
  
  ratios = new int [][] {{2,3},{1,2},{1,1},{8,9}};
  points = new PVector []{
    new PVector(0,0), 
    new PVector(0,height), 
    new PVector(width,height), 
    new PVector(width,0)
  };
  
  maxDist = sqrt(pow(width,2) + pow(height,2));
  
  
}


void draw()
{
  
  float noiseInc = frameCount * 0.01;
  float [] distances = new float [4];
  
  PVector interPos = new PVector();
  interPos.x = noise(noiseInc) * width;
  interPos.y = noise(1000 + noiseInc) * height;
  
  for(int i = 0 ; i < 4; i++)
  {
    distances[i] = maxDist - dist(interPos.x, interPos.y, points[i].x, points[i].y);
    distances[i] = pow(distances[i],10);
  }
   
  normaliseSum(distances, 4);
 
  
  background(255);
  
  translate(width/2, height/2);
  
  beginShape();
  for(int i = 0; i < 103; i++)
  {
    //float x = i * width/100 - width/2;
    //float y = map(noise(i * 0.05 + noiseInc,i * 0.05 - noiseInc),0,1,-50,50);
    
    PVector total = new PVector(0,0);
    
    for(int j= 0; j < 4; j++)
    {
      PVector component = lissajous(ratios[j][0], ratios[j][1], i * TWO_PI/100, 100);
      component.mult(distances[j]);
      total.add(component);
    }
    
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
