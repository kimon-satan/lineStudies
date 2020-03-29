class NoiseLine
{
  
  float theta; 
  int mag; 
  float noiseStep; 
  float noiseAmp;
  float noiseInc;
  float counter;
  float directionalCounter;
  
  NoiseLine(float _theta, int _mag, float _noiseStep, float _noiseInc, float _noiseAmp)
  {
    theta = _theta;
    mag = _mag;
    noiseStep = _noiseStep;
    noiseInc = _noiseInc;
    noiseAmp = _noiseAmp;
    counter = 0;
    directionalCounter = 0;
  }
  
  void update()
  {
     counter += noiseInc;
     directionalCounter += 0.1;
  }
  
  PVector calcVertex(float progress)
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
    float noiseVal = noise(
    -noiseStep/2 + progress * noiseStep/2 + counter + directionalCounter, 
    -noiseStep/2 + progress * noiseStep/2 - counter
    );
    
    float mul = map(noiseVal,0.0,1.0,-noiseAmp, noiseAmp);
    
    n.normalize();
    n.mult(mul);
    p.add(n);
  
    return p;
  }
  
}
