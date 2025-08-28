import functions as f
import streamlit as st

def main():
    """
    Rock, Paper, Scissors game.

    The user is asked to choose one of the three options, the computer chooses one at random, and the program finds who the winner is.

    Scores are kept in a dictionary, and player can keep playing as long as they want.
    """
    st.title("Rock, Paper, Scissors")
    st.header("Let's play!")

    if "player_score" not in st.session_state:
        st.session_state.player_score = 0
        st.session_state.computer_score = 0
        st.session_state.round = 1

    name = st.text_input("Please enter your name")

    if st.button("Submit name"):
        st.write(f"Hello {name}, let's get things started.")
    
    first_to = st.number_input("Choose the number of rounds the winner has to win", min_value=1, step=1)

    st.write(f"Round: {st.session_state.round}")

    p1 = st.selectbox("Rock, Papers, or Scissors?", ["rock", "paper", "scissors"])
    if st.button("Play round"):
        npc = f.npcchoice()
        st.write(f"You chose {p1}, computer chose {npc}")

        if p1 == npc:
            st.write(f"That's a tie! Your score: {st.session_state.player_score}, computer score: {st.session_state.computer_score}")
        else:
            win = f.winner(p1, npc)
            if win == True:
                st.session_state.player_score += 1
                st.write(f"You win the round! Your score: {st.session_state.player_score}, computer score: {st.session_state.computer_score}")
            else:
                st.session_state.computer_score += 1
                st.write(f"You loose :( Your score: {st.session_state.player_score}, computer score: {st.session_state.computer_score}")

    if st.session_state.computer_score == first_to:
        st.write("The computer won! GAME OVER D: ")
        st.session_state.player_score = 0
        st.session_state.computer_score = 0
    elif st.session_state.player_score == first_to:
        st.write("You win, CONGRATS! :D ")
        st.session_state.player_score = 0
        st.session_state.computer_score = 0

if __name__ == '__main__':
    main()