float sigmoid(float x) {
  return 1/(1+exp(-x));
}

float[] sigmoid(float[] x) {
  float[]a = new float[x.length];
  for (int i = 0; i<a.length; i++) {
    a[i] = sigmoid(x[i]);
  }
  return a;
}

float tanh(float x) {
  return (exp(x*2)-1)/(exp(x*2)+1);
}
float[] tanh(float[] x) {
  float[]a = new float[x.length];
  for (int i = 0; i<a.length; i++) {
    a[i] = tanh(x[i]);
  }
  return a;
}

void printmatrix(float[][] a) {
  for (int i = 0; i<a.length; i++) {
    for (int j = 0; j<a[i].length; j++) {
      print(a[i][j]+" ");
    }
    println();
  }
}

class n_layer {
  int n1;
  int n2;
  float[][] w;
  float[]bias;
  float[]pred;
  float cost;
  n_layer(int a, int b) {
    n1 = a;
    n2 = b;
    bias = new float[n2];
    pred = new float[n2];
    w = new float[n2][n1];
    for (int i = 0; i<w.length; i++) {
      for (int j = 0; j<w[i].length; j++) {
        w[i][j] = random(0, 1);
      }
    }
    for (int i = 0; i < bias.length; i++) {
      bias[i] = random(0, 1);
    }
  }
  void activate(float[]m, boolean a) {
    int colsa = w[0].length;
    int rowsa = w.length;
    int colsb = 1;
    int rowsb = bias.length;

    if (n1 != m.length) {
      print(n1);
      return;
    }

    for (int i = 0; i < rowsa; i++) {
      for (int j = 0; j < colsb; j++) {
        float sum = 0;
        for (int k = 0; k<colsa; k++) {
          sum += w[i][k] * m[j];
        }
        pred[i] = sum;
      }
    }
    for (int i = 0; i<pred.length; i++) {
      pred[i]+=bias[i];
    }
    if (a) {
      pred = sigmoid(pred);
    }
  }
}

n_layer reproduce(n_layer a, n_layer b) {
  n_layer c = new n_layer(a.n1, a.n2);
  for (int i =0; i<a.w.length; i++) {
    for (int j = 0; j<a.w[0].length; j++) {
      int choose = int(random(-1, 10000));
      if (choose>0) {
        int choose1 = int(random(0, 2));
        if (choose1 == 1) {
          c.w[i][j] = a.w[i][j];
        }
        if (choose1 == 0) {
          c.w[i][j] = b.w[i][j];
        }
      }
      if (choose == -1) {
        c.w[i][j] = random(0, 1);
      }
    }
  }
  for (int i = 0; i<a.bias.length; i++) {
    int choose = int(random(-1, 10000));
    if (choose>0) {
      int choose1 = int(random(0, 2));
      if (choose1 == 1) {
        c.bias[i] = a.bias[i];
      }
      if (choose1 == 0) {
        c.bias[i] = b.bias[i];
      }
    } else {
      c.bias[i] = random(0, 1);
    }
  }
  return c;
}

class rocket {
  float d;
  float angle;

  PVector pos;
  PVector acc;
  PVector vel;
  
  boolean col;
  boolean col2;

  n_layer a;
  n_layer b;
  
  color colour;

  rocket() {
    pos = new PVector(200, 300);
    acc = new PVector();
    vel = new PVector();

    a = new n_layer(4, 4);
    b = new n_layer(4, 3);
    
    colour = color(random(0,255),random(0,255),random(0,255));
  }
  rocket(n_layer ab, n_layer ba,color c ) {
    pos = new PVector(200, 300);
    acc = new PVector();
    vel = new PVector();
    a = ab;
    b = ba;
    
    colour = c;
    
  }
  void render() {
    push();
    fill(colour);
    translate(pos.x, pos.y);
    rectMode(CENTER);
    rotate(radians(angle));
    rect(0, 0, 25, 50);
    circle(0,0,25);
    pop();
  }
  void update(PVector dot) {
    float[]m = {pos.x-dot.x, pos.y-dot.y, vel.x, vel.y};
    a.activate(m, true);
    b.activate(a.pred, false);
    acc.x = tanh(b.pred[0]);
    acc.y = tanh(b.pred[1]);
    angle = tanh(b.pred[2])*360;

    vel.add(acc).add(PVector.fromAngle(angle));
    pos.add(vel);
    vel.normalize();
  }
}

int get_index(ArrayList<rocket> ugh, float a) {
  for (int i = 0; i < ugh.size(); i++) {
    if (ugh.get(i).d == a) {
      return i;
    }
  }
  return 500;
}

int get_index(FloatList ugh, float a) {
  for (int i = 0; i < ugh.size(); i++) {
    if (ugh.get(i) == a) {
      return i;
    }
  }
  return 500;
}

boolean on(PVector pos) {
  if (pos.x<0||pos.x>400) {
    return false;
  }
  if (pos.y<0||pos.y>400) {
    return false;
  }
  return true;
}

void keyPressed(){
  dot = new PVector(random(0,400),random(0,400));
}
