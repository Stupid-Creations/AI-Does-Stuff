ArrayList<rocket> thing = new ArrayList<rocket>();
ArrayList<Boolean> check = new ArrayList<Boolean>(50);

FloatList score = new FloatList(50);

void setup() {
  for (int i = 0; i<50; i++) {
    thing.add(new rocket());
  }
  size(400, 400);
  ellipseMode(RADIUS);
}

PVector dot = new PVector(200, 100);
float dist;

void draw() {
  background(0);
  fill(0);

  score.clear();

  for (int i = 0; i<50; i++) {
    dist = dot.dist(thing.get(i).pos);
    thing.get(i).col  = false;
    if (dot.dist(thing.get(i).pos)<12.5+25) {
      thing.get(i).col  = true;   
      thing.get(i).col2 = true;
    }
    if (thing.get(i).col2) {
      dist = 0;
    }
    thing.get(i).d = dist;
    score.append(dist);
  }

  for (int i = 0; i<50; i++) {
    check.add(on(thing.get(i).pos));
  }
  score.sort();

  fill(255, 0, 0);
  circle(dot.x, dot.y, 12.5);
  if (!check.contains(true)) {
    for (int i = 0; i<25; i++) {
      thing.remove(get_index(thing, score.max()));
      score.remove(get_index(score, score.max()));
    }
    for (int i = 0; i < 25; i++) {
      thing.add(new rocket(reproduce(thing.get(i).a, thing.get(i+1).a), reproduce(thing.get(i).b, thing.get(i+1).b), thing.get(i).colour));
    }
    for (int i = 0; i<50; i++) {
      thing.get(i).pos = new PVector(200, 300);
      thing.get(i).acc = new PVector();
      thing.get(i).vel = new PVector();
    }
  }

  dot = new PVector(200,100);

  fill(190);
  textSize(45);

  check.clear();

  for (int i = 0; i<50; i++) {
    thing.get(i).update(dot);
    thing.get(i).render();
  }
  text(score.min(), 45, 45);
} 
