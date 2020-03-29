//Experiments with noisey lines

//Better parametrical control of noise

//TODO
// - Encapsulate control points functions into control surface class (perhaps for further development)
// - Try to make a linear sequence for noise line
// - Try additive synthesis

NoiseLine noiseLine;
ArrayList<ControlPoint> controlPoints;

int numVertexes;

void setup()
{
  size(512,512);
  noFill();
  stroke(0);
  frameRate(60);
  
  numVertexes  = 100;
  noiseLine  = new NoiseLine(PI/2,width);  
  controlPoints = new ArrayList<ControlPoint>();
  
  for(int i = 0; i < 5; i++)
  {
    for(int j = 0; j < 5; j++)
    {
     ControlPoint cp = new ControlPoint(
     (i+1) * width/6 - width/2,
     (j+1) * height/6 - height/2);
     
     cp.vals.append(random(PI/2,PI*3/2)); // incTheta
     cp.vals.append(random(0,0.1)); // incMagnitude
     cp.vals.append(random(1,10)); // sampleMagnitude
     cp.vals.append(random(width/2,width)); //Mag
     cp.vals.append(random(PI * 0.4,PI * 0.6)); //theta
     cp.vals.append(random(0,100)); //noiseAmp
     controlPoints.add(cp);
     
    }
  }

}


void draw()
{
  

  
  background(255);
  translate(width/2, height/2);
  
  float [] params = getWeightedParams();
  
  noiseLine.setSampleIncTheta(params[0]);
  noiseLine.setSampleIncMagnitude(params[1]);
  noiseLine.setSampleMagnitude(params[2]);
  noiseLine.mag = floor(params[3]);
  noiseLine.theta = params[4];
  noiseLine.noiseAmp = params[5];
  
  noiseLine.update();
  
  for(ControlPoint cp : controlPoints )
  {
     
    //cp.draw(); 
    
  }
  
  noFill();
  stroke(1);
  beginShape();
  for(int i = 0; i < numVertexes; i++)
  {
    
    PVector p = noiseLine.calcVertex((float)i/numVertexes);
    
    curveVertex(p.x,p.y);
  }
  endShape();
}

float [] getWeightedParams()
{
  FloatList weights = new FloatList();
  
  for(ControlPoint cp : controlPoints )
  {
    weights.append(cp.getVal(mouseX - width/2, mouseY - height/2));
  }
  
  normaliseSum(weights);

  int numParams = controlPoints.get(0).vals.size();
  float [] params = new float[numParams];
  for(int i = 0; i < numParams; i++)
  {
   params[i] = 0; 
  }
  
  for(int j = 0; j < controlPoints.size(); j++) //<>//
  {
    ControlPoint cp = controlPoints.get(j);
    for(int i = 0; i < cp.vals.size(); i++)
    {
      params[i] += (cp.vals.get(i) * weights.get(j));
    }
  }
  
  return params;
}
