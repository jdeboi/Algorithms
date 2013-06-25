
class Beer {
  
  int x, y, num;
  String name;
  float alcohol;
  String alcoholS;
  int calories;
  String type;
  PImage img;
  int imageW;
  color c;
  
  Beer(int xp, int yp, int nu, String na, String alc, String cal, String typ) {
    x = xp;
    y = yp;
    num = nu;
    name = na;
    alc = alc.substring(1);
    cal = cal.substring(1);
    typ = typ.substring(1);
    alcoholS = alc;
    alcohol = Float.parseFloat(alc);
    calories = Integer.parseInt(cal);
    type = typ;
    img = loadImage("/img/" + num + ".png");
    imageW = 35;
    c = #181183;
  }

  void displayHorizontal() {
    fill(0, 60, 255);
    strokeWeight(4);
    stroke(0, 60, 255);
    line(0, y, width * (alcohol/11.0), y);
    fill(0);
    text(name, 0, y);
    text(alcoholS, width * (alcohol/11.0), y);
    image(img, x + 10, y, 20, 40);
  }
  
  void displayVertical() {
    int h = int(img.height * (1.0 * imageW/img.width));
    int xp = x - imageW/2;
    int barH = 150;
    strokeWeight(30);
    fill(c);
    stroke(c);
    line(x, height - barH, x, height - height * (alcohol/8.5));
    image(img, xp, height - h, imageW, h);
    fill(0);
    textSize(18);
    displayText(barH);
  }
  
  void display(int xp, int yp) {
    x = xp;
    y = yp;
    displayVertical();
  } 
  
  void displayText(int barH) {
    pushMatrix();
    translate(x + 6, height - barH - 10);
    rotate(-PI/2);
    
    //textAlign(CENTER, BOTTOM);
    textSize(16);
    fill(255);
    text(name, 0, 0);
    float tw = textWidth(alcoholS);
    textSize(18);
    translate(height * (alcohol/8.5) - barH - tw - 5, 0);
    text(alcoholS, 0, 0);
    popMatrix();
  }
 
  void resetColor() {
   c = #181183;
  }
 
  void setColor(color col) {
    c = col;
  }
}
  
  
