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
        w[i][j] = randomGaussian();
      }
    }
    for (int i = 0; i < bias.length; i++) {
      bias[i] = randomGaussian();
    }
  }
  void activate(float[]m) {
    int colsa = w[0].length;
    int rowsa = w.length;
    int colsb = 1;
    int rowsb = bias.length;
    
    if(m.length != n1){
      print('a');
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
    pred = sigmoid(pred);
  }
}

n_layer reproduce(n_layer a, n_layer b) {
  n_layer c = new n_layer(a.n1, a.n2);
  int m = 100;
  for (int i =0; i<a.w.length; i++) {
    for (int j = 0; j<a.w[0].length; j++) {
      int choose = int(random(-1, m));
      if (choose>0) {
        int choose1 = round(random(0, 2));
        if (choose1 == 1) {
          c.w[i][j] = a.w[i][j];
        }
        if (choose1 == 0) {
          c.w[i][j] = b.w[i][j];
        }
      }
      if (choose == -1) {
        c.w[i][j] = randomGaussian();
      }
    }
  }
  for (int i = 0; i<a.bias.length; i++) {
    int choose = round(random(-1, m));
    if (choose>0) {
      int choose1 = round(random(0, 2));
      if (choose1 == 1) {
        c.bias[i] = a.bias[i];
      }
      if (choose1 == 0) {
        c.bias[i] = b.bias[i];
      }
    } else {
      c.bias[i] = randomGaussian();
    }
  }
  return c;
}

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

int get_index(ArrayList<pong> ugh, float a) {
  for (int i = 0; i < ugh.size(); i++) {
    if (ugh.get(i).score == a) {
      return i;
    }
  }
  return 750/2;
}

int get_index(FloatList ugh, float a) {
  for (int i = 0; i < ugh.size(); i++) {
    if (ugh.get(i) == a) {
      return i;
    }
  }
  return 750/2;
}
