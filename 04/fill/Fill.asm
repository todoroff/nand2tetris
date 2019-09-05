// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
@SCREEN
D = A
@addr
M = D //addr = 16384 (screen's base address)

@flag //default == 0; 
	  //flag == 1 means screen was filled in previous iteration
	  //to reduce memory read/write
M = 0

@i
M = 0

@8192
D = A
@n
M = D // n = 8192 (number of 16bit words that make up the whole screen)

(MAINLOOP)
	@KBD
	D = M

	@FILL
	D;JNE //if key pressed goto FILL

	@UNFILL
	D;JEQ //if no key is pressed goto UNFILL
	
	(FILL)
		@flag
		D = M
		@MAINLOOP
		D;JNE //if flag is up return to MAINLOOP

		(FILLLOOP)
			@i
			D = M
			@n
			D = D-M
			@EXITFIL
			D;JEQ //if i==n goto EXITFIL

			@addr
			A = M
			M = -1 //fill

			@addr
			M = M + 1
			@i
			M = M + 1

			@FILLLOOP
			0;JMP


		(EXITFIL)
			@flag
			M = 1 //set flag
			
			@i
			M = 0 //reset i
			
			@SCREEN
			D = A
			@addr
			M = D // reset addr


			@MAINLOOP
			0;JMP //return to MAINLOOP

	(UNFILL)
		@flag
		D = M
		@MAINLOOP
		D;JEQ //if flag isn't up return to MAINLOOP

		(UNFILLLOOP)
			@i
			D = M
			@n
			D = D-M
			@EXITUNFIL
			D;JEQ //if i==n goto EXITUNFIL

			@addr
			A = M
			M = 0 //unfill

			@addr
			M = M + 1
			@i
			M = M + 1

			@UNFILLLOOP
			0;JMP


		(EXITUNFIL)
			@flag
			M = 0 //set flag
			
			@i
			M = 0 //reset i
			
			@SCREEN
			D = A
			@addr
			M = D // reset addr


			@MAINLOOP
			0;JMP //return to MAINLOOP