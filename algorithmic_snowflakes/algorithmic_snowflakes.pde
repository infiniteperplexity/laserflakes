int SIZE = 100;
int DEPTH = 3;
int THICKNESS = 12;
float[] fractions = new float[DEPTH];
int[] angles = new int[DEPTH];
int saves = 0;

void setup() {
  size(500,500);
  stroke(0,0,0);
  pushMatrix();
  strokeWeight(THICKNESS);
  fill(255,255,255);
  snowflake();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    save("snowflake" + saves + ".png");
    saves = saves + 1;
  }
  snowflake();
}

void snowflake() {
  background(255,255,255);
  translate(250,250);
  rotate(radians(-90));
  for(int i = 0; i<DEPTH; i++) {
    fractions[i] = 0.5 + 0.25*(random(1) - random(1));
    angles[i] = int(60 + random(40) - random(40));
  }
  for(int i = 0; i<6; i++) {
      branch(SIZE,0);
      rotate(radians(60));
  }
  ellipse(0,0,0.25*SIZE,0.25*SIZE);
  ellipse(SIZE,0,0.25*SIZE,0.25*SIZE);
}

void branch(int size, int depth) {
  if(depth<DEPTH) {
    line(0,0,size,0);
    branch(int(fractions[depth]*size),depth+1);
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