class ControlPoint
{
   PVector pos;
   FloatList vals;
   float radius;
   
   ControlPoint(int x, int y)
   {
     pos = new PVector(x,y);
     vals = new FloatList();
     radius = 100;
   }
   
   void draw()
   {
     fill(0);
     noStroke();
     ellipse(pos.x,pos.y,5,5); 
   }
   
   float getVal(float x, float y)
   {
     float rs = pow(radius,2);
     float d = pow(x - pos.x,2) + pow(y - pos.y,2); 
     float v = max(0, rs - d) / rs;
     return v;
   }
}
