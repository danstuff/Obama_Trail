import ddf.minim.*;

PFont font_body;
PFont font_head;

PImage background;

Person obama, biden;

ArrayList<Question> questions;

int next;

int game_time;
boolean moving;

Minim minim;
AudioSample encounter;

void setup() {
  //basic initialization
  size(700, 500);
  noStroke();
  
  randomSeed(0);

  next = 0;

  game_time = 0;
  moving = true;

  //sound loading
  minim = new Minim(this);

  select = minim.loadSample("select.wav");
  good = minim.loadSample("good.wav");
  bad = minim.loadSample("bad.wav");
  
  walk = minim.loadSample("walk.wav");
  
  encounter = minim.loadSample("encounter.wav");

  //background loading 
  background  = loadImage("background.png");

  //font loading 
  font_body = createFont("body.ttf", 16);
  font_head = createFont("head.ttf", 44);

  //person loading
  obama = new Person("OBAMA", 
    "obama_body1.png", "obama_body2.png", 
    "obama_body1.png", 
    "obama_head.png", "obama_head_dead.png");

  biden = new Person("BIDEN", 
    "biden_body1.png", "biden_body2.png", 
    "biden_body1.png", 
    "biden_head.png", "biden_head_dead.png");

  //question loading  
  questions = new ArrayList<Question>();

  questions.add(new Question("Welcome to OBAMA TRAIL!", 1, null, null, 0, 0));

  StringList slq_1 = new StringList();
  slq_1.append("1");
  slq_1.append("2");
  slq_1.append("3");

  StringList slc_1 = new StringList();
  slc_1.append("1");
  slc_1.append("2");
  slc_1.append("3");

  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 100));
  
  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 120));
  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 140));  
  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 160));
  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 180));
  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 200));  
  questions.add(new Question("An encounter!", 1, slq_1, slc_1, 1, 220));

  questions.add(new Question("CONGRATULATIONS! You have successfully completed\nOBAMA TRAIL!", 1, null, null, 0, 1129));
}

void draw() {
  if (moving)
    game_time++;

  background(0);

  textFont(font_body);
  textAlign(LEFT, TOP);

  //draw background
  image(background, 700-background.width+game_time, 0);

  //draw people
  obama.drawPerson(0, game_time);
  biden.drawPerson(1, game_time);

  //draw stats
  fill(255, 255, 255);

  obama.drawStats(0);
  biden.drawStats(1);

  //draw white info box
  fill(255, 255, 255);

  rect(0, 300, 1000, 172);

  //draw current question
  if (questions.get(next).timeHit(game_time)) {
    if (moving == true) {
      encounter.trigger();
      moving = false;
    }

    fill(0, 0, 0);

    questions.get(next).draw();
  }

  //draw instructions at bottom
  fill(255, 255, 255);

  if (!moving) {
    if (questions.get(next).noOptions())
      text("Press any key to continue", 8, 480);
    else
      text("Press a number key to select an option", 8, 480);
  }

  //draw title at top
  fill(255, 255, 255);

  textFont(font_head);
  textAlign(CENTER, TOP);
  text("-OBAMA TRAIL-", 350, 0);
}

void keyReleased() {
  if (!moving) {
    if (questions.get(next).respond(key-48, obama, biden)) {
      next++;
      moving = true;

      //if out of questions, quit the game
      if (next >= questions.size() || match(questions.get(next-1).main_text, "GAME OVER") != null) {
        exit();
      }
    }
  }
}