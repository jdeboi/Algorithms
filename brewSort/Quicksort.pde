/* 
This Quicksort object is designed for creating logs necessary to
create visulazations of the quicksort algorithm, in this case, a 
3 partition quicksort. When the object is instantiated, the constructor 
generates 2 files:

1. qsSwaps.txt
a log ofthe indexes of beers involved in a swap, which is used
to replay/reset all the swaps that occur during quicksort()

2. qsLog.txt
This file is used for the visualization. Each line represents a different
step in the quicksort algorithm and contains the following information:
- positions of all beers listed in the beers' original order
- colors (stored as an int, colorID) of all beers
- values of quicksort variables i, j, k, p, q, l, r
*/

class Quicksort {
  
  // PrintWriter objects to keep track of beer swaps/colors
  PrintWriter qsSwaps;
  PrintWriter qsLog;
  
  // variable to keep track of step in algorithm
  int id;
  
  String[] swaps;
  String[] log;
  String[] code;
  
  // variables used in quicksort()
  int i;
  int j;
  int k;
  int p;
  int q;
  int l;
  int r;
  String message = "";
  
  // variables to keep track of the the swaps
  // (useful for reseting the beers[] array to its original
  // order
  int swapIndex = 0;
  int swapNum = 0;
  
  // flag to keep turn on/off printing swaps
  boolean printing;
  
  
  // arrays to keep track of beer positions and colors
  // at various points through the quicksort algorithm
  int[] positions;
  int[] highlights;
  
  // array
  int[][] codeBlocks = {
    // start and stop line numbers from qs.txt that correspond 
    // to line IDs - the first number printed by printLine()
    // this 2D array is used determine code text highlights at each
    // step in the algorithm 
    // line id 0, 1, 2, 3
    {1, 1}, {2, 2}, {4, 10}, {4, 10},        
    {11, 12}, {12, 12}, {13, 13},{14, 14},   // 4 - 7  
    {15, 15}, {18, 18}, {19, 19}, {21, 21},  // 8 - 11
    {22, 22}, {23, 24}, {24, 24}, {26, 26},  // 12 - 15
    {27, 28}, {28, 28}, {31, 31}, {32, 33},  // 16 - 19
    {32, 33}, {34, 34}, {34, 34}, {35, 35},  // 20 - 23
    {35, 35}, {35, 35}, {37, 37}, {38, 38},  // 24 - 27
    {0, 0} //28
  };
  
  // the constructor is where we call the functions that
  // print the steps of the algorithm
  Quicksort() {
    startPrinting();
    quicksort(0, beers.length - 1);
    stopPrinting();
    loadFiles();
    resetBeer();
  }
  
  // the algorithm interspersed with the function printLine
  // to keep track of all the steps of the algorithm
  void quicksort (int left, int right){
    printLine("", 0);
    if (right <= left) {
      printLine("beers[" + right + "]  <= beers[" + left + "]; return", 1);
      return;
    }
    printLine("", 2);
    float pivot = beers[right].alcohol;
    i = left - 1;
    j = right;
    p = left - 1;
    q = right;
    l = left;
    r = right;
    printLine("", 3);
    for (;;) {
      printLine("", 4);
      while (beers[++i].alcohol < pivot) {
        message = "beers[" + i + "] < pivot";
        printLine(message, 5);
      }
      printLine("beers[" + i + "] >= pivot", 6);
      while (pivot < beers[--j].alcohol) {
        printLine("beers[" + j + "] > pivot", 7);
        if(j == left) {
          printLine("j == left", 8);
          break;
        }
      }
      printLine("beers[" + j + "] <= pivot", 9);
      if (i >= j) {
        printLine("i >= j", 10);
        break;
      }
      printLine("swap beers[" + i + "] and beers[" + j + "]", 11);
      swapBeer (i, j);
      printLine("", 12);
      if (pivot == beers[i].alcohol) {
        p++; 
        printLine("beers[" + i + "] = pivot; swap beers[" + i + "] & beers[" + p + "]", 13); 
        swapBeer(p, i);
        printLine("", 14);
      }
      printLine("", 15); 
      if (pivot == beers[j].alcohol) {
        q--;
        printLine("beers[" + j + "] = pivot; swap beers[" + j + "] & beers[" + q + "]", 16); 
        swapBeer(j, q);
        printLine("", 17);
      }
    }
    printLine("swap beers[" + i + "] and pivot", 18); 
    swapBeer(i, right);
    printLine("", 19);
    j = i - 1;
    i = i + 1;
    printLine("", 20);
    for (k = left; k < p; k++, j--) {
      printLine("swap beers[" + k + "] and beers[" + j + "]", 21); 
      swapBeer(k, j);
      printLine("", 22);
    }
    printLine("", 23);
    for (k = right - 1; k > q; k--, i++) { 
      printLine("swap beers[" + k + "] and beers[" + i + "]", 24);
      swapBeer(k, i);
      printLine("", 25);
    }
    printLine("left quicksort(" + left + ", " + j + ")", 26);
    quicksort(left, j);
    printLine("right quicksort(" + i + ", " + right + ")", 27);
    quicksort(i, right);
    printLine("", 28);
  }
  
