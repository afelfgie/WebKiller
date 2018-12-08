#! /usr/bin/python

#Author : GunadiCBR & afel
#Date   : 30-09-2018
#Team   : Mls18hckr
#Github : https://github.com/afelfgie

import curses
from curses import KEY_RIGHT, KEY_LEFT, KEY_UP, KEY_DOWN
import random
from random import randrange, randint

def printRobot(win, pos_x, pos_y, size):
    ''' Prints the Robot '''
    for i in range(size):
        for j in range(size):
            win.addch(pos_y + i, pos_x + j, 'X')

def printDefuses(win, defuses):
    ''' Print the defuse codes '''
    for i in defuses:
        win.addch(i[0], i[1], '#')

def printBomb(win, bombPos):
    ''' Prints the bomb '''
    win.addch(bombPos[0], bombPos[1], '*')
    
def checkDefuse(pos_x, pos_y, size, defuses):
    ''' Checks if the Robot has collected a defuse code '''
    for d in defuses:
        if d[0] < pos_y + size and d[0] >= pos_y and d[1] < pos_x + size and d[1] >= pos_x:
            return d
    return []

def checkBomb(pos_x, pos_y, size, bombPos):
    ''' Checks if the Robot has stepped over a bomb '''
    if bombPos[0] < pos_y + size and bombPos[0] >= pos_y and bombPos[1] < pos_x + size and bombPos[1] >= pos_x:
            return 1
    return 0

def endGame(status, score):
     ''' Ends the game and displays the final message '''
     curses.endwin()
     print("\nScore - " + str(score))
     if status == 0:
         print("Congratulations!! You won the game!!")
     else:
         print("You lost the game!!")
     print("\nThanks for Playing! (http://bitemelater.in).\n")
     exit(0)


if __name__ == '__main__':
    curses.initscr()
    curses.curs_set(0)
    
    width = 50                             # Width and
    height = 15                            # height of the window
    
    win = curses.newwin(15, 50, 0, 0)
    win.keypad(1)
    win.border(0)
    win.nodelay(1)
    curses.noecho()

    key = -1
    defaultKey = KEY_RIGHT                 # Goes along this path by default
    score = 0                              # Initializing score
    
    pos_x = 2                              # Initial coordinates of 
    pos_y = 2                              # the Robot
    size = 3                               # Size of the Robot
    
    defuses = []
    nDefuses = 5                           # Number of defuse codes 

    
    while len(defuses) < nDefuses + 1:     # Randomly calculating the coordinates of defuse codes
        defuses.extend([n for n in [[randint(1, height-2), randint(1, width-2)] for x in range(10)] if (n[0] < pos_y or n[0] > pos_y + size) and (n[1] < pos_x or n[1] > pos_x + size)])
        
    bombPos = defuses[len(defuses) - 1]    # Position of bomb is the last coordinate calculated    
    defuses = defuses[:nDefuses]           # Only nDefuses (here, 5) co-ordinates are taken
    
    while key != 27:                       # Until Esc key is not pressed
        win.clear()
        win.border(0)

        if pos_x <= 0 or pos_y <=0 or pos_x + size >= width or pos_y + size >= height:
            ''' If the Robot goes out of the boundary '''
            endGame(1, score)

        printRobot(win, pos_x, pos_y, size)
        temp = checkDefuse(pos_x, pos_y, size, defuses)
        if temp:
            defuses.remove(temp)
            score += 1
            
        if checkBomb(pos_x, pos_y, size, bombPos):
	    if score == 5:
                endGame(0, score)
	    else:
	        endGame(1, score)
        printDefuses(win, defuses)
        printBomb(win, bombPos)
        
        win.addstr(0, 2, 'Score: ' + str(score) + ' ')
        
	win.timeout(150);
        key = win.getch()

        key = defaultKey if key == -1 else key

        if key == KEY_RIGHT:
            pos_x += 1
	    defaultKey = key
        elif key == KEY_LEFT:
            pos_x -= 1
	    defaultKey = key
        elif key == KEY_DOWN:
            pos_y += 1
	    defaultKey = key
        elif key == KEY_UP:
            pos_y -= 1
	    defaultKey = key
        
    curses.endwin()
