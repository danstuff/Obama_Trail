final int BODY_X = 480;
final int BODY_Y = 80;

final int BODY_SIZE = 50;

final int STAT_X = 10;
final int STAT_Y = 240;

final int STAT_SIZE = 164;

final int HEAD_SIZE = 50;

AudioSample walk;

class Person {
  int health;

  String name;

  PImage body_alive1;
  PImage body_alive2;

  PImage body_dead;

  PImage head_alive;
  PImage head_dead;

  boolean wstate;

  Person(String n, String body_a1, String body_a2, String body_d, String head_a, String head_d) {
    health = 100;

    name = n;

    body_alive1 = loadImage(body_a1);
    body_alive2 = loadImage(body_a2);

    body_dead = loadImage(body_d);

    head_alive = loadImage(head_a);
    head_dead = loadImage(head_d);

    wstate = false;
  }

  void drawPerson(int position, int time) {
    if (health > 0) {
      //body
      if (time % 50 < 25) {
        if (wstate == false) {
          walk.trigger();
          wstate = true;
        }

        image(body_alive1, BODY_X + BODY_SIZE*position, BODY_Y);
      } else {
        if (wstate == true) {
          walk.trigger();
          wstate = false;
        }

        image(body_alive2, BODY_X + BODY_SIZE*position, BODY_Y);
      }
    }
  }

  void drawStats(int position) {
    if (health > 0) {      
      //stats bar head
      image(head_alive, STAT_X + STAT_SIZE*position, STAT_Y);

      //stats bar stats
      text(name, STAT_X + STAT_SIZE*position + HEAD_SIZE, STAT_Y + 10);

      fill(255-(health/100.0f)*255, (health/100.0f)*255, 0);
      rect(STAT_X + STAT_SIZE*position + HEAD_SIZE, STAT_Y + 30, health, 10);
      fill(255, 255, 255);
    } else {
      //dead head and name on stats bar
      image(head_dead, STAT_X + STAT_SIZE*position, STAT_Y);
      text(name, STAT_X + STAT_SIZE*position + HEAD_SIZE, STAT_Y + 10);
    }
  }

  int getHealth() {
    return health;
  }

  boolean fullHealth() {
    return health >= 100;
  }

  boolean noHealth() {
    return health <= 0;
  }

  boolean hurt() {
    health -= round(random(40, 60));

    if (health <= 0)
      return true;

    return false;
  }

  void heal() {
    health += round(random(20, 30));

    if (health > 100)
      health = 100;
  }
}