
final int RECT_HEIGHT = 16;
final int RECT_WIDTH = 80;
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


float toolDiameter;
float insideDiameterMinusHalfTool;
float pocketDiameter;
float residualDiamInsidePocket;
float percentToolDiameter;
boolean inch = true;
boolean rectOver = false;
boolean lastResidual = false;
 

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
  public boolean fInFocus;
  public String fieldValueTxt;
  public int xFieldTxt;
  public int yFieldTxt;
  
  
  TextField (int s_typeField, int xText, int yText, String s_txt, int s_recStartX, int s_recStartY,int s_recSizeX,int s_recSizeY,
  boolean s_mouseOverField, boolean s_fInFocus, String s_fieldValueTxt, int s_xFieldTxt, int s_yFieldTxt) {
    typeField = s_typeField;
    x = xText;
    y = yText;
    txt = s_txt;
    recStartX = s_recStartX;
    recStartY = s_recStartY;
    recSizeX = s_recSizeX;
    recSizeY = s_recSizeY;
    mouseOverField = s_mouseOverField;
    fInFocus = s_fInFocus;
    fieldValueTxt = s_fieldValueTxt; 
    xFieldTxt = s_xFieldTxt;
    yFieldTxt = s_yFieldTxt;
  }
}
  TextField c[] = {
    // Type, X, Y, Text, Xpos of Rec, YPos of rec, Rec Width, Rec Height, OverMouse, InFocus, Text Enter
    new TextField(0,20,20,"Tool Diameter:",     X_POS,10, RECT_WIDTH,RECT_HEIGHT, false, false, "18", X_POS+5, 23 ), 
    new TextField(0,20,40,"Pull Off Z:",        X_POS,30, RECT_WIDTH,RECT_HEIGHT, false, false, "5", X_POS+5, 43 ), 
    new TextField(0,20,60,"Diameter of Pocket:",X_POS,50, RECT_WIDTH,RECT_HEIGHT, false, false, "100", X_POS+5, 63 ), 
    new TextField(0,20,80,"Depth of Pocket",    X_POS,70, RECT_WIDTH,RECT_HEIGHT, false, false, "80", X_POS+5, 83 ), 
    new TextField(0,20,100,"Max Over Cut in %", X_POS,90, RECT_WIDTH,RECT_HEIGHT, false, false, "15", X_POS+5, 103 ), 
    new TextField(0,20,120,"Feed Rate",         X_POS,110,RECT_WIDTH,RECT_HEIGHT, false, false, "1000", X_POS+5, 123 ), 
    new TextField(1,210,218,"START:",             210,  218,60        ,25         , false, false, "START", 200    , 200 ), 
    
  };

  

 
void setup() {
  //println(c.length);
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
  switch (state) {
  case 0:
    fill(255); 
    stroke(255);
    for (int i=0 ; i<c.length;i++){
      if (c[i].mouseOverField) {
        fill(rectHighlight);
      } else {
        fill(rectColor);
      }
      rect(c[i].recStartX, c[i].recStartY, c[i].recSizeX, c[i].recSizeY);
      fill (255);
      if (c[i].fieldValueTxt != ""){
        text (c[i].fieldValueTxt, c[i].xFieldTxt, c[i].yFieldTxt);
      }
      text (c[i].txt, c[i].x, c[i].y);
    }
    for (int i=0 ; i<c.length;i++){
      if (c[i].typeField == 1) {
        if (c[i].mouseOverField) {
          // Analyse Data
        }
        if (c[i].fInFocus) {
          // Start GCode
          toolDiameter = Float.parseFloat(c[0].fieldValueTxt);
          percentToolDiameter = Float.parseFloat(c[4].fieldValueTxt);
          pocketDiameter = Float.parseFloat(c[2].fieldValueTxt);
          insideDiameterMinusHalfTool = pocketDiameter-(toolDiameter/2);
          //println("PocketDiameter:"+pocketDiameter);
          //println("Inside Diameter:"+insideDiameterMinusHalfTool);
            
          residualDiamInsidePocket = insideDiameterMinusHalfTool;
          println("F"+c[5].fieldValueTxt);
          println("G0 Z"+c[1].fieldValueTxt);
          println("G0 X0 Y"+String.valueOf(insideDiameterMinusHalfTool/2));
          println("G0 Z0");
          lastResidual = true;
          while (lastResidual){
            if (residualDiamInsidePocket > (0.90 * toolDiameter)) {
              lastResidual = true;
            }else {
              lastResidual = false;
            }
            if (residualDiamInsidePocket > 0){
              println("G1 X0 Y"+String.valueOf(residualDiamInsidePocket/2));
              println("G2 X0 Y-"+String.valueOf(residualDiamInsidePocket/2)+" I0 J-"+String.valueOf(residualDiamInsidePocket/2));
              println("G2 X0 Y"+String.valueOf(residualDiamInsidePocket/2)+" I0 J"+String.valueOf(residualDiamInsidePocket/2));
            }else {
              println("G1 X0 Y0");
            }
            
            residualDiamInsidePocket = residualDiamInsidePocket - (percentToolDiameter/100 * toolDiameter * 2);
            if (residualDiamInsidePocket < 0 )
              residualDiamInsidePocket = 0;
            // println("residualDiamInsidePocket:"+residualDiamInsidePocket);
            // println("Tool Diameter:"+toolDiameter);
          }
          
          //String.valueOf();
          c[i].fInFocus = false; // Stop Program
        }
      }
    }
    
    // Draw the Start Button
    //fill (rectColor);
    //rect(200, 200, 60, 25);
    //fill (255);
    //text ("START", 210,218);
    break;
 
  case 1:
    //fill(255, 2, 2); 
    text ("Thanks \n"+result,0,15); 
    break;
  
  
  //for ( int i=0 ; i< c.length ; i++){
 // }
 // stroke(255);
//      rect(c[i].recStartX, c[i].recStartY, c[i].recSizeX, c[i].recSizeY);
//  }
  
  //if (circleOver) {
  //  fill(circleHighlight);
  //} else {
  //  fill(circleColor);
  //}
  //stroke(0);
  //ellipse(circleX, circleY, circleSize, circleSize);
  }
}
 
void keyPressed() {
 
  if (key==ENTER||key==RETURN) {
 
    state++;
  } else   if (key==' ') {
    for (int i=0 ; i<c.length;i++){
      print("id: "+i);
      print(","+c[i].typeField);
      print(","+c[i].txt);
      print(","+c[i].mouseOverField);
      print(","+c[i].fInFocus);
      print(","+c[i].fieldValueTxt);
      println();
    }
      println ("Total ="+(Float.parseFloat(c[0].fieldValueTxt) + Float.parseFloat(c[1].fieldValueTxt)));


  }else
  for ( int i=0 ; i< c.length ; i++){
    if (c[i].fInFocus) {
      c[i].fieldValueTxt = c[i].fieldValueTxt + key;
    }
  }
  result = result + key;
}

void mousePressed() {
  for ( int i=0 ; i< c.length ; i++){
    if (c[i].mouseOverField) {
      c[i].fInFocus = true;
    }else 
      c[i].fInFocus = false;
  }
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