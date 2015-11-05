

PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2;

void setup () {
  size(640,480) ;
  bg1 = loadImage ("img/bg1.png");
  bg2 = loadImage ("img/bg2.png");
  enemy = loadImage ("img/enemy.png");
  fighter = loadImage ("img/fighter.png");
  hp = loadImage ("img/hp.png");
  treasure = loadImage ("img/treasure.png");
  end1 = loadImage ("img/end1.png");
  end2 = loadImage ("img/end2.png");
  start1 = loadImage ("img/start1.png");
  start2 = loadImage ("img/start2.png");
}

boolean gameState = false;
boolean endState = false;
boolean startFlash = false;
boolean endFlash = false;
boolean upState = false;
boolean downState = false;
boolean leftState = false;
boolean rightState = false;
int heroSpeed = 10;
int bg1Pos = 640;
int bg2Pos = 0;
int enemyWave = 0;
int score = -1;
int startBuffer = 0;
int endBuffer = 0;
float heroPosX = 550;
float heroPosY = 240;
float enemyPosX, enemyPosY;
float enemyLeadPosX = 0;
float enemyLeadPosY;
float hpAmount = 195;
float hpPercentage = 0.2;
float treasurePosX = random(40,560);
float treasurePosY = random(60,420);

void draw() {
  if(gameState==false){
    if(endState==true){
      if(mouseX <= 436 && mouseX >= 206 && mouseY <= 355 && mouseY >= 308){
        image(end1, 0, 0);
        endFlash = true;
      }else{
        image(end2, 0, 0);
        endFlash = false;
      }
    }else{
      if(mouseX <= 449 && mouseX >= 198 && mouseY <= 414 && mouseY >= 376){
        image(start1, 0, 0);
        startFlash = true;
      }else{
        image(start2, 0, 0);
        startFlash = false;
      }
    }
  }else{
    image(bg1,-640+bg1Pos,0);
    image(bg2,-640+bg2Pos,0);
    bg1Pos += 10;
    bg1Pos = bg1Pos % 1280;
    bg2Pos += 10;
    bg2Pos = bg2Pos % 1280; //background scrolling
    fill(255,0,0);
    noStroke();
    image(treasure, treasurePosX, treasurePosY); //treasure
    if(upState == true && heroPosY>0){
      heroPosY -= heroSpeed;
    }
    if(downState == true && heroPosY<429){
      heroPosY += heroSpeed;
    }
    if(leftState == true && heroPosX>0){
      heroPosX -= heroSpeed;
    }
    if(rightState == true && heroPosX<589){
      heroPosX += heroSpeed;
    }
    image(fighter, heroPosX, heroPosY); // fighter position
    if(heroPosX + 51 >= treasurePosX && heroPosX <= treasurePosX + 41 && heroPosY + 51 >= treasurePosY && heroPosY <= treasurePosY + 41){
      if(hpPercentage < 0.99){
        hpPercentage += 0.1;
        treasurePosX = random(40,560);
        treasurePosY = random(60,420);
      }
    }
    if(enemyLeadPosX <= 6){
      enemyWave ++;
      if(enemyWave > 3){
        enemyWave = 1;
      }
      if(enemyWave == 1){
        enemyLeadPosY = random(60,420);
      }else if(enemyWave == 2){
        enemyLeadPosY = random(60,180);
      }else if(enemyWave == 3){
        enemyLeadPosY = random(60,300);
      }
      score += 1;
    }
    enemyPosY = enemyLeadPosY;
    switch(enemyWave){
      case 1:
        for(int enemyJux = 1; enemyJux <= 5; enemyJux ++){
          pushMatrix();
          translate(-100+enemyPosX, enemyPosY);
          image(enemy, 0, 0); 
          /**
          if(heroPosX + 51 >= enemyPosX - 100 && heroPosX <= enemyPosX -39 && heroPosY + 51 >= enemyPosY && heroPosY <= enemyPosY + 61){
            if(hpPercentage > 0.21){
              hpPercentage -= 0.2;
              enemyPosX = 0;
              score -= 1;
              println("CRASH");
            }else{
              gameState=false;
              endState=true;
            }
          }
          **/
          enemyPosX -= 60;
          popMatrix();
        }
        break;
      case 2:
        for(int enemyJux = 1; enemyJux <= 5; enemyJux ++){
          pushMatrix();
          translate(-100+enemyPosX, enemyPosY);
          image(enemy, 0, 0); 
          /**
          if(heroPosX + 51 >= enemyPosX - 100 && heroPosX <= enemyPosX -39 && heroPosY + 51 >= enemyPosY && heroPosY <= enemyPosY + 61){
            if(hpPercentage > 0.21){
              hpPercentage -= 0.2;
              enemyPosX = 0;
              score -= 1;
              println("CRASH");
            }else{
              gameState=false;
              endState=true;
            }
          }
          **/
          enemyPosX -= 60;
          enemyPosY += 60;
          popMatrix();
        }
        break;
      case 3:
        for(int enemyJuxA = 1; enemyJuxA <= 3; enemyJuxA ++){
          for(int enemyJuxB = 1; enemyJuxB <= 3; enemyJuxB ++){
            pushMatrix();
            translate(-100+enemyPosX, enemyPosY);
            if(enemyJuxA != 2 || enemyJuxB != 2){
              image(enemy, 0, 0); 
            }
            /**
            if(heroPosX + 51 >= enemyPosX - 100 && heroPosX <= enemyPosX -39 && heroPosY + 51 >= enemyPosY && heroPosY <= enemyPosY + 61){
              if(hpPercentage > 0.21){
                hpPercentage -= 0.2;
                enemyPosX = 0;
                score -= 1;
                println("CRASH");
              }else{
                gameState=false;
                endState=true;
              }
            }
            **/
            enemyPosX -= 60;
            enemyPosY += 60;
            popMatrix();
          }
          enemyPosX = enemyLeadPosX - 60 * enemyJuxA;
          enemyPosY = enemyLeadPosY - 60 * enemyJuxA;
        }

        break;
    }
    enemyPosX = enemyLeadPosX;
    enemyLeadPosX += 7;
    enemyLeadPosX %= 1200;
    //println(enemyLeadPosX);
    //println(enemyLeadPosY);
    rect(50,34,hpAmount*hpPercentage,17); //hp amount
    image(hp, 40, 30); //hp outline
  }
}

void mousePressed(){
    if(endFlash){
        endState = false;
        hpPercentage = 0.2;
        enemyLeadPosX = 0;
        enemyPosX = 0;
        enemyPosY = 0;
        heroPosX = 550;
        heroPosY = 240;
        treasurePosX = random(40,560);
        treasurePosY = random(60,420);
        score = -1;
        endFlash = false;
        enemyWave = 0;
      }
    if(startFlash){
        gameState = true;
        startFlash = false;
      }
}


void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upState = true;
        break;
      case DOWN:
        downState = true;
        break;
      case LEFT:
        leftState = true;
        break;
      case RIGHT:
        rightState = true;
        break;
    }
  }
}

void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upState = false;
        break;
      case DOWN:
        downState = false;
        break;
      case LEFT:
        leftState = false;
        break;
      case RIGHT:
        rightState = false;
        break;
    }
  }
}
