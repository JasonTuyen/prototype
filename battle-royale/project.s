.data
Intro:													#Message that displays game info
	.ascii "______________________________\n"
	.ascii "|                            |\n"
	.ascii "| @@@@@@@@@@@@@@@@@@@@@@@@@@ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @  Welcome to the Royal  @ |\n"
	.ascii "| @     Battle Royale!     @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @  A knight themed & RNG @ |\n"
	.ascii "| @   based fighting game  @ |\n"
	.ascii "| @     for 2-4 players    @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii "| @                        @ |\n"
	.ascii " \\ @                      @ / \n"
	.ascii "  \\ @     Created By:    @ /  \n"
	.ascii "   \\ @    Jason Tuyen   @ /   \n"
	.ascii "    \\ @                @ /    \n"
	.ascii "     \\ @              @ /     \n"
	.ascii "      \\ @            @ /      \n"
	.ascii "       \\ @@@@@@@@@@@@ /       \n"
	.ascii "        --------------        \n\n\0"

IntroPlayers:												#Message that asks for numbers of players
	.ascii "How many players? \0"

PlayersTotal:												#Stores total number of players
	.quad 0

PlayersLeft:												#Stores number of players left alive
	.quad 0

PlayersCurrent:												#Stores the current player's info
	.quad 0

PlayersTarget:												#Stores the players target
	.quad 0

PlayersHPChange:											#Stores the amount of hp change
	.quad 0

PlayersName:												#Array of player names
	.quad P0
	.quad P1
	.quad P2
	.quad P3
P0:
	.ascii "\n\nPLAYER 0: Sword Knight\n\0"
P1:
	.ascii "\n\nPLAYER 1: Lance Knight\n\0"
P2:
	.ascii "\n\nPLAYER 2: Axe Knight\n\0"
P3:
	.ascii "\n\nPLAYER 3: Bow Knight\n\0"

PlayersHP:												#Array of player health points
	.quad 100
	.quad 100
	.quad 100
	.quad 100

InfoHealth:												#Status info for player health
	.ascii "Health: \0"

InfoTarget:												#Status info for target choice
	.ascii "\nYour Target: \0"

InfoAttack:												#Status info for damage dealt
	.ascii "Damage Dealt To Target: \0"

InfoDead:												#Status info for killing blow
	.ascii "\nTarget Killed and Dismouted!\0"

InfoInvalid:
	.ascii "\nTarget dead, no need to beat a dead horse. Choose new target: \0"

InfoMiss:
	.ascii "\nYou Missed! Might as well take an arrow to the knee and quit.\0"

InfoWinner:
	.ascii "\n\nThe Winner is "
	.ascii "\n==========================\0"

.text
.global _start
_start:
	mov  $6, %rcx
	call SetForeColor
	mov  $Intro, %rcx										#Introduces the game and asks/stores the number of players
	call PrintCString
	mov  $IntroPlayers, %rcx
	call PrintCString
	call ScanInt
	mov  %rcx, PlayersTotal
	mov  %rcx, PlayersLeft
	mov  $7, %rcx
	call SetForeColor	
	
Reset:													#Reset the current player counter to zero
	mov  $0, %rcx											
	mov  %rcx, PlayersCurrent										

MainGame:												#The main loop for the main game
	cmp  $1, PlayersLeft										#Ends game if only one player left
	je   EndGame									

	mov  PlayersCurrent, %rdi																
	mov  PlayersHP (,%rdi,8), %rax
	cmp  $1, %rax											#If statement to see if current player is alive
	jle  Current											
	
	mov  PlayersName (,%rdi,8), %rcx								#Displays Player's Name and Health
	call PrintCString
	mov  $InfoHealth, %rcx
	call PrintCString	
	mov  PlayersHP (,%rdi,8), %rcx
	call PrintInt
	
	mov  $InfoTarget, %rcx										#Asks player who to perfrom an action on										
	call PrintCString											
	call ScanInt
	mov  %rcx, PlayersTarget
	call Alive
	call Action

