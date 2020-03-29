class NoiseLine
{
  
  float theta; 
  int mag;
  
  PVector sampleVector;  
  PVector sampleCenter; 
  PVector sampleOffset; 
  PVector sampleInc; //move the noise by this vector
  
  float noiseAmp;
  
  NoiseLine(float _theta, int _mag)
  {
    theta = _theta;
    mag = _mag;
    
    sampleCenter = new PVector(random(0,99999), random(0,99999)); //start in a random position
    sampleVector = new PVector(10,0);
    sampleOffset = PVector.div(sampleVector, -2); // to draw the sample from the center
    sampleInc = new PVector(0.01,0);
    noiseAmp = 50;
   
  }
  
  void update()
  {
     sampleCenter.add(sampleInc);
  }
  
  PVector calcVertex(float progress)
  {
    
    //just the line
    
    PVector p = new PVector(
      sin(theta) * progress * mag,
      cos(theta) * progress * mag
    );
  
    PVector offset = new PVector(
      -sin(theta) * mag/2,
      -cos(theta) * mag/2
    );
  
    p.add(offset);
    
    //adding the noise
    
    PVector normal = new PVector(cos(theta),-sin(theta));
    
    PVector np  = PVector.mult(sampleVector, progress);
    np.add(sampleOffset); //set from the center
    
     float noiseVal = noise(
      sampleCenter.x + np.x, 
      sampleCenter.y + np.y
    );
    
    float mul = map(noiseVal,0.0,1.0,-noiseAmp, noiseAmp);
    
    normal.normalize();
    normal.mult(mul);
    p.add(normal);
  
    return p;
  }
  
  void setSampleTheta(float theta)
  {
    float mag = sampleVector.mag();
    sampleVector.x = sin(theta);
    sampleVector.y = cos(theta);
    setSampleMagnitude(mag);
  }
  
  void setSampleMagnitude(float mag)
  {
    //println(mag);
    if(mag > 0)
    {
     sampleVector.setMag(mag);
     sampleOffset = PVector.div(sampleVector, -2); // to draw the sample from the center
    }
  }
  
  void setSampleIncTheta(float theta)
  {
    //println(theta);
    float mag = sampleInc.mag();
    sampleInc.x = sin(theta);
    sampleInc.y = cos(theta);
    sampleInc.setMag(mag);
  }
  
  void setSampleIncMagnitude(float mag)
  {
    if(mag > 0)
    {
      sampleInc.setMag(mag);
    }
  }
  

  
}
