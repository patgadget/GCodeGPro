/**
 * Move Eye. 
 * by Simon Greenwold.
 * 
 * The camera lifts up (controlled by mouseY) while looking at the same point.
 */
float toolDiam = 10.0;
float pocketDiam = 30.0;
float pocketDepth = 20.0;
int angMach =0;
void setup() {
  size(640, 360, P3D);
  frameRate(20);
  fill(204);
}

void draw() {
  lights();
  background(0);
  
  // Change height of the camera with mouseY
  camera(mouseX, mouseY, 100.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 0.0, 1.0); // upX, upY, upZ
       
  
  stroke(255,0,0);
  noStroke();
  //box(90);
  //top, bottom, height, side
  cylinder(pocketDiam,pocketDiam,pocketDepth,100);
  if (angMach<360){
    pushMatrix();
    translate((pocketDiam-toolDiam)*sin(radians(angMach)),(pocketDiam-toolDiam)*cos(radians(angMach)),0);
    //println((pocketDiam-toolDiam)*sin(radians(angMach)),(pocketDiam-toolDiam)*cos(radians(angMach)));
    stroke(255,0,0);
    cylinder(toolDiam,toolDiam,100,100);
    popMatrix();
    angMach++;
  }  
  stroke(255);
  line(-100, 0, 0, 100, 0, 0); //  X Axes
  line(0, -100, 0, 0, 100, 0); // Y Axe
  line(0, 0, -100, 0, 0, 100); // Z Axe
}




void cylinder(float bottom, float top, float h, int sides)
{
  pushMatrix();
  translate(0,0,h/2);
  float angle;
  float[] x = new float[sides+1];
  float[] y = new float[sides+1];
  float[] x2 = new float[sides+1];
  float[] y2 = new float[sides+1];
  //get the x and y position on a circle for all the sides
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x[i] = sin(angle) * bottom;
    y[i] = cos(angle) * bottom;
  }
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x2[i] = sin(angle) * top;
    y2[i] = cos(angle) * top;
  }

  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN);
  vertex(0,  0 ,  -h/2);
  for(int i=0; i < x.length; i++){
    vertex(x[i], y[i], -h/2 );
  }
  endShape();
 
  //draw the center of the cylinder
  beginShape(QUAD_STRIP); 
  for(int i=0; i < x.length; i++){
    vertex(x[i], y[i], -h/2 );
    vertex(x2[i], y2[i], h/2 );
  }
  endShape();
 
  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN); 
  vertex(0,0,h/2);
  for(int i=0; i < x.length; i++){
    vertex(x2[i], y2[i],h/2 );
  }
  endShape();
  
  popMatrix();
}