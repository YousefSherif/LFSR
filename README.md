# LFSR
What is an LFSR?
 - A linear-feedback shift register is a shift register whose input bit is a linear function of its previous state.
 - The initial content of the shift register is referred to as a seed. (Note: any value can be a seed except all 0’s to avoid the lookup state. Lookup state is the state in which shift register values are always zeros while shifting and XORing).
 - Feedback can be comprised of XOR gates or XNOR gates.

LFSR Applications
1)	Pattern Generators
2)	Encryption
3)	Compression
4)	CRC
5)	Pseudo-Random Bit Sequences (PRBS)

LFSR Specification and Operation:
1.	Initialize the shift registers using asynchronous reset with seed. 
2.	Allow the LFSR to operate for 8 cycles (LFSR Mode) then stop and shift out the content of the 4 registers through the o_out signal (R3 > R2 > R1 > R0 > OUT) (Shift Mode).
3.	Counter is responsible for counting to 8 and then flagging a signal to stop the LFSR.
4.	Valid signal is high when the output is valid, otherwise low.
5.	All outputs are registered.
