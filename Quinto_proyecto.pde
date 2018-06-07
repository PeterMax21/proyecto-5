PVector[] direction;
int[][] indices;
ArrayList<Particle> particles;
int  steps=100;
float  points;
PImage img;
PFont texto;

void setup() 
{
    size(1200, 700);
    fill(#7E80F0);
    noStroke();
    background(#252525);
    img= loadImage("elektra.png");
    texto=loadFont("CenturyGothic-48.vlw");
    textFont(texto);
    textSize(15);
    text("Inspirada en la técnica de puntillismo del post-impresionismo.",750,50);
    text("Dar clic en el mouse para pintar y mantener presionado mientras recorre toda la pantalla.",750,80,400,400);
    indices = new int[width][height];
    for (int y = 0; y<height; y++)
    {
      for (int x = 0; x<width; x++)
      {
      indices[x][y] = int(noise(x*points, y*points)); 
      }
    }
    
    direction = new PVector[steps];
    for (int i = 0; i < steps; i++)
    {
    direction[i] = new PVector(cos(i*.5), sin(i*.5));
    }
    
    particles = new ArrayList<Particle>();
}

void draw() 
{
    if (mousePressed) particles.add(new Particle(mouseX, mouseY));       
    for(int i = 0; i < particles.size(); i++) 
    {
        Particle p = particles.get(i);
        if (p.isDead() == false) 
        {
            p.update();
            p.draw();
        }
        else particles.remove(i);
    }
} 

class Particle
{   
    PVector pos, vel;
    int x, y, s, age;
    
  Particle(int _x_, int _y_)
  {
    x = _x_;
    y = _y_;
    pos = new PVector(x, y);
    vel = new PVector();
    age = 100;
  }
   
  boolean isDead()
  {
  return age==0; 
  } 
    
void draw() 
{ 
  ellipse(pos.x,pos.y,s,s); 
}  
    
void update() 
{ 
    vel.add(direction[indices[(x+width)%width][(y+height)%height]]);
    pos.add(vel);
    x = int(pos.x);
    y = int(pos.y);
    s = brightness(img.get(x, y))>>6;
    age--;
}   
  int brightness(int c) 
  { 
    int r = c >> 16 & 0xFF, g = c >> 8 & 0xFF, b = c & 0xFF; 
    return c = (c = r > g ? r : g) < b ? b : c; 
  } 
}    