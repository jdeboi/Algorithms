void quicksort (int left, int right) {
    if (right <= left) return;
    float pivot = beers[right].alcohol;
    for (;;) {
      while (beers[++i].alcohol < pivot);
      while (pivot < beers[--j].alcohol) {
		  if(j == left) break;
	  }
      if (i >= j) break;
      swapBeer (i, j);
      if (pivot == beers[i].alcohol) {
        p++; 
        swapBeer(p, i);
      } 
      if (pivot == beers[j].alcohol) {
        q--;
        swapBeer(j, q);
      }
    }
    swapBeer(i, right);
    j = i - 1;
    i = i + 1;
    for (k = left; k < p; k++, j--) swapBeer(k, j);
    for (k = right - 1; k > q; k--, i++) swapBeer(k, i);
  
    quicksort(left, j);
    quicksort(i, right);
  }
  
  void swapBeer (int x, int y) {
    Beer temp = beers[x];
    beers[x] = beers[y];
    beers[y] = temp;
  }
  