import random

def npcchoice():
    """
    The computer randomly selects rock, paper, or scissors.
    """
    choicenum = random.randint(1,3)
    if choicenum == 1:
        choice = "rock"
    elif choicenum == 2:
        choice = "paper"
    else:
        choice = "scissors"
    return choice

def winner(p1, npc):
    """
    Determine the winner based on the rules:
    -Rock crushes Scissors
    -Scissors cuts Paper
    -Paper covers Rock

    Only valid inputs both in p1 and npc are "rock", "paper", or "scissors".
    """
    if p1 == "rock":
        if npc == "paper":
            print(f"Computer chose Paper. \n Paper covers Rock \n Computer wins!")
            return False
        else:
            print(f"Computer chose Scissors. \n Rock crushes Scissors \n You win!")
            return True
    elif p1 == "paper":
        if npc == "rock":
            print(f"Computer chose Rock. \n Paper covers Rock \n You win!")
            return True
        else:
            print(f"Computer chose Scissors. \n Scissors cuts Paper \n Computer wins!")
            return False
    else:
        if npc == "rock":
            print(f"Computer chose Rock. \n Rock crushes Scissors \n Computer wins!")
            return False
        else:
            print(f"Computer chose Paper. \n Scissors cuts Paper \n You win!")
            return True