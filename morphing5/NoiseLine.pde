class NoiseLine
{
  
  float theta; 
  int mag; 
  float noiseStep; 
  float noiseAmp;
  float noiseFreq;
  
  NoiseLine(float _theta, int _mag, float _noiseStep, float _noiseAmp)
  {
    theta = _theta;
    mag = _mag;
    noiseStep = _noiseStep;
    noiseAmp = _noiseAmp;
    noiseFreq = 0.05;
  }
  
  PVector calcVertex(float progress, float noiseInput)
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
    float noiseVal = noise(progress * noiseStep + noiseInput * noiseFreq, 
    progress * noiseStep - noiseInput * noiseFreq);
    float mul = map(noiseVal,0.0,1.0,-noiseAmp, noiseAmp);
    n.normalize();
    n.mult(mul);
    p.add(n);
  
    return p;
  }
  
}
