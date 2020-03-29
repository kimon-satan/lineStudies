//Morphing between two shapes

void setup()
{
  size(512,512);
}


void draw()
{
  
  float noiseInc = frameCount * 0.05;
  
  background(255);
  
  translate(width/2, height/2);
  
  beginShape();
  for(int i = 0; i < 100; i++)
  {
    float x = i * width/100 - width/2;
    
    float y = map(noise(i * 0.05 + noiseInc,i * 0.05 - noiseInc),0,1,-50,50);
    
    float x1 = map(sin(i * 7 * TWO_PI/100),-1,1,-100,100);
    float y1 = map(cos(i * 6 * TWO_PI/100),-1,1,-100,100);
    
    float p = map(sin(frameCount * 0.01),-1,1,0.25,0.75);
    
    float px = lerp(x,x1,p);
    float py = lerp(y,y1,p);
    
    curveVertex(px,py);
  }
  endShape();
}
