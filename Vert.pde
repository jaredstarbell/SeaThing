class Vert {
  int gen;
  float x, y;
  float theta;
  float w;
  
  Vert parent, child;
  
  float warp;
  
  Vert(int _gen, float _x, float _y, float _theta, float _w) {
    gen = _gen;
    x = _x;
    y = _y;
    theta = _theta;
    w = _w;
    
    warp = random(1000);
    
    if (gen<maxGen) grow();      // continue to grow if not too long
  }
  
  void grow() {
    float d = 15;
    float dx = d*cos(theta+PI);
    float dy = d*sin(theta+PI);
    child = new Vert(gen+1,x+dx,y+dy,theta,w*.92);
    child.parent = this;    // assign reference to parent object
  }
  
  void update() {
    // move 
    float v = 1.0;
    float vx = v*cos(theta);
    float vy = v*sin(theta);
    x+=vx;
    y+=vy;
    
    if (parent!=null) {
      // follow the previous vert
      theta += (parent.theta-theta)*.081; 
    } else {
      // lead as the head
      theta+=.09*(noise(warp+cnt*.012)-.5);
    }
   
    // draw
    render();
    
    if (child!=null) child.update();  
  }
  
  void render() {
    // render as line with body and endpoints
    pushMatrix();
    translate(x,y);
    rotate(theta);
    stroke(255,96);
    strokeWeight(1.0);
    line(0,-w*20,0,w*20);
    
    float ow = w*.618;
    noStroke();
    fill(255,192);
    ellipse(0,0,w,w);            // body
    ellipse(0,-w*20,ow,ow);      // endpoint
    ellipse(0,w*20,ow,ow);       // endpoint
    popMatrix();

    // draw line to parent
    stroke(255,128);
    strokeWeight(map(gen,0,maxGen,10,1));
    if (parent!=null) line(x,y,parent.x,parent.y);
    
  }
  
}
  
