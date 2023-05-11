ArrayList<pong> stupids = new ArrayList<pong>();
ArrayList<Boolean> check = new ArrayList<Boolean>();
FloatList score = new FloatList();

int gen = 1;

void setup() {
  size(700, 700);
  for (int i =0; i<200; i++) {
    stupids.add(new pong());
  }
  for (int i =0; i<200; i++) {
    check.add(stupids.get(i).alive);
    score.append(stupids.get(i).score);
  }
}

void draw() {
  background(0);
  score.clear();
  for (int i =0; i<200; i++) {
    if (stupids.get(i).alive) {
      stupids.get(i).update();
      check.set(i, stupids.get(i).alive);
    }
    score.append(stupids.get(i).score);
  }

  score.sort();
  score.reverse();

  if (!check.contains(true)) {

    for (int i = 0; i < 150; i++) {
      stupids.remove(get_index(stupids, score.min()));
      score.remove(get_index(score, score.min()));
    }
    for (int i = 0; i < 150; i++) {
      stupids.add(new pong(reproduce(stupids.get(i).a, stupids.get(i+1).a),reproduce(stupids.get(i).b,stupids.get(i+1).b), stupids.get(i).colour));
    }
    float x = random(360);
    for (int i = 0; i<200; i++) {
      stupids.get(i).ball.pos = new PVector(200, x);
      stupids.get(i).paddle.pos = new PVector(0, 150);
      stupids.get(i).ball.vel = new PVector(3, 3);
      stupids.get(i).score = 0;
      stupids.get(i).alive = true;
      check.set(i, true);
    }
    gen++;
  }
  textSize(45);
  text(gen, 45, 45);
  text(score.max(), 125, 45);
}

//void keyPressed() {
//  if (key == ' ') {
//    for (int i = 0; i < 100; i++) {
//      stupids.remove(get_index(stupids, score.min()));
//      score.remove(get_index(score, score.min()));
//    }
//    for (int i = 0; i < 100; i++) {
//      stupids.add(new pong(reproduce(stupids.get(i).a, stupids.get(i).a),stupids.get(i).b, stupids.get(i).colour));
//    }
//    float x = random(360);
//    for (int i = 0; i<200; i++) {
//      stupids.get(i).ball.pos = new PVector(200, x);
//      stupids.get(i).paddle.pos = new PVector(0, 150);
//      stupids.get(i).ball.vel = new PVector(3, 3);
//      stupids.get(i).score = 0;
//      stupids.get(i).alive = true;
//      check.set(i, true);
//    }
//    gen++;
//  }
//}

//void mousePressed() {
//  stupids.clear();
//  for (int i = 0; i < 200; i++) {
//    stupids.add(new pong());
//  }
//}
