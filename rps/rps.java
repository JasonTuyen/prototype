import java.util.*;

public class RPS{
   public static void main(String[] args){
      Scanner console = new Scanner(System.in);
      int play = 1; //This variable helps the while loop play the game again
      while(play>0){
         play();
         System.out.print("Do you want to play again? ");
         String again = console.next();
         if(again.equalsIgnoreCase("yes")){
            System.out.println();
         }else {
            System.out.println("GOOD BYE. COME BACK SOON");
            play = -1; //Changes value of play to end the while loop     
         }
         console.close();
      }
   }
   
   //this method prints the description of the program
   public static void description(){
      System.out.println("Using this app you can play Rock-Paper-Scissors game against the computer. When played between");
      System.out.println("two people, each person picks one of the three options at the same time, and the winner");
      System.out.println("is determined. The program should randomly choose one of the three options, then prompt for the");
      System.out.println("user's selection. At that point, the program reveals both choices and print a");
      System.out.println("statement indication ig the user won, the computer won, or if it was a tie. Continue playing until the");
      System.out.println("user choses to stop. Then print the total number of the games played, total wins, total losses, and");
      System.out.println("total ties.");
   }
   
   //this method let's the computer randomly choose a hand
   public static String getComputerChoice(Random rand){
      int signal = rand.nextInt(3);
      String computerHand = "";
      switch (signal){
         case 0:
            computerHand = "rock";
            break;
         case 1:
            computerHand = "paper";
            break;
         case 2:
            computerHand = "Scissors";
            break;
      }
      return computerHand;
   }
   
   //this method gets the user's hand and returns the hand
   public static String getUserChoice(Scanner console){
      System.out.println("your choices");
      System.out.println("Rock");
      System.out.println("Paper");
      System.out.println("Scissors");
      System.out.println("stop");
      System.out.print("Enter your choice: ");
      String playerHand = console.next();
      
      //How could I make this while loop easier?
      while(!(playerHand.equalsIgnoreCase("rock") || playerHand.equalsIgnoreCase("paper") || playerHand.equalsIgnoreCase("scissors") || playerHand.equalsIgnoreCase("stop"))){
         //This would be nicer to look at: System.out.print("Input invaild, enter your choice:");
         System.out.println("your choices");
         System.out.println("Rock");
         System.out.println("Paper");
         System.out.println("Scissors");
         System.out.println("stop");
         System.out.print("Enter your choice: ");
         playerHand = console.next();
      }
      
      //This if statement determines the player's hand
      if(playerHand.equalsIgnoreCase("rock")){
         playerHand = "ROCK";
         return playerHand;
      }else if(playerHand.equalsIgnoreCase("paper")){
         playerHand = "PAPER";
         return playerHand;
      }else if(playerHand.equalsIgnoreCase("scissors")){
         playerHand = "SCISSORS";
         return playerHand;
      }else if(playerHand.equalsIgnoreCase("stop")){
         return playerHand;
      }
      return playerHand;
   }
   
   //This method plays the game, how can I make this method do less?
   public static void play(){
      Random rand = new Random();
      Scanner console = new Scanner(System.in);
      description();
      System.out.println();
      System.out.println("Ready, Set, Go");
      System.out.println();
      int start = 0;    //This starts the while loop
      int count = 0; int win = 0; int lose = 0; int tie = 0;      //Initializes counters for final results
      String finalResult = "";      //Initialized to see who wins in the end 
      
      //This while loop lets the player keep playing until "stop" is typed.
      while(start >= 0){
         String computerHand = getComputerChoice(rand);
         String playerHand = getUserChoice(console);
         
         //This if statements ends the while loop
         if(playerHand.equalsIgnoreCase("stop")){
            break;
         }
         
         System.out.println(); 
         System.out.println("Computer selected: " + computerHand);
         System.out.println("You selected: " + playerHand.toUpperCase());
         System.out.println();
         String result = "";     //Initialized to see who wins the round
         
         //This if/else and switch statments/cases determines who won the round
         if(playerHand.equalsIgnoreCase(computerHand)){
            result = "There is a tie";
            tie++;
         }else {
            switch (playerHand){
               case "ROCK":
                  if(computerHand.equalsIgnoreCase("paper")){
                     result = "Oh no, you lost!";
                     lose++;
                  }else if (computerHand.equalsIgnoreCase("Scissors")){
                     result = "Hurray! You won!";
                     win++;
                  }
                  break;
               
               case "PAPER":
                  if(computerHand.equalsIgnoreCase("Scissors")){
                     result = "Oh no, you lost!";
                     lose++;
                  } else if (computerHand.equalsIgnoreCase("rock")){
                     result = "Hurray! You won.";
                     win++;
                  }
                  break;
                  
               case "SCISSORS":
                  if(computerHand.equalsIgnoreCase("rock")){
                     result = "Oh no, you lost!";
                     lose++;
                  }else if (computerHand.equalsIgnoreCase("paper")){
                     result = "Hurray! You won.";
                     win++;
                  }
                  break;
            }
         }
         System.out.println(result);
         count++;
      }
      for(int i = 1; i <= 29; i++){
         System.out.print("-");
      }
      System.out.println();
      System.out.println("Here is the result of the play:");
      System.out.println("Times played: " + count);
      System.out.println("Wins: " + win);
      System.out.println("Losses: " + lose);
      System.out.println("Ties: " + tie);
      
      //This if statment determines who wins the total game
      if(win > lose){
         finalResult = "Congratulations! You won.";
      }else if (win < lose){
         finalResult = "Sorry computer won this time. Try again";
      }else{
         finalResult = "Tied.";
      }
      
      System.out.println(finalResult);
      System.out.println();
      for(int i = 1; i <= 29; i++){
         System.out.print("-");
      }
      System.out.println(); 
   }
}
