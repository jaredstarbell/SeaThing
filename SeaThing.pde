// Sea Thing
//   Jared S Tarbell
//   January 31, 2021
//   Levitated | Albuquerque, New Mexico, USA
// Based on old Levitated sketch from October 2003 'Sea Thing'
//   http://levitated.net/daily/levSeaThing.html

ArrayList<Vert> verts = new ArrayList<Vert>();
int maxGen = 55;   // maximum number of vert segments in each creature

int cnt = 0;       // time for noise

void setup() {
  fullScreen(FX2D);
  background(0);
 
  init();
}

void init() {
  // start with just one creature
  Vert neo = new Vert(0,width/2,height/2,random(TWO_PI),10.0);
  verts.add(neo);
  
}

void draw() {
  background(0);
  
  // qually distribute the creatures along horizontal axis
  int n=0;
  for (Vert v:verts) {
    // calculate space available and actual position
    float spc = width/verts.size();
    float px = spc/2 + n*spc;
    float py = height/2;
    // always place the head of the object in the center of display
    pushMatrix();
    translate(px-v.x,py-v.y);
    v.update();
    popMatrix();
    n++;
  }
  cnt++;
}

void keyPressed() {
  if (key==' ') init();
}
