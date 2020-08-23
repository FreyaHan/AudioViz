class Mover {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass, size;
  float count;
 

  Mover(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
  }

  // applyforce to acceleration
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }



  void update() {
    
    //acceleration chage velocity, velocity change position
    velocity.add(acceleration);
    position.add(velocity);
    
    //keep the acceleration always be the same in every draw loop
    acceleration.mult(0);
    
    //timer parameter
    count +=2;
    
    size *= 0.96;
    
  }

  void display() {
    noStroke();
    
    // color filling inspired by Sayama, he uses URL to get palette
    //https://www.openprocessing.org/sketch/875086
    //I get palette from processing library NiceColorPalettes
    //https://github.com/federico-pepe/nice-color-palettes
    
    //random the colors to mimic blinking effect
    fill (palette.colors[(int)random(4)],30);
 
    float size =mass*30;
    ellipse(position.x, position.y, size, size);
    
  }

  boolean finished() {
    if (count>180) {
      return true;
    } else {
      return false;
    }
  }
}
