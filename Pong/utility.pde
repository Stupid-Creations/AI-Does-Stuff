class quad {
  int w;
  int h;

  PVector pos;
  PVector max;
  PVector min;
  PVector vel;

  quad(int xa, int ya, int rwidth, int rheight) {
    w = rwidth;
    h = rheight;

    pos = new PVector(xa, ya);

    min = pos;
    max = new PVector(pos.x+w, pos.y+h);
  }

  void render() {
    rect(pos.x, pos.y, w, h);
  }

  void update() {
    min = pos;
    max = new PVector(pos.x+w, pos.y+h);
  }    

  void move(PVector m) {
    vel = m;
    pos.add(vel);
  }

  boolean collide(quad a) {
    return !(max.x<a.min.x||max.y<a.min.y||min.x>a.max.x||min.y>a.max.y);
  }
}

class pong {
  quad paddle;
  quad ball;

  boolean alive;
  float score;
  color colour;

  n_layer a;
  n_layer b;

  pong() {
    paddle = new quad(0, 125, 25, 150);
    ball = new quad(200-12, 300-12, 25, 25);
    paddle.vel = new PVector(0, 0);
    ball.vel = new PVector(3, 3);

    alive = true;

    colour = color(random(0, 255), random(0, 255), random(0, 255));

    a = new n_layer(4, 5);
    b = new n_layer(5, 2);
  }

  pong(n_layer ab, n_layer ba, color c) {
    paddle = new quad(0, 125, 25, 150);
    ball = new quad(200-12, 300-12, 25, 25);
    ball.vel = new PVector(3, 3);
    paddle.vel = new PVector(0, 0);

    alive = true;

    a = ab;
    b = ba;

    colour = c;
  }

  void update() {
    if (alive) {
      fill(colour);
      paddle.render();
      ball.render();

      paddle.update();
      ball.update();

      ball.move(ball.vel);
      if (ball.max.y >= height) {
        ball.vel.y *= -1;
        ball.pos.y -= 20;
      }
      if (ball.max.x >= 700) {
        ball.vel.x *= -1;
        ball.pos.x -= 20;
      }
      if (ball.min.y<0) {
        ball.vel.y = -ball.vel.y;
      }
      if (paddle.collide(ball)) {
        float diff = ball.pos.y - (paddle.pos.y - paddle.h/2 );
        float rad = radians(45);
        float angle = map(diff, 0, paddle.h, -rad, rad);
        ball.vel.x = 30*cos(angle);
        ball.vel.y = 30*sin(angle);
        ball.vel.setMag(5);
        score++;
      }
      if (ball.max.x < 0) {
        alive = false;
      }
      if (abs(ball.vel.y/ball.vel.x) > 10) {
        alive = false;
      }

      paddle.move(paddle.vel);

      a.activate(new float[] { ball.min.y, paddle.min.y, ball.vel.mag(), ball.min.x});
      b.activate(a.pred);

      if (a.pred[0] > 0.5) {
        paddle.vel.y = abs(ball.vel.y);
      } 
      if (a.pred[1] > 0.5) {
        paddle.vel.y = -abs(ball.vel.y);
      }
    }
  }
}