  void swapBeer (int x, int y) {
    Beer temp = beers[x];
    beers[x] = beers[y];
    beers[y] = temp;
    if(printing) {
      printSwap(x, y);
      swapNum++;
    }
  }
  
  void printSwap(int x, int y) {
    String line = x + "," + y;
    qsSwaps.println(line);
  }
  
  void printLine(String message, int type) {
    setPositions();
    setHighlights();
    String line = getPositions();
    line += "," + getHighlights();
    line += "," + i + "," + j + "," + k;
    line += "," + p + "," + q + "," + l + "," + r;
    qsLog.println(type + "," + line + "," + message);
  }
  
  // returns beers[] array to original order
  void resetBeer() {
    do {
      swapIndex--;
      String [] temp = new String [2];
      temp = split(swaps[swapIndex], ',');
      int x = Integer.parseInt(temp[0]);
      int y = Integer.parseInt(temp[1]);
      swapBeer(x, y);
    }
    while (swapIndex > 0);
  }
  
  // populations the positions array with each beer's
  // position at that step in the algorithm
  void setPositions() {
    for (int m = 0; m < beers.length; m++) {
      positions[beers[m].num] = (m + 1) * 35;
    }
  }
  
  // populations the highlights array with each beer's
  // colorID at that step in the algorithm
  void setHighlights() {
    for (int m = 0; m < beers.length; m++) {
      int colorID = 0;
      if(m == i) colorID = 1;
      else if (m == j) colorID = 2;
      else if (m == r) colorID = 7;
      else if (m > p && m <= q) colorID = 6;  
      highlights[beers[m].num] = colorID;
    }
  }
  
   // returns the positions of each beer at various points during
  // the sort algorithm; positions are listed in the beers' original
  // order
  String getPositions() {
    String pos = "";
    for(int m = 0; m < positions.length; m++) {
      if (m != positions.length - 1) pos += (positions[m] + ",");
      else {pos += positions[m];}
    }
    return pos;
  }
  
  String getHighlights() {
    String high = "";
    for(int m = 0; m < highlights.length; m++) {
      if (m != highlights.length - 1) {
        high += highlights[m];
        high += ",";
      }
      else {high += highlights[m];}
    }
    return high;
  }
  
  void startPrinting() {
    positions = new int[beers.length];
    highlights = new int[beers.length];
    qsSwaps = createWriter("qsSwaps.txt");
    qsLog = createWriter("qsLog.txt");
    printing = true;
  }
  
  void stopPrinting() {
    printing = false;
    qsSwaps.flush();
    qsSwaps.close();
    qsLog.flush();
    qsLog.close();
  }
  
  void loadFiles() {
    swaps = loadStrings("qsSwaps.txt");
    log = loadStrings("qsLog.txt");
    code = loadStrings("qs.txt");
    swapIndex = swapNum;
  }
 

///////////////////////////////////////////////////
  
  void parseDataLine() {
    String [] temp = new String [45];
    temp= split(log[stepIndex], ',');
    id = Integer.parseInt(temp[0]);
    i = Integer.parseInt(temp[37]);
    j = Integer.parseInt(temp[38]);
    k = Integer.parseInt(temp[39]);
    p = Integer.parseInt(temp[40]);
    q = Integer.parseInt(temp[41]);
    l = Integer.parseInt(temp[42]);
    r = Integer.parseInt(temp[43]);
    message = temp[44];
    for (int i = 0; i < beers.length; i++) {
      int pos = Integer.parseInt(temp[i + 1]);
      int colID = Integer.parseInt(temp[i + 1 + beers.length]);
      beers[i].x = pos;
      beers[i].c = colors[colID];
    }
  }
  
  boolean atLogEnd() {
    if(stepIndex == log.length) return true;
    return false;
  }
  
  void displayQS() {
    displayText(500, 50);
    displayCode(670, 40);
  }
  
  void displayCode(int x, int y) {
    for(int i = 0; i < code.length; i++) {
      fill(0);
      if(codeHighlighted(i)) fill(0, 250, 250);
      textSize(17);
      text(code[i], x, i*16 + y);
    }
  }
  
  void displayText(int x, int y) {
    fill(colors[1]);
    text("i = " + i, x, y);
    fill(colors[2]);
    y += 15;
    text("j = " + j, x, y);
    fill(colors[7]);
    y += 15;
    text("pivot = beers[" + r + "]", x, y); 
    fill(colors[4]);
    y += 15;
    text("p = " + p, x, y);
    y += 15;
    text("q = " + q, x, y);
    fill(colors[5]);
    fill(0);
    y += 15;
    text(message, x, y);
  }
  
  boolean codeHighlighted(int lineNum) {
    if(i == -1) return false;
    int start = codeBlocks[i][0];
    int stop = codeBlocks[i][1];
    println(start + " " + stop);
    if (lineNum >= start && lineNum <= stop) {
      return true;
    }
    return false;
  }
}

