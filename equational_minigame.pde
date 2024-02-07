int num1, num2, result;
char operator;
String userAnswer = "";
int countdownTime = 6;
int startTime;
boolean gameStarted = false;
int timerDuration = 5; 
int correctCount = 0;
int maxCorrect = 20;
int incorrectCount = 0;
int maxIncorrect = 3;
boolean gameOver = false;
int lastdecrementTime = 0;
int score = 0; // New variable for the player's score

void setup() {
  size(1366, 768);
  generateEquation();
  startTime = second();
}

void draw() {
  background(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(0);
  
  if (!gameStarted) {
    // Display the countdown
    if (second() - startTime > countdownTime) {
      gameStarted = true;
      generateEquation();
      startTime = second();
    } else {
      int remainingTime = countdownTime - int((second() - startTime));
      text(remainingTime, width / 2, height / 2);
    }
  } else {
    // Game is running
    if (!gameOver) {
      // Display the score in the top left corner
      textSize(32);
      text("Score: " + score, 70, 23); // Adjusted position
      
      textSize(48);
      text(num1 + " " + operator + " " + num2 + " =", width/2, height/2 - 20);
      text(userAnswer, width/2, height/2 + 20);

      // Calculate remaining time
      int elapsedTime = second() - startTime;
      int remainingTime = max(0, timerDuration - elapsedTime);
      
      // Display the timer
      int seconds = remainingTime;
      textSize(31);
      text("Time: " + seconds + "s", width - 80, 20);

      // Check if time is up
      if (remainingTime == 0) {
        gameOver = true;
      }
    } else {
      if (correctCount >= maxCorrect) {
              textSize(32);
      text("Score: " + score, 70, 23);
        text("You Win! You are more prepared!", width/2, height/2 - 20);
        textSize(26);
        text("Press 'R' to restart", width/2, height/2 + 20);
      } else {
              textSize(32);
      text("Score: " + score, 70, 23);
        text("Game Over, You need time to prepare.", width/2, height/2 - 20);
        textSize(26);
        text("Press 'R' to restart", width/2, height/2 + 20);
      }
    }
  }
  
  // When the countdown is over, the game starts.
  if (!gameStarted && second() - startTime > countdownTime) {
    gameStarted = true;
    generateEquation();
    startTime = second();
  }
}

void keyPressed() {
  // When you press backspace, it deletes any number that has been typed
  if (!gameOver) {
    if (key == BACKSPACE && userAnswer.length() > 0) {
      userAnswer = userAnswer.substring(0, userAnswer.length() - 1);
    } 
    
    // Enables you to press any number value 1-9 into your answer
    else if ((key >= '0' && key <= '9') || key == '-') {
      userAnswer += key;
    } 
    
    // When you press the enter button it will check whether the answer is correct and
    // generate a new equation for you to solve regardless of whether it's correct or not
    else if (key == ENTER || key == RETURN) {
      checkAnswer();
      generateEquation();
      userAnswer = "";
      startTime = second(); // Reset the timer
    }
  } 
  
  // When you press R, the game restarts
  else {
    if (key == 'R' || key == 'r') {
      restartGame();
    }
  }
}

void generateEquation() {
  num1 = int(random(1, 10));
  num2 = int(random(1, 10));
  int operation = int(random(3)); // 0: addition, 1: subtraction, 2: multiplication
  
  switch (operation) {
    case 0:
      operator = '+';
      result = num1 + num2;
      break;
    case 1:
      operator = '-';
      result = num1 - num2;
      break;
    case 2:
      operator = '*';
      result = num1 * num2;
      break;
  }
}

void checkAnswer() {
  int userGuess = int(userAnswer);
  if (userGuess == result) {
    correctCount++;
    score += 1; // Increase the score for each correct answer
    
    // Check if reached max correct answers
    if (correctCount >= maxCorrect) {
      gameOver = true;
    }
  } else {
    incorrectCount++;
    
    // Check if reached max incorrect answers
    if (incorrectCount >= maxIncorrect) {
      gameOver = true;
    }
  }
}

// Resets every value of the minigame
void restartGame() {
  gameOver = false;
  generateEquation();
  userAnswer = "";
  startTime = second();
  correctCount = 0;
  incorrectCount = 0;
  score = 0; // Reset the score
}
