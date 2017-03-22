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

// screenword = SCREEN
      @SCREEN
      D=A
      @screenword
      M=D

// maxword = SCREEN + 8192
      @SCREEN
      D=A
      @maxword
      M=D
      @8192
      D=A-1
      @maxword
      M=M+D

// while true
(LOOP)
      @KBD   // if keyboard == 0
      D=M
      @WHITE // draw white
      D;JEQ
      @BLACK // else draw black
      0;JEQ

(WHITE)
      @screenword
      A=M
      M=0
      @INCREMENT
      0;JEQ

(BLACK)
      @screenword
      A=M
      M=-1
      @INCREMENT
      0;JEQ

(INCREMENT)
      @maxword
      D=M
      @screenword
      D=D-M
      @RESET
      D;JEQ // reset if maxword - screenword == 0

      @screenword
      M=M+1 // screenword += 1

      @LOOP
      0;JEQ

(RESET)
      @SCREEN
      D=A
      @screenword
      M=D

      @LOOP
      0;JEQ
