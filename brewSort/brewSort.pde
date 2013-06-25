import java.io.*;
import java.util.*;

String[] lines; 
  
int swapIndex;
int swapNum;

boolean showArrow;
int startArrow;
int endArrow;
int arrowIndex;

Beer[] beers;
Quicksort qs;


int stepIndex = 0;
color [] colors = {0, #001BFC, #00FC4D, 140, 150, #EBFC00, #FC7A00, #FC0000};

void setup() {
  size(1200, 700);
  loadBeer();
  qs = new Quicksort();
}

void draw() {
  background(255);
  frameRate(10);
  displayBeer();
  qs.displayQS();
}

void displayBeer() {
  for (int i = 0; i < beers.length; i++) {
    beers[i].displayVertical();
  }
  delay(1000);
}

void resetBeer() {
  resetBeerPositions();
  resetBeerColors();
}

void resetBeerColors() {
  for (int i = 0; i < beers.length; i++) {
    beers[i].resetColor();
  }
}

void resetBeerPositions() {
   for (int i = 0; i < beers.length; i++) { 
    beers[i].x = (i + 1) * 35;
    beers[i].y = (i + 1) * 35;
  }
}

void keyPressed() {
  if (key == 'n') {
    qs.parseDataLine();
    stepIndex++;
    if (qs.atLogEnd()) {
      resetBeer();
      stepIndex = 0;
    }
  }
  if (key == 'r') {
    resetBeer();
    stepIndex = 0;
  }
}

void loadBeer() {
  lines = loadStrings("/files/shortListBrews.csv");
  beers = new Beer[lines.length - 1];
  swapIndex = 0;
   for (int i = 1; i < lines.length; i++) {
    String [] temp = new String [10];
    temp= split(lines[i], ',');
    beers[i - 1] = new Beer(i * 35, i*35, i - 1, temp[0], temp[1], temp[2], temp[3]);
  }
}


