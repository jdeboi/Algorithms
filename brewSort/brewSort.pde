import java.io.*;
import java.util.*;

String[] lines; 
String[] swaps;
String[] data;
String[] code;
int[] codeBlocks = {
  1, 1,
  10, 10,
  11, 11,
  11, 11,
  12, 12, 
  11, 11, 
  14, 14, 
  15, 15, 
  16, 19, 
  20, 23, 
  25, 25, 
  28, 28, 
  29, 29,
  31, 31,
  32, 32
};
  
int swapIndex;
int swapNum;

boolean showArrow;
int startArrow;
int endArrow;
int arrowIndex;

Beer[] beers;
Quicksort qs;

int id = -1;
int iQS;
int jQS;
int kQS;
int pQS;
int qQS;
int lQS;
int rQS;
String message = "";

int stepIndex = 0;
color [] colors = {0, #001BFC, #00FC4D, 140, 150, #EBFC00, #FC7A00, #FC0000};

void setup() {
  size(1200, 700);
  loadBeer();
  loadCode();
  qs = new Quicksort();
  swaps = loadStrings("sorted.txt");
  data = loadStrings("quicksortGuide.txt");
  
  swapIndex = 0;
  swapNum = qs.swapNum;
  resetBeerPositions();
}

void draw() {
  background(255);
  frameRate(10);
  
  displayBeer();
  displayText(500, 50);
  displayCode(670, 40);
  displayArrow();
}

void displayBeer() {
  for (int i = 0; i < beers.length; i++) {
    beers[i].displayVertical();
  }
  delay(1000);
}

void displayText(int x, int y) {
  fill(colors[1]);
  text("i = " + iQS, x, y);
  fill(colors[2]);
  y += 15;
  text("j = " + jQS, x, y);
  fill(colors[7]);
  y += 15;
  text("pivot = beers[" + rQS + "]", x, y); 
  fill(colors[4]);
  y += 15;
  text("p = " + pQS, x, y);
  y += 15;
  text("q = " + qQS, x, y);
  fill(colors[5]);
  fill(0);
  y += 15;
  text(message, x, y);
}

void resetBeerColors() {
  for (int i = 0; i < beers.length; i++) {
    beers[i].resetColor();
  }
}

void setBeerColors() {
  for(int i = pQS + 1; i <= qQS; i++) {
    beers[i].setColor(120);
  }
  if(iQS < beers.length) beers[iQS].setColor(colors[1]);
  if(jQS >= 0 && jQS < beers.length) beers[jQS].setColor(colors[2]);
  //if(kQS >= 0 && kQS < beers.length) beers[kQS].setColor(colors[3]);
  beers[rQS].setColor(colors[7]);
}

void parseDataLine() {
  String [] temp = new String [10];
  temp= split(data[stepIndex], ',');
  id = Integer.parseInt(temp[0]);
  iQS = Integer.parseInt(temp[1]);
  jQS = Integer.parseInt(temp[2]);
  kQS = Integer.parseInt(temp[3]);
  pQS = Integer.parseInt(temp[4]);
  qQS = Integer.parseInt(temp[5]);
  lQS = Integer.parseInt(temp[6]);
  rQS = Integer.parseInt(temp[7]);
  println(beers[rQS].alcohol);
  message = temp[8];
  checkID();
  stepIndex++;
}

void checkID() {
  switch (id) {
    case 7: 
      swap(iQS, jQS);
      setArrow(iQS, jQS);
      break;
    case 8:
      swap(iQS, pQS);
      setArrow(iQS, pQS);
      break;
    case 9:
      swap(jQS, qQS);
      setArrow(jQS, qQS);
    case 10: 
      swap(iQS, rQS);
      setArrow(iQS, rQS);
      break;
    case 11:
      swap(kQS, jQS);
      setArrow(kQS, jQS);
      break;
    case 12:
      swap(kQS, iQS);
      setArrow(kQS, iQS);
      break;
    default: break;  
  }
}

void swapBeerPosition(int m, int n) {
  int tempX = beers[m].x;
  int tempY = beers[m].y;
  beers[m].x = beers[n].x;
  beers[m].y = beers[n].y;
  beers[n].x = tempX;
  beers[n].y = tempY;
}

/*
void oneSwapBeer() {
  String [] temp = new String [11];
  temp= split(swaps[swapIndex], ',');
  int x = Integer.parseInt(temp[2]);
  int y = Integer.parseInt(temp[3]);
  swapBeer(x, y);
  swapIndex++;
  if(swapIndex == swapNum) {
    resetBeer();
  }
}
*/

void keyPressed() {
  if (key == 'n') {
    resetBeerPositions();
    resetBeerColors();
    parseDataLine();
    setBeerColors();
    checkArrow();
  }
  else if (key == 'r') {
    println(beers[jQS].alcohol);
  }
}
    

void oneSwapPosition() {
  String [] temp = new String [11];
  temp = split(swaps[swapIndex], ',');
  int m = Integer.parseInt(temp[0]);
  int n = Integer.parseInt(temp[1]);
  int piv = Integer.parseInt(temp[10]);
  swapBeerPosition(m, n);
  swapIndex++;
  if(swapIndex == swapNum) {
    resetBeerPositions();
    swapIndex = 0;
  }
}

void resetBeerPositions() {
   for (int i = 0; i < beers.length; i++) { 
    beers[i].x = (i + 1) * 35;
    beers[i].y = (i + 1) * 35;
  }
}

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

void loadBeer() {
  lines = loadStrings("shortListBrews.csv");
  beers = new Beer[lines.length - 1];
  swapIndex = 0;
   for (int i = 1; i < lines.length; i++) {
    String [] temp = new String [10];
    temp= split(lines[i], ',');
    beers[i - 1] = new Beer(i * 35, i*35, i - 1, temp[0], temp[1], temp[2], temp[3]);
  }
}

void loadCode() {
  code = loadStrings("qs.txt");
}

void displayCode(int x, int y) {
  for(int i = 0; i < code.length; i++) {
    fill(0);
    if(codeHighlighted(i)) fill(0, 250, 250);
    textSize(17);
    text(code[i], x, i*16 + y);
  }
}

boolean codeHighlighted(int lineNum) {
  if(id == -1) return false;
  int startArrow = codeBlocks[id * 2];
  int stop = codeBlocks[id * 2 + 1];
  if (lineNum >= startArrow && lineNum <= stop) {
    return true;
  }
  return false;
}

void swap(int x, int y) {
  Beer temp = beers[x];
  beers[x] = beers[y];
  beers[y] = temp;
  resetBeerPositions();
}

void setArrow(int x, int y) {
  showArrow = true;
  arrowIndex = 0;
  startArrow = (x + 1) * 35;
  endArrow = (y + 1) * 35;
}

void displayArrow() {
  if(showArrow) {
    int len = startArrow - endArrow;
    stroke(0);
    fill(0);
    strokeWeight(5);
    int aHeight = 50;
    line(startArrow, aHeight, endArrow, aHeight);
    
    // draw arrow head
    // determine direction of arrow head
    if(len > 0) {
      line(endArrow + 5, aHeight - 5, endArrow, aHeight);
      line(endArrow + 5, aHeight + 5, endArrow, aHeight);
    }
    else {
      line(endArrow - 5, aHeight - 5, endArrow, aHeight);
      line(endArrow - 5, aHeight + 5, endArrow, aHeight);
    }
  }
}

void checkArrow() {
  if(showArrow) {
    arrowIndex++;
    if(arrowIndex == 2) {
      arrowIndex = 0;
      showArrow = false;
    }
  }
}

