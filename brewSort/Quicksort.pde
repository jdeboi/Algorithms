/* 
Quicksort is designed for creating visualizations of the quicksort 
algorithm, in this case, a 3 partition quicksort. When the Quicksort
object is instantiated, the constructor generates 2 files:

1. qsSwaps.txt
a log ofthe indexes of beers involved in a swap, which can be used
to replay/reset all the swaps that occur during quicksort()

2. qsLog.txt
a file with the positions and colors (stored as an int, colorID) of
all beers (listed in the beers' original order) at each step in the
quicksort algorithm. This file is used for the visualization.
*/

class Quicksort {
  
  // PrintWriter objects to keep track of beer swaps/colors
  PrintWriter qsSwaps;
  PrintWriter qsLog;
  
  // variables used in quicksort()
  int i;
  int j;
  int k;
  int p;
  int q;
  int l;
  int r;
  
  int swapIndex = 0;
  int swapNum = 0;
  String[] swaps;
  
  // flag to keep turn on/off printing swaps
  boolean printing;
  
  
  // arrays to keep track of beer positions and colors
  // at various points through the quicksort algorithm
  int[] positions;
  int[] highlights;
  
  Quicksort() {
    startPrinting();
    quicksort(0, beers.length - 1);
    stopPrinting();
    loadSwaps();
    resetBeer();
  }
  
  void quicksort (int left, int right){
    String message ="";
    printLine("", 0);
    if (right <= left) {
      message = "beers[" + right + "]  <= beers[" + left + "]; return";
      printLine(message, 1);
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
  
  void setPositions() {
    for (int m = 0; m < beers.length; m++) {
      positions[beers[m].num] = (m + 1) * 35;
    }
  }
  
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
  
  void loadSwaps() {
    swaps = loadStrings("qsSwaps.txt");
    swapIndex = swapNum;
  }   
}
