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

      @SCREEN     // point at SCREEN
      D=A         // jot down its address
      @screenword
      M=D         // store it in screenword

      @maxword
      M=D         // store it in maxword
      @8191       // A = (32 * 256) - 1
      D=A         // jot down number of additional registers in screen
      @maxword
      M=M+D       // add it to maxword

(LOOP)
      @KBD
      D=M         // read from keyboard

      @WHITE
      D;JEQ       // if keyboard == 0, draw white

      @BLACK
      0;JEQ       // else draw black

(WHITE)
      @screenword // read screenword
      A=M         // point at the address it references
      M=0         // set that register to 00...0

      @INCREMENT
      0;JEQ

(BLACK)
      @screenword // read screenword
      A=M         // point at the address it references
      M=-1        // set that register to 11...1

      @INCREMENT
      0;JEQ

(INCREMENT)
      @maxword    // read maxword
      D=M         // jot down its value
      @screenword // read screenword
      D=D-M       // subtract the two values
      @RESET
      D;JEQ       // reset if screenword == maxword

      @screenword
      M=M+1       // otherwise, increment screenword
      @LOOP
      0;JEQ       // and repeat

(RESET)
      @SCREEN     // point at SCREEN
      D=A         // jot down its address
      @screenword
      M=D         // store it in screenword

      @LOOP
      0;JEQ
