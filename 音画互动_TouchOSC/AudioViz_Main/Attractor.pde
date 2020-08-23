// Attractor and Mover references:

//Daniel Shiffman - <Nature of Code> series videos
//1.1 ~ 2.6 (PVectore, Force) 
//4.2 ~ 4.3 (arraylist)
//https://www.youtube.com/watch?v=6vX8wT1G798&list=PLRqwX-V7Uu6aFlwukCmDf0-1-uSR7mklK
//https://github.com/nature-of-code/noc-examples-processing/tree/master/chp02_forces/NOC_2_7_attraction_many


class Attractor {
  float mass;    
  float G;      
  PVector position;   

  Attractor(float x, float y) {
    position = new PVector(x, y);
    mass = 20;
    G = 2;
  }

//create force from movers to the attractor
  PVector attract(Mover m) {
    PVector force = PVector.sub(position, m.position);   
    float d = force.mag();                              
    d = constrain(d, 5.0, 25.0);                       
    force.normalize();                                  
    float strength = (G * mass * m.mass) / (d * d);      
    force.mult(strength);                              
    return force;
  }


  void display() {
    ellipseMode(CENTER);
    noStroke(); 
    // make the attractor transparent
   noFill();
    ellipse(position.x, position.y,1, 1);
  }
}
