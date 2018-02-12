import java.util.ArrayDeque;
 
ArrayDeque<mouseParameters> mouseStack = new ArrayDeque();
 
 
//INSTRUCTIONS: for proper function of this code, calls to functions  
//  pushMatrix(), popMatrix(), translate(), scale(), rotate() must be replaced by calls to functions  
//  pushMatrixMouse(), popMatrixMouse(), translateMouse(), scaleMouse(), rotateMouse() respectively 
//  To implement, simply replace mouseX and mouseY with mouse_X() and mouse_Y()
Shape test1, test2, test3, test4;
 
void setup() {
  size(700, 700);
  textAlign(CENTER);
  mouseStack.addLast(new mouseParameters());
 
  test1 = new Shape("test1", 200, 200, 100, 100);
  test2 = new Shape("test2", 350, 150, 80, 80);
  test3 = new Shape("test3", 0, 0, 50, 50);
  test4 = new Shape("test4", 100, 50, 30, 30);
}
 
void draw() {
  background(255);
 
  pushMatrixMouse();
  translateMouse(150, 150);
  test2.display();
 
  scaleMouse(1.5);
  test1.display();
 
  scaleMouse(1/1.5);
  rotateMouse(PI/4);
  test3.name="test3";
  test3.display();
 
  rotateMouse(-PI/4);
  translateMouse(-150, -150);
  test4.display();
 
  popMatrixMouse();
 
  pushMatrixMouse();
  translateMouse(250, 250);
  rotateMouse(PI/4);
  test3.name="t3_TR";
  test3.display();
  popMatrixMouse();
 
 
  pushMatrixMouse();
  rotateMouse(PI/4);
  translateMouse(250, 250);
  test3.name="t3_RT";
  test3.display();
  popMatrixMouse();
 
  //always at the end of draw()
  resetMouse();
}
 
 
 
//=======================================
class Shape {
  int x, y, sizeX, sizeY;
  String name;
 
  Shape(String  nn, int x, int y, int sizeX, int sizeY) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    name=nn;
  }
 
  void display() {
    if (mouse_X() > x && mouse_X() < x+sizeX && mouse_Y() > y && mouse_Y() < y+sizeY) {
      fill(255);
    } else {
      fill(0);
    }
    stroke(255, 0, 0);
    rectMode(CORNER);
    rect(x, y, sizeX, sizeY);
    fill(155);
    text(name, x+sizeX/2, y+sizeY/2);
    fill(155);
    //text(name, mouseX, mouseY);
    fill(0, 0, 255);
    //text(name, mouse_X(), mouse_Y());
  }
}
 
 
//=======================================
class mouseParameters {
  final float initialOffsetX, initialOffsetY, initialScaleX, initialScaleY;
  final double initialRotate;
  float totalOffsetX, totalOffsetY, totalScaleX, totalScaleY;
  double totalRotate;
 
  mouseParameters(float initialOffsetX, float initialOffsetY, double initialRotate, float initialScaleX, float initialScaleY) {
    this.initialOffsetX = initialOffsetX;
    this.initialOffsetY = initialOffsetY;
    this.initialRotate = initialRotate;
    this.initialScaleX = initialScaleX;
    this.initialScaleY = initialScaleY;
    reset();
  }
 
  mouseParameters() {
    initialOffsetX = 0;
    initialOffsetY = 0;
    initialRotate = 0;
    initialScaleX = 1;
    initialScaleY = 1;
  }
 
  void reset() {
    totalOffsetX = initialOffsetX;
    totalOffsetY = initialOffsetY;
    totalRotate = initialRotate;
    totalScaleX = initialScaleX;
    totalScaleY = initialScaleY;
  }
}
 
 
void pushMatrixMouse() {
  pushMatrix();
  mouseStack.addLast(new mouseParameters(mouseStack.getLast().totalOffsetX, mouseStack.getLast().totalOffsetY, mouseStack.getLast().totalRotate, mouseStack.getLast().totalScaleX, mouseStack.getLast().totalScaleY));
}
 
void popMatrixMouse() {
  popMatrix();
  mouseStack.removeLast();
}
 
void translateMouse(float offsetX, float offsetY) {
  translate(offsetX, offsetY);
  mouseStack.getLast().totalOffsetX += cos((float)mouseStack.getLast().totalRotate)*(mouseStack.getLast().totalScaleX)*offsetX - sin((float)mouseStack.getLast().totalRotate)*(mouseStack.getLast().totalScaleY)*offsetY;
  mouseStack.getLast().totalOffsetY += cos((float)mouseStack.getLast().totalRotate)*(mouseStack.getLast().totalScaleX)*offsetY + sin((float)mouseStack.getLast().totalRotate)*(mouseStack.getLast().totalScaleY)*offsetX;
}
 
void scaleMouse(float scale) {
  scale(scale);
  mouseStack.getLast().totalScaleX *= scale;
  mouseStack.getLast().totalScaleY *= scale;
}
 
void scaleMouse(float scaleX, float scaleY) {
  scale(scaleX, scaleY);
  mouseStack.getLast().totalScaleX *= scaleX;
  mouseStack.getLast().totalScaleY *= scaleY;
}
 
void rotateMouse(double rad) {
  rotate((float)rad);
  mouseStack.getLast().totalRotate += rad;
}
 
void resetMouse() {
  mouseStack.getLast().reset();
}
 
int mouse_X() {
  return int(cos((float)mouseStack.getLast().totalRotate)*(1/mouseStack.getLast().totalScaleX)*(mouseX - int(mouseStack.getLast().totalOffsetX))) + int(sin((float)mouseStack.getLast().totalRotate)*(1/mouseStack.getLast().totalScaleY)*(mouseY - int(mouseStack.getLast().totalOffsetY)));
}
 
int mouse_Y() {
  return int(cos((float)mouseStack.getLast().totalRotate)*(1/mouseStack.getLast().totalScaleY)*(mouseY - int(mouseStack.getLast().totalOffsetY))) - int(sin((float)mouseStack.getLast().totalRotate)*(1/mouseStack.getLast().totalScaleX)*(mouseX - int(mouseStack.getLast().totalOffsetX)));
}