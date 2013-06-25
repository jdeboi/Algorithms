import java.io.*;
import java.util.*;

String[] lines; 
Beer[] beers;

boolean startSort;

Quicksort qs;


int stepIndex = 0;
color [] colors = {20, #71A03C, #3CA097, 150, 150, #181183, #413F64, #FC0000};

void setup() {
  size(1200, 700);
  loadBeer();
  qs = new Quicksort();
  startSort = false;
}

void draw() {
  background(255);
  frameRate(10);
  if(startSort) {
    backgroundBeer();
    displayBeer();
    qs.display();
  }
  else {
    textSize(200);
    fill(0);
    text("brewSort", 50, 200);
    textSize(30);
    text("3 way partition quick sort of Louisiana beer by alcohol content", 50, 400);
    text("press 'n' to step through the algorithm", 50, 500);
  }
}

void backgroundBeer() {
  for (int i = 0; i < beers.length; i++) {
    beers[i].backgroundImage();
  }
}

void displayBeer() {
  for (int i = 0; i < beers.length; i++) {
    beers[i].displayVertical();
  }
}

void keyPressed() {
  if (key == 'n') {
    if(!startSort) {
      startSort = true;
      return;
    }
    qs.stepQS();
    stepIndex++;
    if (qs.atLogEnd()) {
      resetBeer();
      stepIndex = 0;
    }
  }
  else if (key == 'p') {
    stepIndex = stepIndex - 2;
    if (stepIndex < 0) {
      resetBeer();
      stepIndex = 0;
      startSort = false;
    }
    qs.stepQS();
  }
  else if (key == 'r') {
    resetBeer();
    stepIndex = 0;
    startSort = false;
  }
}

void loadBeer() {
  lines = loadStrings("/files/shortListBrews.csv");
  beers = new Beer[lines.length - 1];
   for (int i = 1; i < lines.length; i++) {
    String [] temp = new String [10];
    temp= split(lines[i], ',');
    beers[i - 1] = new Beer(i * 35, i*35, i - 1, temp[0], temp[1], temp[2], temp[3]);
  }
}

void resetBeer() {
  resetBeerPositions();
  resetBeerColors();
  qs.resetVariables();
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