Current:												#Sets current player to next player and resets back to zero when necessary
	add  $1, %rdi
	mov  %rdi, PlayersCurrent
	cmp  %rdi, PlayersTotal
	je   Reset
	jmp  MainGame											

Alive:													#Subroutine that check to see if target is alive
	push %rdi
	mov  PlayersTarget, %rdi
	mov  PlayersHP (,%rdi,8), %rax
	cmp  $1, %rax
	jge  EndAlive
	
	mov  $1, %rcx
	call SetForeColor
	mov  $InfoInvalid, %rcx
	call PrintCString
	call ScanInt
	mov  %rcx, PlayersTarget
	mov  $7, %rcx
	call SetForeColor
	call Alive

EndAlive:
	pop  %rdi
	ret

Action:													#Subroutine that perfroms an action that changes hp
	push %rdi

	mov  $6, %rcx											#Randomly determines if the attack misses
	call Random
	cmp  $2, %rcx
	je   MissAction
	cmp  $4, %rcx
	je   MissAction

	mov  $InfoAttack, %rcx
	call PrintCString

	mov  $1, %rcx
	call SetForeColor
	mov  $21, %rcx											#Randomly determines the amount of hp change
	call Random
	call PrintInt
	mov  $7, %rcx
	call SetForeColor
	mov  %rcx, PlayersHPChange
	mov  PlayersTarget, %rdi
	mov  PlayersHP (,%rdi,8), %rax
	sub  PlayersHPChange, %rax
	mov  %rax, PlayersHP (,%rdi,8)

	mov  PlayersHP (,%rdi,8), %rbx									#If statement that states if a player got killed, jumps over block if condition not met
	cmp  $1, %rbx
	jge  EndAction

	sub  $1, PlayersLeft
	mov  $1, %rcx
	call SetForeColor
	mov  $InfoDead, %rcx
	call PrintCString
	mov  $7, %rcx
	call SetForeColor
	jmp  EndAction

MissAction:
	mov  $1, %rcx
	call SetForeColor
	mov  $InfoMiss, %rcx
	call PrintCString
	mov  $7, %rcx
	call SetForeColor

EndAction:
	pop  %rdi
	ret

EndGame:												#Displays End Game Content
	call Winner	
	call EndProgram

Winner:													#Subroutine that determines the winner
	mov  $0, %rcx
	mov  %rcx, PlayersCurrent
	mov  PlayersCurrent, %rdi
	mov  PlayersHP (,%rdi,8), %rcx
	cmp  $1, %rcx
	jge  W0
	add  $1, PlayersCurrent
	mov  PlayersCurrent, %rdi
	mov  PlayersHP (,%rdi,8), %rcx
	cmp  $1, %rcx
	jge  W1
	add  $1, PlayersCurrent
	mov  PlayersCurrent, %rdi
	mov  PlayersHP (,%rdi,8), %rcx
	cmp  $1, %rcx
	jge  W2
	add  $1, PlayersCurrent
	mov  PlayersCurrent, %rdi
	mov  PlayersHP (,%rdi,8), %rcx
	cmp  $1, %rcx
	jge  W3	
	ret
W0:
	mov  $3, %rcx
	call SetForeColor
	mov  $InfoWinner, %rcx
	call PrintCString
	mov  PlayersName (,%rdi,8), %rcx
	call PrintCString
	mov  $7, %rcx
	call SetForeColor
	ret
W1:
	mov  $3, %rcx
	call SetForeColor
	mov  $InfoWinner, %rcx
	call PrintCString
	mov  PlayersName (,%rdi,8), %rcx
	call PrintCString
	mov  $7, %rcx
	call SetForeColor
	ret
W2:
	mov  $3, %rcx
	call SetForeColor
	mov  $InfoWinner, %rcx
	call PrintCString
	mov  PlayersName (,%rdi,8), %rcx
	call PrintCString
	mov  $7, %rcx
	call SetForeColor
	ret
W3:
	mov  $3, %rcx
	call SetForeColor
	mov  $InfoWinner, %rcx
	call PrintCString
	mov  PlayersName (,%rdi,8), %rcx
	call PrintCString
	mov  $7, %rcx
	call SetForeColor
	ret
