class Lissajous
{
    int x_freq;
    int y_freq;
    int radius;
    
    Lissajous(int _x_freq, int _y_freq, int _radius)
    {
      x_freq = _x_freq;
      y_freq = _y_freq;
      radius = _radius;
    }
    
    PVector calcVertex(float theta)
    {
      PVector p = new PVector(0,0);
      p.x = map(sin(theta * x_freq),-1,1,-radius, radius);
      p.y = map(cos(theta * y_freq),-1,1,-radius, radius);
      return p;
    }
    
    
  
}
