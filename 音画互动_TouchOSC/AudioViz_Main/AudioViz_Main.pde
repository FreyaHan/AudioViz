import nice.palettes.*;

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import oscP5.*;
import netP5.*;


OscP5 oscP5;
Minim minim;
AudioPlayer song;
BeatDetect beat;
FFT fftLin;
FFT fftLog;

Attractor a;

ColorPalette palette;
int paletteNum = 43;

float n1, n2;
float xPos, yPos;
float colourH, colourB, colourS, max;
color c;
float eRadius;
//create an array list for mover class
ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  fullScreen(P3D);
  //size(1024, 800, P3D);
  smooth();
  background(0);
  noCursor();

  beat = new BeatDetect();
  minim = new Minim(this);
  song = minim.loadFile("daddy.mp3", 1024);
  song.loop(); 

  fftLin = new FFT( song.bufferSize(), song.sampleRate() );
  fftLin.linAverages( 30 );
  fftLog = new FFT( song.bufferSize(), song.sampleRate() );
  fftLog.logAverages( 22, 3 );

  //start oscP5, listening for incoming messages at port 12000 //
  oscP5 = new OscP5(this, 12000);
}


void draw() {

  colorMode(HSB, 360, 100, 100);
  fill(0, 0, 0, 50);  
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);

  //println(millis());
  //Pattern1();
  //control the time of demostrating pattern1
  int timer = millis();
  if (timer >17357) {
    Pattern2();
  }

  ////map attractor and inner pattern colour with fft
  fftLin.forward( song.mix );
  fftLog.forward( song.mix );
  for (int j = 0; j < fftLin.avgSize(); j = j+1) {

    if (fftLin.getAvg(j) > 0.1) {
      // range are based on fftLin.getAvg(j)
      // some values of fftLin.getAvg(j) are outside of the range,
      // in order to get as many colours as possible
       colourH = map(fftLin.getAvg(j), 0.1, 0.13, 0, 30); 
      colourS = map(fftLin.getAvg(j), 0, 4, 50, 70);
      colourB = map(fftLin.getAvg(j), 0, 0.5, 80, 100); 

      //find max and fftLin.getAvg(j)
      if (max < fftLin.getAvg(j)) {
        max = fftLin.getAvg(j);
      }
      //println("maxAve"+max);
      //println("getAve"+fftLin.getAvg(j));
    }
    c = color (int(colourH), int(colourS), int (colourB));
  }
  fill(c);


  // draw inner pattern
  Pattern1();

  //draw attractor
  a = new Attractor(0, 0);
  a.display();

  // apply colour to movers
  applyColor();

  //draw movers     
  for ( int i = 0; i< movers.size()-1; i++) {
    Mover m = movers. get(i);
    PVector force = a.attract(m);
    m.applyForce(force);
    m.display();
    m.update();

    if (m.finished()) {
      movers.remove(i);
    }
  }

  //draw beating point
  //reference: minim example, beat detection
  beat.detect(song.mix);
  if ( beat.isOnset() ) eRadius = 40;
  fill(c);
  ellipse(0, 0, eRadius, eRadius);
  eRadius *= 0.9;
  if ( eRadius < 20 ) eRadius = 20;
}


void addMovers() {
  movers.add( new Mover (random(0.1, 1), xPos*width-width/2+random(-70, 70), yPos*height-height/2+random(-70, 70)));
}

void applyColor() {
  palette = new ColorPalette(this);
  printArray(palette.getPalette(paletteNum));
}

void oscEvent(OscMessage theOscMessage) {
  
  //learn how to map xypad by referring
  //https://github.com/dcts/oscListener-game/tree/d12913c6bf37e60bf53cad94d9d25023686d227b
  //http://ericmedine.com/touch-osc-visualizer-processing/

  // print the address pattern and the typetag of the received OscMessage 
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if (theOscMessage.addrPattern().equals("/xy") ) {
    xPos = (float)theOscMessage.arguments()[1];
    yPos = (float)theOscMessage.arguments()[0];
    println("x="+xPos+" y="+yPos);
    //bubbles.add( new Bubble (xPos*width-width/2, yPos*height-height/2));
    addMovers();
  }

  if (theOscMessage.addrPattern().equals("/button1") ) {
    paletteNum = 29;
  }
  if (theOscMessage.addrPattern().equals("/button2") ) {
    paletteNum = 41;
  }  
  if (theOscMessage.addrPattern().equals("/button3") ) {
    paletteNum = 43;
  }
}
