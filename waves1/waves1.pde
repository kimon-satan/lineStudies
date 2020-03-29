//Experiments with noisey lines

// - noiseStep
// - noiseInc
// - noiseAmp

NoiseLine noiseLine;

int numVertexes;

void setup()
{
  size(512,512);
  noFill();
  stroke(0);
  frameRate(60);
  
  numVertexes  = 100;
  noiseLine  = new NoiseLine(PI/2,width,10,0.01,50);  

}


void draw()
{
  
  noiseLine.noiseStep = map(mouseX, 0, width, 1,20);
  noiseLine.noiseInc =  map (mouseY, 0, height, (float)1/50, 0);
  
  noiseLine.update();
  
  background(255);
  translate(width/2, height/2);
  
  beginShape();
  
  
  for(int i = 0; i < numVertexes; i++)
  {
    
    PVector p = noiseLine.calcVertex((float)i/numVertexes);
    
    curveVertex(p.x,p.y);
  }
  endShape();
}
