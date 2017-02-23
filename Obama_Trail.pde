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

  questions.add(new Question("Welcome to OBAMA TRAIL!\n\n"+
                             "Make it to the end by responding to the\n"+
                             "situations just like Obama would.\n\n"+
                             "Good luck!",
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
  slc_1.append("Good choice! Nicknamed “The Stimulus (2009)”,\n"+
               "this $787 billion put-aside created 15.5 million\n"+
               "jobs.");
  slc_1.append("FAIL-Nixon tried this-it didn’t work in 1971,\n"+
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
  slc_3.append("FAIL-recommendations don’t work. Creating a CFPB\n"+
               "would’ve.");
  slc_3.append("Good Choice! The Dodd-Frank Act (2010) did this,\n"+
               "called “The Volcker Rule”, and improved\n"+
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
  slc_5.append("Obama’s Choice-(2010) although ¾ of Americans\n"+
               "supported him, this was one of the leading\n"+
               "causes of the budget deficit and troops were\n"+
               "back 3 years later after more ISIS threats.");
  slc_5.append("FAIL-though many say this would’ve left more\n"+
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
               "because it didn’t cover ACA’s essential benefit.");
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

  questions.add(new Question("Many Americans dislike “Don’t Ask Don’t Tell”,\n"+
                             "which prohibits LGBT+ community members\n"+
                             "from openly serving in the army You will...\n",
                             3, slq_8, slc_8, 3, 608));

  //9
  questions.add(new Question("MILESTONE: Congratulations on being the first\n"+
                             "President to support same-sex marriage!",
                             2, null, null, 0, 684));

  //10
  StringList slq_10 = new StringList();
  slq_10.append("Draft a bill to reform the immigration system.");
  slq_10.append("Issue an executive order.");
  slq_10.append("Alter the process of becoming a U.S. citizen.");
  slq_10.append("Change and retry the DREAM-Act in Congress.");

  StringList slc_10 = new StringList();
  slc_10.append("FAIL- It is very unlikely that Congress will be\n"+
                "able to settle on an agreement in a timely\n"+
                "manner, and it does not ensure that you will see\n"+
                "the changes you want.");
  slc_10.append("Good choice! You created a policy called the\n"+
                "Deferred Action for Childhood Arrivals (DACA)\n"+
                "in June 2012.");
  slc_10.append("FAIL- Changing the citizenship process will take\n"+
                "too much time, and may even cause more problems\n"+
                "before solving the initial problem you wanted\n"+
                "to find a solution to.");
  slc_10.append("FAIL- After the bill has failed multiple times,\n"+
                "there is no point in trying to continue with\n"+
                "something that isn’t going to work.");

  questions.add(new Question("You want to enforce a policy that will lessen\n"+
                             "immigration enforcement from individuals who\n"+
                             "act as good citizens. You will...",
                             3, slq_10, slc_10, 2, 760));
  
  //11
  questions.add(new Question("MILESTONE: Congratulations! You’ve just been\n"+
                             "re-elected!",
                             2, null, null, 0, 836));
                             
  //12
  StringList slq_12 = new StringList();
  slq_12.append("Draft a bill to reform the US immigration system.");
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
                "something that isn’t going to work.");

  questions.add(new Question("You want to enforce a policy that will lessen\n"+
                             "immigration enforcement from individuals who\n"+
                             "act as good citizens. You will...",
                             3, slq_12, slc_12, 2, 912));
                             
  //13
  questions.add(new Question("MILESTONE: You successfully brokered a nuclear\n"+
                             "deal with Iran(2015)! Thanks to the deal, the\n"+
                             "UN has agreed to lift the trade sanctions it\n"+
                             "imposed on Iran in 2010 and they are now \n"+
                             "shipping out oil.",
                             5, null, null, 0, 988));

  questions.add(new Question("CONGRATULATIONS!\n\n"+
                             "You have successfully survived OBAMA TRAIL!\n\n"+
                             "You would make a great president!", 
                             2, null, null, 0, 1129));
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