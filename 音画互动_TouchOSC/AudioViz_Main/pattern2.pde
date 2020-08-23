//white pattern 
void Pattern2() { 

  for (int i = 0; i < song.bufferSize() -1; i+=1) {

    //reference: Murph created by Teekayeh
    //https://pastebin.com/JtAn1mV5
    // I changed parameters to modify the pattern
    float r2 = cos(i+n1)*2;
    float x2 = cos(radians(i))*(150/r2+100);
    float y2 = sin(radians(i))*(150/r2+100);


    fill(0, 0, 99);
    ellipse(x2, y2, song.left.get(i)*5, song.left.get(i)*5);
  }
  n2+=0.007;
}
