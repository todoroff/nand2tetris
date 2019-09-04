// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

//Put the smaller factor in RAM[0] for faster computation

@R0
D = M
@y
M = D  // y = RAM[0]


@R1
D = M
@x
M = D // x = RAM[1]

@R2
M = D // R2 = x

@i
M = 1  // i = 1

(LOOP)
	@i
	D = M
	@y
	D = D-M
	@END
	D;JEQ // if i==y goto END

	@x
	D = M
	@R2
	M = M + D // R2 = R2 + x
	@i
	M = M + 1
	@LOOP
	0;JMP

(END)
	@END
	0;JMP