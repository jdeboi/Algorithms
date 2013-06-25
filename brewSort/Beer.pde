
class Beer {
  
  int x, y, num;
  String name;
  float alcohol;
  String alcoholS;
  int calories;
  String type;
  PImage img;
  int imageW;
  int imageH;
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
    imageH = height/2;
    c = colors[0];
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
    int barH = 0;
    strokeWeight(30);
    fill(c);
    stroke(c);
    if(mouseOver()) stroke(#929830);
    line(x, height - barH, x, height - height * (alcohol/10.0));
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
    /*
    float tw = textWidth(alcoholS);
    textSize(18);
    translate(height * (alcohol/10.0) - barH - tw - 5, 0);
    text(alcoholS, 0, 0);
    */
    popMatrix();
  }
  
  void backgroundImage() {
   if(mouseOver()) {
    //int h = int(img.height * (1.0 * imageW/img.width));
    int w = int(img.width * (1.0 * imageH/img.height));
    image(img, 0, 0, w, imageH);
    fill(0);
    textSize(120);
    text(alcoholS + " %", w + 20, 200);
   }
  } 
  
  void resetColor() {
   c = colors[0];
  }
 
  void setColor(color col) {
    c = col;
  }
  
  boolean mouseOver() {
    if(mouseX > x - 30/2 && mouseX < x + 30/2
        && mouseY > height - height * (alcohol/10.0)) {
         return true;
    }
    return false;
  } 
}
  
  
