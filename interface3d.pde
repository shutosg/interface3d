int render = 0;
float mouse_X = mouseX;
float radius = 100;
float alpha = 255;
float sw = 1;
float offset = 0;
void setup() {
  size(600, 600, P3D);
  PFont font = loadFont("SAOUI-Regular-100.vlw");
  textFont(font);
  textSize(50);
}

void draw() {
  background(55);
  renderObj();
  drawCircles();
  
  pushMatrix();
  pushStyle();
  stroke(200);
  fill(100, 100, 100, 100);
  rect(0, height - 200, width, 200);
  noStroke();
  fill(200);
  ellipse(0, height-200, 10, 10);
  ellipse(width, height-200, 10, 10);
  ellipse(0, height, 10, 10);
  ellipse(width, height, 10, 10);
  drawUi(25, height-175, "Render", true);
  drawUi(270, height-175, "BOX", true);
  drawUi(270, height-115, "SPHERE", false);
  drawUi(270, height-55, "OCTAHEDRON", false);
  popStyle();
  popMatrix();
  drawMater(offset);
  
  pushMatrix();
  pushStyle();
  textAlign(CENTER);
  fill(255);
  textSize(100);
  text("Interface 3D", width/2, 100);
  popStyle();
  popMatrix();
}

void mousePressed () {
  if (270 <= mouseX && mouseX <= 270+230 && height-175 <= mouseY && mouseY <= height-175+50) {
    render = 0;
  }
  else if (270 <= mouseX && mouseX <= 270+230 && height-115 <= mouseY && mouseY <= height-115+50) {
    render = 1;
  }
  else if (270 <= mouseX && mouseX <= 270+230 && height-55 <= mouseY && mouseY <= height-55+50) {
    render = 2;
  }
}

void renderObj() {
  perspective();
  pushMatrix();
  translate(width/2, height/2);
  float mouse_Y = mouseY;
  if (mouseY <= height - 200) mouse_X = mouseX;
  if (mouseY > height - 200) {
    mouse_Y = height - 200;
  }
  rotateX(radians(mouse_Y));
  rotateY(radians(mouse_X));
  fill(0, 222, 255, 100);
  stroke(200);
  if (render == 0) {
    box(200);
  }
  else if (render == 1) {
    sphere(150);
  }
  else if (render == 2) {
    drawOctahedron(200);
  }
  popMatrix();
  ortho();
  renderText();
}
void drawOctahedron (float _a) {
  float a = _a/2;
  
  beginShape();
  vertex(-a, 0, -a);
  vertex(a, 0, -a);
  vertex(0, -a*sqrt(2), 0);
  vertex(-a, 0, -a);
  endShape();
  
  vertex(-a, 0, -a);
  vertex(-a, 0, a);
  vertex(0, -a*sqrt(2), 0);
  vertex(-a, 0, -a);
  endShape();
  
  beginShape();
  vertex(-a, 0, a);
  vertex(a, 0, a);
  vertex(0, -a*sqrt(2), 0);
  vertex(-a, 0, a);
  endShape();
  
  
  beginShape();
  vertex(a, 0, a);
  vertex(a, 0, -a);
  vertex(0, -a*sqrt(2), 0);
  vertex(a, 0, a);
  endShape();
  
  beginShape();
  vertex(-a, 0, -a);
  vertex(a, 0, -a);
  vertex(0, a*sqrt(2), 0);
  vertex(-a, 0, -a);
  endShape();
  
  vertex(-a, 0, -a);
  vertex(-a, 0, a);
  vertex(0, a*sqrt(2), 0);
  vertex(-a, 0, -a);
  endShape();
  
  beginShape();
  vertex(-a, 0, a);
  vertex(a, 0, a);
  vertex(0, a*sqrt(2), 0);
  vertex(-a, 0, a);
  endShape();
  
  
  beginShape();
  vertex(a, 0, a);
  vertex(a, 0, -a);
  vertex(0, a*sqrt(2), 0);
  vertex(a, 0, a);
  endShape();
}
void drawUi (float _x, float _y, String _msg, boolean triangle) {
  float x = _x;
  float y = _y;
  String msg = _msg;
  
  pushMatrix();
  pushStyle();
  noStroke();
  if (x <= mouseX && mouseX <= x+230 && y <= mouseY && mouseY <= y+50) {
    fill(255, 175, 70, 150);
  }
  else {
    fill(220, 220, 255, 150);
  }
  rect(x, y, 230, 50);
  if (triangle) {
    beginShape();
    vertex(x - 10, y + 25);
    vertex(x, y + 25 + 7);
    vertex(x, y + 25 - 7);
    vertex(x - 10, y + 25);
    endShape();
  }
  fill(255);
  textSize(50);
  text(msg, x + 10, y + 45);
  popStyle();
  popMatrix();
}

void drawCircles() {
  pushMatrix();
  translate(width/2, height/2);
  pushStyle();
  noFill();
  stroke(255, 255, 255, alpha);
  strokeWeight((int)sw);
  ellipse(0, 0, radius*2, radius*2);
  alpha = map(radius, 100, width/2, 150, 0);
  sw = map(radius, 100, width/2, 10, 50);
  radius += 5;
  if (radius > width/2) radius = 100;
  strokeWeight(5);
  stroke(255, 255, 255, 100);
  arc(0, 0, 350, 350, -PI/2+offset+PI/4*sin(offset), 0+offset);
  strokeWeight(3);
  stroke(255, 255, 255, 100);
  ellipse(0, 0, 50+5*cos(offset*2), 50+5*cos(offset*2));
  offset += .1;
  noStroke();
  fill(255, 255, 255, 200);
  triangle(50+5*cos(offset*2), 0, 50+5*cos(offset*2) + 5*sqrt(2), 5, 50+5*cos(offset*2) + 5*sqrt(2), -5);
  triangle(-50-5*cos(offset*2), 0, -50-5*cos(offset*2) - 5*sqrt(2), 5, -50-5*cos(offset*2) - 5*sqrt(2), -5);
  popStyle();
  popMatrix();
}

void drawMater(float theta) {
  pushMatrix();
  pushStyle();
  translate(width/2, height/2);
  rotate(-offset/20);
  for (int i=0; i<360; i+=10) {
    noStroke();
    fill(200);
    rect(-2, 250+0*sin(theta*2), 4, 10);
    rotate(radians(10));
  }
  popStyle();
  popMatrix();
}

void renderText() {
  String msg = "";
  switch (render) {
    case 0:
      msg = "BOX";
    break;
    case 1:
      msg = "SPHERE";
    break;
    case 2:
      msg = "OCTAHEDRON";
    break;
  }
  pushMatrix();
  pushStyle();
  translate(width/2, height/2);
  fill(250);
  textSize(35);
  text(msg, 150, -100);
  stroke(250);
  line(150, -100, 125, -50);
  line(125, -50, 50, -50);
  popStyle();
  popMatrix();
}
