/* 
  Joy Bates
  Project 1
  Peacock
*/

float rotation = -1*QUARTER_PI;
int left_EllipseWidth = 40;
int left_EllipseHeight = 55;

// coordinates for the original/rightmost feather of facingLeft
int x1Feather = 307;
int y1Feather = 360;
int x2Feather = 350;
int y2Feather = 350;
int x3Feather = 280;
int y3Feather = 280;
int x4Feather = 350;
int y4Feather = 290;

PImage featherEye;

int[] xPeacockCoordsLeft = new int[6];
int[] yPeacockCoordsLeft = new int[6];
int[] xPeacockCoordsRight = new int[6];
int[] yPeacockCoordsRight = new int[6];

void setup() {
  size (600,600);
  featherEye = loadImage("teardropShape.png");
  
  // initializes variables for arrays
  for (int i = 0; i < 6; i ++) {
    xPeacockCoordsLeft[i] = int(random(-200,200));
    yPeacockCoordsLeft[i] = int(random(-240,185));
    
    xPeacockCoordsRight[i] = int(random(-200,200));
    yPeacockCoordsRight[i] = int(random(-240,185));
  }
}

void draw() {
  background(#C9FFFC); // pastel blue "border"
  fill(#FCE5FF); // light pink
  rect(25,25, 550,550);
  
  // generates 12 peacock at random locations
  for (int i = 0; i < 6; i ++) {
    pushMatrix();
      translate(xPeacockCoordsLeft[i],yPeacockCoordsLeft[i]);
        headAndNeck();
        bodyOfPeacock(); // facing left, and used for facing right
        legsOfPeacock();
        
        eyesOfFeathers(345, 298); // bottom most/ rightmost eye
        eyesOfFeathers(342, 285); // 2nd from bottom/ 2nd from right eye
        eyesOfFeathers(338, 279); // 3rd from bottom/ 3rd from right eye
        eyesOfFeathers(333, 274); // top/ leftmost eye
        
        facingLeft(5,13, 11,19, 15,24); // values are the shifts from original/rightmost feather
    popMatrix();
    pushMatrix();
      translate(xPeacockCoordsRight[i],yPeacockCoordsRight[i]);
        facingRight();
    popMatrix();
  }
}

// ------------------------------------------------------
void headAndNeck() {
  pushMatrix();
    fill(2, 175, 32); // same darker green color as body
    noStroke();
    rotate(rotation*.6);
      // neck
      rect((width/2) - 220,(height/2) + 80, 10,60);
     
     // head
     fill(61, 216, 122); // same lighter green color as body
     ellipse((width/2) - 220,(height/2) + 73, 25,25);
     
     // eye
     fill(0,0,0);
     ellipse((width/2) - 220,(height/2) + 70, 5,5);
  popMatrix();
}

void bodyOfPeacock() {
  pushMatrix();
    noStroke();
    rotate(rotation);
    // creates 4 ellipses of decrementing sizes and alternating colors
     int increment = 1;
     for (int i = 0; i <= 40; i += 10) {
       if (i % 20 == 0) {
        fill(2, 175, 32); // darker green
       }
       else {
        fill(61, 216, 122); // lighter green
       }
       ellipse((width/2) - 350, (height/2) + 150, left_EllipseWidth - (increment*i), left_EllipseHeight - (increment*i));
     }  
   popMatrix();
}

void legsOfPeacock() {
   pushMatrix();
     stroke(0,156,232); // same color as feather strokes
     noFill();
     translate(288, 377); // to bottom of ellipse of body
       line(0,0, -10,16); // left leg
       line(0,0, 10,16); // right leg       
   popMatrix();
}

void eyesOfFeathers(int xTranslate, int yTranslate) {
  pushMatrix();
    translate(xTranslate, yTranslate); // to the end of the feather stroke
    rotate(-1.5);
        image(featherEye, 0,0, 15,15);
  popMatrix();
}

// ------------------------------------------------------
// feather strokes
void facingLeft(int xchange1,int ychange1, int xchange2,int ychange2, int xchange3,int ychange3) {
  pushMatrix();
      stroke(0,156,232); // bright blue color
      noFill();
        // rightmost feather
        bezier(x1Feather,y1Feather, x2Feather,y2Feather, x3Feather,y3Feather, x4Feather,y4Feather);
        // 2nd from right feather
        bezier(x1Feather-xchange1,y1Feather-ychange1, x2Feather-xchange1,y2Feather-ychange1, x3Feather-xchange1,y3Feather-ychange1, x4Feather-xchange1,y4Feather-ychange1);
        // 3rd from right feather
        bezier(x1Feather-xchange2,y1Feather-ychange2, x2Feather-xchange2,y2Feather-ychange2, x3Feather-xchange2,y3Feather-ychange2, x4Feather-xchange2,y4Feather-ychange2);
        // leftmost feather
        bezier(x1Feather-xchange3,y1Feather-ychange3, x2Feather-xchange3,y2Feather-ychange3, x3Feather-xchange3,y3Feather-ychange3, x4Feather-xchange3,y4Feather-ychange3);
  popMatrix();
}

// ------------------------------------------------------
// mirror image of facingLeft
void facingRight() {
  pushMatrix();
     scale(-1.0,1.0);
     translate(-600,0);
       headAndNeck();
       bodyOfPeacock(); 
       legsOfPeacock();
       facingLeft(5,13, 11,19, 15,24);
       eyesOfFeathers(345, 298); 
       eyesOfFeathers(342, 285); 
       eyesOfFeathers(338, 279); 
       eyesOfFeathers(333, 274); 
  popMatrix();
}
