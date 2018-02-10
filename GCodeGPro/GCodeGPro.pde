
final int RECT_HEIGHT = 15;
final int X_POS = 160;
int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean circleOver = false;
int state = 0; 
String result=""; 


float toolDiameter = 0.125;
float insidePocket = 1;
boolean inch = true;
boolean rectOver = false;

 

public class TextField {
  int typeField;
  public int x;
  public int y;
  public String txt;
  public int recStartX;
  public int recStartY;
  public int recSizeX;
  public int recSizeY;
  public boolean mouseOverField;
  public String fieldValueTxt;
  
  
  TextField (int s_typeField, int xText, int yText, String s_txt, int s_recStartX, int s_recStartY,int s_recSizeX,int s_recSizeY,
  boolean s_mouseOverField, String s_fieldValueTxt) {
    typeField = s_typeField;
    x = xText;
    y = yText;
    txt = s_txt;
    recStartX = s_recStartX;
    recStartY = s_recStartY;
    recSizeX = s_recSizeX;
    recSizeY = s_recSizeY;
    mouseOverField = s_mouseOverField;
    fieldValueTxt = fieldValueTxt; 
  }
}
  TextField c[] = {
    new TextField(0,20,20,"Tool Diameter:",     X_POS,10, 80,RECT_HEIGHT, false, ""), 
    new TextField(0,20,40,"Diameter of Pocket:",X_POS,30, 80,RECT_HEIGHT, false, ""), 
    new TextField(0,20,60,"Field3",             X_POS,50, 80,RECT_HEIGHT, false, ""), 
    new TextField(0,20,80,"Field4",             X_POS,70, 80,RECT_HEIGHT, false, ""), 
    new TextField(0,20,100,"Field5",            X_POS,90, 80,RECT_HEIGHT, false, ""), 
    new TextField(0,20,120,"Field6",            X_POS,110,80,RECT_HEIGHT, false, ""), 
  };

  

 
void setup() {
  //for (int i=0 ; i<c.length;i++){
    //text ("Tool Diameter :"+result, 15,15);
  //  println(c[i].txt);
  // }
  println(c.length);
  size(800, 800);
  rectColor = color(0);
  rectHighlight = color(51);
  circleColor = color(255);
  circleHighlight = color(204);
  baseColor = color(102);
  currentColor = baseColor;
  circleX = width/2+circleSize/2+10;
  circleY = height/2;
  rectX = width/2-rectSize-10;
  rectY = height/2-rectSize/2;
  ellipseMode(CENTER);
  

}
 
void draw() { 
 
  update(mouseX, mouseY);
  background(currentColor);
 
  //background(127); 
 
 
  switch (state) {
  case 0:
    fill(255); 
    for (int i=0 ; i<c.length;i++){
      if (boolean (c[i].fieldValueTxt))
        text (c[i].txt, c[i].x, c[i].y);
      stroke(255);
      rect(c[i].recStartX, c[i].recStartY, c[i].recSizeX, c[i].recSizeY);
      println(c[i].txt);
    }
    break;
 
  case 1:
    fill(255, 2, 2); 
    text ("Thanks \n"+result,0,15); 
    break;
  }
  
  for ( int i=0 ; i< c.length ; i++){
  if (c[i].mouseOverField) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
      rect(c[i].recStartX, c[i].recStartY, c[i].recSizeX, c[i].recSizeY);
  }
  
  //if (circleOver) {
  //  fill(circleHighlight);
  //} else {
  //  fill(circleColor);
  //}
  //stroke(0);
  //ellipse(circleX, circleY, circleSize, circleSize);  
}
 
void keyPressed() {
 
  if (key==ENTER||key==RETURN) {
 
    state++;
  } else   if (key==' ') {
  }else
  for ( int i=0 ; i< c.length ; i++){
    c[i].fieldValueTxt = c[i].fieldValueTxt + key;
  }
  result = result + key;
}

void update(int x, int y) {
  //if ( overCircle(circleX, circleY, circleSize) ) {
  //  circleOver = true;
  //  rectOver = false;
  //} else
  for (int i=0;i<c.length;i++){
    if ( overRect(c[i].recStartX, c[i].recStartY, c[i].recSizeX, c[i].recSizeY) ) {
      c[i].mouseOverField = true;
      //circleOver = false;
    } 
    else {
      c[i].mouseOverField = false;
    }
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
/*
boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
*/