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

  void draw() {
    text(main_text, QSTN_X, QSTN_Y);

    if (options == null)
      return;

    for (int i = 0; i < options.size(); i++) {
      if (options.get(i) != "") 
        text((i+1)+")"+options.get(i), QSTN_X+5, QSTN_Y + QSTN_LINE*main_text_lines + QSTN_STEP*(i+1));
    }
  }

  boolean noOptions() {
    return options == null;
  }

  boolean noConsequences() {
    return consequences == null;
  }

  boolean timeHit(int game_time) {
    return game_time >= time;
  }

  boolean respond(int response, Person obama, Person biden) {
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