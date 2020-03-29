class ArOnePole{
  
  float z;
  float a;
  float b;
  float sampleRate;
  
  ArOnePole()
  { 
    sampleRate = 30;
    setDecay(0.5);
    z = 0;
  }
  
  void trigger()
  {
     z = 1; 
  }
  
  
  void setDecay(float time)
  {
    b = exp(-1.0/(time * sampleRate));
    a = 1.0 - b;
  }
  
  float step()
  {
    z = 0 * a + z * b;
    return z;
  }
  
};


class OnePole{
  
  float z;
  float a;
  float b;
  float sampleRate;
  
  OnePole(float _sampleRate, float _freqCoeff)
  { 
    sampleRate = _sampleRate;
    setFc(_freqCoeff);
    z = 0;
  }
  
  void trigger()
  {
     z = 1; 
  }
  
  
  void setFc(float Fc)
  {
    b = exp(-1.0 * TWO_PI * Fc);
    a = 1.0 - b;
  }
  
  float step(float input)
  {
    z = input * a + z * b;
    return z;
  }
  
};


class ArLin{
  
  int count;
  int frames;
  float sampleRate;
  
  ArLin()
  { 
    sampleRate = 30;
    setDecay(1);

  }
  
  void trigger()
  {
     count = frames;
  }
  
  
  void setDecay(float time)
  {
    frames = floor(time * sampleRate);
    count = 0;
  }
  
  float step()
  {
    count--;
    count = max(count, 0);
    return map(count, 0, frames,0, 1);
  }
  
};


void  normaliseSum(float [] input,  int numElements){
  
  float total = 0;
  
  for(int  i = 0; i < numElements; i++)
  {
     total += input[i];
  }
  
  for(int  i = 0; i < numElements; i++)
  {
     input[i] /= total;
  }
  
  

}
