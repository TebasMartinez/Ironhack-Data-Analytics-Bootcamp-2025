import random

def main():
    
    """
        X
       /|\ 
        |
       / \ 
       
    """
    
    print("""
    
    Welcome to Hangman! 
    
    Computer has randomly generated a word, you have to guess letter by letter what the generated word is.
    Every time you guess a letter, you are given the opportunity to guess the word.
    You win if you guess the word, or all the letters in the word.
    If you try to guess and fail, someone might get hurt.
    
    Guess correctly and no one will be hurt :)
    
    Guess incorrectly 5 times and someone will likely get hurt.
    """)
    word = new_word()
    searchable_word = searchify_word(word)
    userlives = 5
    guessed = False
    p1_guess = generate_empty_guess(word)
    while True:
        if userlives > 0:
            guessed, p1_guess = guess_letter(searchable_word, p1_guess)
        if guessed == False and userlives > 0:
            userlives = wrong_guess(userlives, p1_guess)
        elif "".join(p1_guess) == word: # player wins 
            playerwins(word)
            return
        elif userlives == 0: # player loses
            print(f"You have {userlives} opportunities left. You LOSE. He loses more. \n\n The word was {word}")
            printhangman(userlives)
            break
        else: # player guessed a letter but hasn't won yet
            print(f"{userlives} opportunities left")
            while True: # ask the player if they would like to guess the word
                finalguess = input("Do you want to try to guess the word or keep with letters? (word/letter)")
                if finalguess == "word":
                    wordguess = input("Guess the word (in lower cases): ")
                    if wordguess == word:
                        playerwins(word)
                        return
                    else:
                        userlives = wrong_guess(userlives, p1_guess)
                        print("That wasn't the right word. Someone is kinda getting hurt...")
                        guessed = False
                        break
                elif finalguess == "letter":
                    guessed = False
                    break

def generate_empty_guess(word):
    """
    Generates empty guess board, a list of as many _ as letters has the word chosen by the computer.
    """
    emptyguess = []
    for letter in word:
        emptyguess.append("_")
    return emptyguess

def guess_letter(wordtplst, p1_guess):
    """
    Asks the user for a letter and checks if the letter is in the computer-chosen word
    """
    while True:
        guessed = False
        p1letter = input("What's your guess? (write a single letter in low cases) ")
        if len(p1letter) == 1 and p1letter.isalpha():
            p1letter = p1letter.lower()
            for lettertpl in wordtplst:
                if p1letter == lettertpl[1]:
                    p1_guess[lettertpl[0]] = p1letter
                    guessed = True
            if guessed == True:
                print(f"You found a letter! :) \n Current progress: {p1_guess}")
                return True, p1_guess
            else:
                print(f"The letter {p1letter} is not in the answer... ")
                return False, p1_guess
        else:
            print(f"You didn't provide a valid input, don't try to cheat! \n")

def new_word():
    """
    Chooses a random word from a given list. All words are all lower cases.
    """
    f = open("words.txt", "r")
    wordlist = f.read().split("\n")
    word = random.choice(wordlist)
    return word

def searchify_word(word):
    """
    Returns the word as a list of tuples where each tuple[0] is the index and each tuple[1] is the letter. 
    E.g:
    for twelfth
    returns [(0, 't'), (1, 'w'), (2, 'e'), (3, 'l'), (4, 'f'), (5, 't'), (6, 'h')]
    """
    wordlst = []
    for index,letter in enumerate(word):
        wordlst.append((index, letter))
    return wordlst

def wrong_guess(userlives, p1_guess):
    userlives -= 1
    if userlives > 0:
        printhangman(userlives)
        print(f"You have {userlives} opportunities left")
        print(f"Current progress: {p1_guess}")
    return userlives

def printhangman(userlives):
    if userlives == 4:
        print(f"""
               |------|
               |      |      ---------------------
               |      O -----| Excuse me!        | 
               |             | What's going on!? |
               |             | HELP ME!!         |
               |             ---------------------
              ___     
                  """)
    elif userlives == 3:
        print(f"""
               |------|
               |      |      ---------------------
               |      O -----| Ok, listen here.  | 
               |     /|      | You need to focus.|
               |             | PLEASE!!          |
               |             ---------------------
              ___     
                  """)
    elif userlives == 2:
        print(f"""
               |------|
               |      |      -------------------------
               |      O -----| No preasure, mate,    | 
               |     /|\     | but I'm kinda hanging |
               |             | on a thread here.     |
               |             -------------------------
              ___     
                  """)
    elif userlives == 1:
        print(f"""
               |------|
               |      |      -----------------------
               |      O -----| Omg just check a    | 
               |     /|\     | dictionary or       |
               |      |      | something.          |
               |             -----------------------
              ___     
                  """)
    elif userlives == 0:
        print(f"""
               |------|
               |      |      ------------
               |      X -----|   ...    | 
               |     /|\     ------------
               |      |      
               |     / \        
              ___     
                  """)
        
def playerwins(word):
    print(f"""Congratulations!
        You guessed the word: {word}

       !!!!!! YOU WIN !!!!!!
                  
                         ---------------
                     O --| Thanks for  | 
                    /|\  | saving me!! |
                     |   ---------------  
                     |
                    / \ 
                  """)
    
main()