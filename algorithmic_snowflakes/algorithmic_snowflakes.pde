// maximum RGB value
final int MAXCOLOR = 255;
// degrees in a circle
final int CIRCLE = 360;
// how many branches do the snowflakes have?
final int NBRANCHES = 6;
// how big are the snowflakes, in pixels?
int SIZE = 100;
// how many levels of branches do our snowflakes have?
int DEPTH = 3;
// how thick do we draw the lines?
int THICKNESS = 12;
// these arrays hold the randomized parameters for the snowflakes
float[] fractions = new float[DEPTH];
int[] angles = new int[DEPTH];
// this variable tracks how many snowflakes we have saved in this session
int saves = 0;

void setup() {
  size(500,500);
  stroke(0,0,0);
  pushMatrix();
  strokeWeight(THICKNESS);
  fill(MAXCOLOR,MAXCOLOR,MAXCOLOR);
  snowflake();
}
//make a new snowflake with each mouse click, and save the old one
void mouseClicked() {
  if (mouseButton == LEFT) {
    save("snowflake" + saves + ".png");
    saves = saves + 1;
  }
  snowflake();
}
//this function creates a snowflake
void snowflake() {
  //set background color
  background(MAXCOLOR,MAXCOLOR,MAXCOLOR);
  //move the origin to the center of the canvas
  translate(500/2,500/2);
  //rotate the canvas so the zero-direction is up
  rotate(radians(-CIRCLE/4));
  //generate three random branch positions and three random angles
  for(int i = 0; i<DEPTH; i++) {  
    // branch off at halfway, plus or minus a quarter of the way
    fractions[i] = 0.5 + 0.25*(random(1) - random(1));
    // branch off at 60 degrees, plus or minus 40 degrees
    angles[i] = int(60 + random(40) - random(40));
  }
  //six times, create a branch and then rotate the canvas 60 degrees
  for(int i = 0; i<NBRANCHES; i++) {
      branch(SIZE,0);
      rotate(radians(CIRCLE/NBRANCHES));
  }
  //draw the eyelet at the top
  ellipse(0,0,0.25*SIZE,0.25*SIZE);
  ellipse(SIZE,0,0.25*SIZE,0.25*SIZE);
}
//this function creates one of the six branches
void branch(int size, int depth) {
  if(depth<DEPTH) {
    line(0,0,size,0);
    //each recursive branch calls "branch" four times until DEPTH is reached
    branch(int(fractions[depth]*size),depth+1);
    //the matrix stack is an important concept in Processing
    //pushMatrix is like bookmarking the canvas, and popMatrix rolls it back
    pushMatrix();
    translate(fractions[depth]*size,0);
    branch(int(fractions[depth]*size),depth+1);
    pushMatrix();
    rotate(radians(-angles[depth]));
    branch(int(fractions[depth]*size),depth+1);
    popMatrix();
    pushMatrix();
    rotate(radians(angles[depth]));
    branch(int(fractions[depth]*size),depth+1);
    popMatrix();
    popMatrix();
  }
}

void draw() {
}