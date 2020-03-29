//Morphing between arbitrary lissajous and arbitrary noise lines

//


ArrayList<Lissajous> lissajous;
ArrayList<NoiseLine> noiseLines;

ArrayList<PVector> points; 

float maxDist;
int numVertexes;

void setup()
{
  size(512,512);
  noFill();
  stroke(0);
 
  
  maxDist = sqrt(pow(width,2) + pow(height,2));
  numVertexes = 100; 
  
  
  resetSpace();
  
}


void draw()
{
  background(255);
  translate(width/2, height/2);
  
  float noiseInc = frameCount * 0.01;
  float [] distances = new float [points.size()];

  
  for(int i = 0 ; i < points.size(); i++)
  {
    
    PVector p = points.get(i);
    //ellipse(p.x, p.y,5,5);
    distances[i] = maxDist - dist(mouseX - width/2, mouseY - height/2, p.x, p.y);
    distances[i] = pow(distances[i],13);
  }
   
  normaliseSum(distances, points.size());
 

  
  beginShape();
  for(int i = 0; i < numVertexes; i++)
  {
    
    PVector total = new PVector(0,0);
    
    for(int j= 0; j < lissajous.size(); j++)
    {
      PVector component = lissajous.get(j).calcVertex((float)i * TWO_PI/(numVertexes - 3));
      component.mult(distances[j]);
      total.add(component);
    }
    
    
    for(int j= 0; j < noiseLines.size(); j++)
    {
      PVector component = noiseLines.get(j).calcVertex((float)i/numVertexes, frameCount);
      component.mult(distances[lissajous.size() + j]);
      total.add(component);
    }
    
    curveVertex(total.x,total.y);
  }
  endShape();
}

void resetSpace()
{
   lissajous = new ArrayList<Lissajous>();
  noiseLines = new ArrayList<NoiseLine>();
  points = new ArrayList<PVector>();
  
  for(int i = 0; i < 50; i++)
  {
    Lissajous l = new Lissajous(
      floor(random(2,18)),
      floor(random(3,20)),
      floor(random(100,200))
      );
      
    lissajous.add(l);
  }
  
  for(int i = 0; i < 10; i++)
  {
    NoiseLine n = new NoiseLine(
      random(0,PI), 
      floor(random(100,400)), 
      random(0.5,2.0), 
      random(50,100)
    );
    
    noiseLines.add(n);
  }
  
  
  for(int i = 0; i < lissajous.size() + noiseLines.size(); i ++)
  {
    points.add(new PVector(random(-width/2, width/2), random(-height/2, height/2))); 
  }
}

void keyPressed()
{
  resetSpace();
}
