import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Obama_Trail extends PApplet {



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

public void setup() {
  //basic initialization
  
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

  questions.add(new Question("Welcome to OBAMA TRAIL!\n\n"+
                             "Make it to the end by responding to the\n"+
                             "situations just like Obama would. Good luck!\n\n"+
                             "Programming by Dan Yost. Writing by\n"+
                             "Kami Beckford, Myia Samuels, and Mateo\n"+
                             "Ginocchi.",
                             4, null, null, 0, 0));

  //1
  StringList slq_1 = new StringList();
  slq_1.append("Put tariffs in place to deter outsourcing.");
  slq_1.append("Put money aside as an economic stimulus.");
  slq_1.append("Put wage and price controls in place.");
  slq_1.append("Demand compensation from the banks responsible.");

  StringList slc_1 = new StringList();
  slc_1.append("FAIL-companies continue to stay overseas as it\n"+
               "is still cheaper.");
  slc_1.append("Good choice! Nicknamed \u201cThe Stimulus (2009)\u201d,\n"+
               "this $787 billion put-aside created 15.5 million\n"+
               "jobs.");
  slc_1.append("FAIL-Nixon tried this-it didn\u2019t work in 1971,\n"+
               "and he admitted it was a bad idea.");
  slc_1.append("FAIL-hurts the economy further and causes\n"+
               "negative media attention.");

  questions.add(new Question("The Recession of 2008 was the worst recession\n"+
                             "since the Great Depression. It is currently a\n"+
                             "key issue for the American people. You will...",
                             3, slq_1, slc_1, 2, 76));

  //2 (milestone)
  questions.add(new Question("MILESTONE: You are being heavily criticized by\n"+
                             "the media for causing an increase in national\n"+
                             "debt due to the deficit spending used to\n"+
                             "stimulate the economy. ",
                             4, null, null, 2, 152));

  //3
  StringList slq_3 = new StringList();
  slq_3.append("Let banks choose their agencies.");
  slq_3.append("Ask banks to join consumer protection services.");
  slq_3.append("Ban banks from using depositor money to trade.");
  slq_3.append("Do nothing.");

  StringList slc_3 = new StringList();
  slc_3.append("FAIL-allowing banks to pick who regulates them\n"+
               "creates loopholes.");
  slc_3.append("FAIL-recommendations don\u2019t work. Creating a CFPB\n"+
               "would\u2019ve.");
  slc_3.append("Good Choice! The Dodd-Frank Act (2010) did this,\n"+
               "called \u201cThe Volcker Rule\u201d, and improved\n"+
               "regulation in 8 other areas.");
  slc_3.append("FAIL-congratulations, your approval ratings are\n"+
               "actually negative.");

  questions.add(new Question("Also because of the 2008 Recession, the public\n"+
                             "is demanding change on Wall Street. You will...", 
                             2, slq_3, slc_3, 3, 228));

  //4
  StringList slq_4 = new StringList();
  slq_4.append("Propose an arms reduction treaty with Russia.");
  slq_4.append("Meet frequently with the Russian Federation.");
  slq_4.append("Ask Russia to agree to cut weapon production.");
  slq_4.append("Do nothing. (Still probably not a good idea.)");

  StringList slc_4 = new StringList();
  slc_4.append("Good choice! Obama chose to continue the START 1\n"+
              "Treaty with new START (2010), which reduced the\n"+
              "number of strategic nuclear missile launchers by\n"+
              "one half. It doesn't place a limit on stockpiled\n"+
              "nuclear weapons, though.");
  slc_4.append("FAIL-You can only have so many meetings.");
  slc_4.append("FAIL-Limits on weapon reduction prevents tech\n"+
              "advancements and hurts the economy.");
  slc_4.append("FAIL-You were murdered by the media.");

  questions.add(new Question("The American people fear threats from other\n"+
                             "countries, including Russia. You will...",
                             2, slq_4, slc_4, 1, 304));

  //5
  StringList slq_5 = new StringList();
  slq_5.append("Withdraw troops over 1 year.");
  slq_5.append("Withdraw troops over 6 years.");
  slq_5.append("Keep troops there for scheduled tours.");
  slq_5.append("Replace on ground action with drone strikes.");

  StringList slc_5 = new StringList();
  slc_5.append("Obama\u2019s Choice-(2010) although \u00be of Americans\n"+
               "supported him, this was one of the leading\n"+
               "causes of the budget deficit and troops were\n"+
               "back 3 years later after more ISIS threats.");
  slc_5.append("FAIL-though many say this would\u2019ve left more\n"+
               "stability and slowed growth of ISIS. So\n"+
               "you're right! But wrong. Sorry.");
  slc_5.append("FAIL-not popular among Americans, but may\n"+
               "have helped control ISIS.");
  slc_5.append("FAIL-drone strikes were increased later\n"+
               "against suspected terrorists, not to replace\n"+
               "troops");

  questions.add(new Question("People are saying that the soldiers need to be\n"+
                             "brought home. Others say that that will cause\n"+
                             "more chaos in Iraq. You will...",
                             3, slq_5, slc_5, 1, 380));

  //6
  questions.add(new Question("MILESTONE: Congratulations on a successful\n"+
                              "order to assassinate Osama Bin Laden (2011)!",
                              2, null, null, 0, 456));

  //7
  StringList slq_7 = new StringList();
  slq_7.append("Keep health care in private sectors.");
  slq_7.append("Create a form of universal healthcare.");
  slq_7.append("Provide tax incentives for drug companies.");
  slq_7.append("Change existing health insurance standards.");

  StringList slc_7 = new StringList();
  slc_7.append("FAIL-This is one of the failures of Obamacare-\n"+
               "people with private health insurance lost it\n"+
               "because it didn\u2019t cover ACA\u2019s essential benefit.");
  slc_7.append("Good choice! This is what Obama did with \n"+
               "Obamacare-he lowered healthcare costs and\n"+
               "covered 32 million uninsured Americans.");
  slc_7.append("FAIL- Working with pharmaceutical companies is\n"+
               "a mess.");
  slc_7.append("FAIL-That would most likely exclude more\n"+
               "Americans from getting coverage.");

  questions.add(new Question("People are calling for better health care.\n"+
                             "You will...", 
                             2, slq_7, slc_7, 2, 532));

  //8
  StringList slq_8 = new StringList();
  slq_8.append("Uphold it.");
  slq_8.append("Amend it.");
  slq_8.append("Repeal it.");
  slq_8.append("Replace it.");

  StringList slc_8 = new StringList();
  slc_8.append("FAIL-Lots and lots of backlash will ensue.");
  slc_8.append("FAIL-There is no way to make this regulation less\n"+
               "discriminatory.");
  slc_8.append("Good choice! (2011) Good on you for upholding\n"+
               "your campaign promises.");
  slc_8.append("FAIL-There is no alternative to this policy\n"+
               "except to repeal it.");

  questions.add(new Question("Many Americans dislike \u201cDon\u2019t Ask Don\u2019t Tell\u201d,\n"+
                             "which prohibits LGBT+ community members\n"+
                             "from openly serving in the army You will...\n",
                             3, slq_8, slc_8, 3, 608));

  //9
  questions.add(new Question("MILESTONE: Congratulations on being the first\n"+
                             "President to support same-sex marriage!",
                             2, null, null, 0, 684));

  //10
  //StringList slq_10 = new StringList();
  //slq_10.append("Draft a bill to reform the immigration system.");
  //slq_10.append("Issue an executive order.");
  //slq_10.append("Alter the process of becoming a U.S. citizen.");
  //slq_10.append("Change and retry the DREAM-Act in Congress.");

  //StringList slc_10 = new StringList();
  //slc_10.append("FAIL- It is very unlikely that Congress will be\n"+
  //              "able to settle on an agreement in a timely\n"+
  //              "manner, and it does not ensure that you will see\n"+
  //              "the changes you want.");
  //slc_10.append("Good choice! You created a policy called the\n"+
  //              "Deferred Action for Childhood Arrivals (DACA)\n"+
  //              "in June 2012.");
  //slc_10.append("FAIL- Changing the citizenship process will take\n"+
  //              "too much time, and may even cause more problems\n"+
  //              "before solving the initial problem you wanted\n"+
  //              "to find a solution to.");
  //slc_10.append("FAIL- After the bill has failed multiple times,\n"+
  //              "there is no point in trying to continue with\n"+
  //              "something that isn\u2019t going to work.");

  //questions.add(new Question("You want to enforce a policy that will lessen\n"+
  //                           "immigration enforcement from individuals who\n"+
  //                           "act as good citizens. You will...",
  //                           3, slq_10, slc_10, 2, 760));
  
  //11
  questions.add(new Question("MILESTONE: Congratulations! You\u2019ve just been\n"+
                             "re-elected!",
                             2, null, null, 0, 760));
                             
  //12
  StringList slq_12 = new StringList();
  slq_12.append("Draft a bill to reform US immigration system.");
  slq_12.append("Issue an executive order.");
  slq_12.append("Alter the process of becoming a U.S. citizen.");
  slq_12.append("Change and retry the DREAM-Act in Congress.");

  StringList slc_12 = new StringList();
  slc_12.append("FAIL- It is very unlikely that Congress will be\n"+
                "able to settle on an agreement in a timely\n"+
                "manner, and it does not ensure that you will see\n"+
                "the changes you want.");
  slc_12.append("Good choice! You created a policy called the\n"+
                "Deferred Action for Childhood Arrivals (DACA)\n"+
                "in June 2012.");
  slc_12.append("FAIL- Changing the citizenship process will take\n"+
                "too much time, and may even cause more problems\n"+
                "before solving the initial problem you wanted\n"+
                "to find a solution to.");
  slc_12.append("FAIL- After the bill has failed multiple times,\n"+
                "there is no point in trying to continue with\n"+
                "something that isn\u2019t going to work.");

  questions.add(new Question("You want to enforce a policy that will lessen\n"+
                             "immigration enforcement from individuals who\n"+
                             "act as good citizens. You will...",
                             3, slq_12, slc_12, 2, 836));
                             
  //13
  questions.add(new Question("MILESTONE: You successfully brokered a nuclear\n"+
                             "deal with Iran(2015)! Thanks to the deal, the\n"+
                             "UN has agreed to lift the trade sanctions it\n"+
                             "imposed on Iran in 2010 and they are now \n"+
                             "shipping out oil.",
                             5, null, null, 0, 912));

  questions.add(new Question("CONGRATULATIONS!\n\n"+
                             "You have successfully survived OBAMA TRAIL!\n\n"+
                             "You would make a great president!", 
                             2, null, null, 0, 1129));
}

public void draw() {
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

public void keyReleased() {
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

  public void drawPerson(int position, int time) {
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

  public void drawStats(int position) {
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

  public int getHealth() {
    return health;
  }

  public boolean fullHealth() {
    return health >= 100;
  }

  public boolean noHealth() {
    return health <= 0;
  }

  public boolean hurt() {
    health -= round(random(40, 60));

    if (health <= 0)
      return true;

    return false;
  }

  public void heal() {
    health += round(random(20, 30));

    if (health > 100)
      health = 100;
  }
}
final int QSTN_X = 10;
final int QSTN_Y = 310;

final int QSTN_STEP = 21;
final int QSTN_LINE = 20;

AudioSample select, good, bad;

class Question {
  String main_text;
  int main_text_lines;

  StringList options;
  StringList consequences;

  int answer;

  int time;

  Question(String main_text, int main_text_lines, 
    StringList options, StringList consequences, int answer, int time) {
    this.main_text = main_text;
    this.main_text_lines = main_text_lines;

    this.options = options;

    this.consequences = consequences;

    this.answer = answer;

    this.time = time;
  }

  public void draw() {
    text(main_text, QSTN_X, QSTN_Y);

    if (options == null)
      return;

    for (int i = 0; i < options.size(); i++) {
      if (options.get(i) != "") 
        text((i+1)+")"+options.get(i), QSTN_X+5, QSTN_Y + QSTN_LINE*main_text_lines + QSTN_STEP*(i+1));
    }
  }

  public boolean noOptions() {
    return options == null;
  }

  public boolean noConsequences() {
    return consequences == null;
  }

  public boolean timeHit(int game_time) {
    return game_time >= time;
  }

  public boolean respond(int response, Person obama, Person biden) {
    //if just a message, allow game to progress
    if (noOptions() || noConsequences()) {
      select.trigger();
      return true;
    }

    //if an option needs picking, ensure response is a valid choice
    if (response < 1 || response > options.size())
      return false;

    //display the consequence for the response
    main_text = consequences.get(response-1);
    options = null;

    //if answer was correct, heal lowest person
    if (response == answer) {
      good.trigger();

      //heal the lowest person
      if (obama.getHealth() < biden.getHealth() && !obama.noHealth()) {
        main_text += "\nOBAMA";
        obama.heal();
      } else if (!biden.noHealth()) {
        main_text += "\nBIDEN";
        biden.heal();
      } else if (!obama.noHealth()) {
        main_text += "\nOBAMA";
        obama.heal();
      }

      main_text += " gains health!";
    }
    //if answer was wrong, hurt random person
    else {
      bad.trigger();

      boolean dead = false;

      if (!obama.noHealth() && !biden.noHealth()) {
        if (random(100) < 50) {
          main_text += "\nOBAMA";
          dead = obama.hurt();
        } else {
          main_text += "\nBIDEN";
          dead = biden.hurt();
        }
      } else if (obama.noHealth()) {
        main_text += "\nBIDEN";
        dead = biden.hurt();
      } else if (biden.noHealth()) {
        main_text += "\nOBAMA";
        dead = obama.hurt();
      }

      if (dead) {
        main_text += " is knocked out!";

        if (obama.getHealth() <= 0 && biden.getHealth() <= 0)
          main_text += "\n\nGAME OVER!";
      } else {
        main_text += " takes damage!";
      }
    }

    return false;
  }
};
  public void settings() {  size(700, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Obama_Trail" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
