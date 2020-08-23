//mathematical principle
//Coding Challenge #55: Mathematical Rose Patterns - video - Created by Daniel Shiffman
//https://www.youtube.com/watch?v=f5QBExMNB1I&t=206s

//Using Processing to draw super rose curves - blog - created by reona296
//http://blog.livedoor.jp/reona396/archives/54660457.html

void Pattern1() { 

  for (int i = 0; i < song.bufferSize() -1; i+=2) {

    // Flower, created by Michael Pinn 
    // https://www.openprocessing.org/sketch/157286
    // I changed parameters to modify the pattern
    float r1 = cos(i+n2)*i/20;
    float x1 = cos(radians(i))*(150+r1);
    float y1 = sin(radians(i))*(150+r1);

    ellipse(x1, y1, song.right.get(i)*7, song.right.get(i)*7);
  }  
  n1+=0.01;
}
