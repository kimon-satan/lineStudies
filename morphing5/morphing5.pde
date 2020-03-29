//Morphing between arbitrary lissajous and arbitrary noise lines

PVector control;


ArrayList<Lissajous> lissajous;

ArrayList<PVector> points; 

float maxDist;
int numVertexes;

void setup()
{
  size(512,512);
  noFill();
  stroke(0);
 
  
  maxDist = width/11; // this controls the amount of bleed between shapes
  numVertexes = 100; 
  
  control = new PVector(0,0);
  resetSpace();
  
}


void draw()
{
  background(255);
  translate(width/2, height/2);
  
  //control.x = sin(frameCount * 0.005 * 8) * width * 2/5; //lissajous movement
  //control.y = cos(frameCount * 0.005 * 9) * width * 2/5;
  
  control.x = mouseX - width/2;
  control.y = mouseY - height/2;
  
  fill(0);
  ellipse(control.x, control.y, 5, 5);
  
  noFill();
  
  float noiseInc = frameCount * 0.01;
  float [] distances = new float [points.size()];


  
  for(int i = 0 ; i < points.size(); i++)
  {
    
    PVector p = points.get(i);
    ellipse(p.x, p.y,5,5);
    distances[i] = maxDist - dist(control.x , control.y, p.x, p.y);
    distances[i] = max(distances[i], 0);
    distances[i] = pow(distances[i], 2); //controls the degree of snapping to whole ratios
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
    
    
    curveVertex(total.x,total.y);
  }
  endShape();
}

void resetSpace()
{
  lissajous = new ArrayList<Lissajous>();
  points = new ArrayList<PVector>();
  
  for(int i = 0; i < 10; i++)
  {
    for(int j = 0; j < 10; j++)
    {
      Lissajous l = new Lissajous(
        i + 1,
        j + 1,
        200
        );
        
      lissajous.add(l);
    }
  }
  
  
  for(int i = 0; i < lissajous.size(); i ++)
  {
    PVector p = new PVector();
    p.x =  (i%10 + 1)*width/11 - width/2; 
    p.y = (1+floor(i/10)) * height/11 - height/2;
    points.add(p); 
  }
}
