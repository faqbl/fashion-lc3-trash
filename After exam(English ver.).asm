	.ORIG	x3000
	LD	R1,SCORE;	R1 fetch the memory address of SCORE
	LDR	R2,R1,#0;	R2 fetch the content of SCORE
	LD	R3,TOTAL;	R3 fetch the content of TOTAL as the loop counter
	LD	R4,RESULT;	R4 fetch the memory address of RESULT to store the result,here copy the original data to avoid polluting the original data
STORE	AND	R5,R5,#0;	R5 clear
	LDR	R5,R1,#0;	R5 fetch the content of R1,that is to ergodic fetch the content of the original array
	STR	R5,R4,#0;	the content fetched by R5 store in R4
	ADD	R1,R1,#1;	R1++,that is the index of the original array auto-increase,the pointer of the array moveright
	ADD	R4,R4,#1;	op.cit.
	ADD	R3,R3,#-1;	counter auto-decrease
	BRz	NEXT;		if the counter is 0,break the loop
	BRnzp	STORE;		if the counter is not 0,continue the loop
;bubble sort
NEXT	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;
	AND	R7,R7,#0;	clear all registers
	LD	R0,TIMES;	counter for outer loop
OUTER	LD	R1,TIMES;	counter for inner loop
	LD	R2,RESULT;	create a pointer pointing to RESULT
INNER	LDR	R3,R2,#0;	fetch the current value of the pointer
	LDR	R4,R2,#1;	fetch the next bit value of the pointer
	NOT	R5,R4;
	ADD	R5,R5,#1;	fetch the negative value of the next bit value
	ADD	R5,R3,R5;	compare
	BRzp	CTN1;		if R3<=R4,jump to CTN1(CONTINUE)
	STR	R4,R2,#0;	else R3>R4
	STR	R3,R2,#1;	exchange
CTN1	ADD	R2,R2,#1;	if no exchange,R2 moveright
	ADD	R1,R1,#-1;	the counter of inner loop auto-decrease
	BRp	INNER;		if the counter of the inner loop is over 0,indicates that there's no enough times of loop,continue the loop
	ADD	R0,R0,#-1;	else the counter of outer loop auto-decrease
	BRp	OUTER;		conduct a new(next time)inner loop,if the counter of outer loop is 0,break the loop,finish the sort
;statistics of A&B
	AND	R0,R0,#0;
	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;
	AND	R7,R7,#0;	clear all registers
	LD	R0,RESULT;	the pointer of RESULT
	LD	R1,GA;
	NOT	R1,R1;
	ADD	R1,R1,#1;	R1 load the score threshold of grade A(turning into the negative value is to minus the current value and compare,the same below)
	LD	R2,GB;
	NOT	R2,R2;
	ADD	R2,R2,#1;	R2 load the score threshold of grade B
	ADD	R3,R3,#1;	R3 serve as the counter of ranking(caz after bubble sort,the index of score array+1=rank,so R3+1 let the ranking starts from 1)
	BRnzp	CPR;		unconditionally jump to CPR(COMPARE)
CTN2	ADD	R0,R0,#1;	pointer moveright after handling current data
CPR	LDR	R4,R0,#0;	R4 fetch current data
OF	ADD	R3,R3,#-4;	(OVER FOUR)
	BRp	RE;		ranking counter compares with 4,if over 4 judge as not grade A
	ADD	R3,R3,#4;	reset the ranking counter
	BRnzp	EF;		unconditionally jump to comparing with score threshold of grade A
TEMP	NOT	R1,R1;
	ADD	R1,R1,#1;
	ADD	R4,R1,R4;
	NOT	R1,R1;
	ADD	R1,R1,#1;
	BRnzp	SF;		reset the current data(the score)and unconditionally jump to comparing with score threshold of grade B
RE	ADD	R3,R3,#4;	(RESET)
OE	ADD	R3,R3,#-8;	(OVER EIGHT)
	BRp	COUNT;		ranking counter compares with 8,if over 8 the rest of(include this one)judge as C
	ADD	R3,R3,#8;	reset the counter
	BRnzp	SF;		unconditionally jump to comparing with score threshold of grade B
EF	ADD	R4,R1,R4;	(EIGHTY-FIVE)
	BRnz	TEMP;		if lower than the score threshold of grade A,jump to comparing with grade B
	ADD	R5,R5,#1;	if reach the standard of grade A,the counter of(number of students of)grade Aauto-increase
	ADD	R3,R3,#1;	ranking counter auto-increase
	BRnzp	CTN2;		unconditionally jump to pointer moveright(CONTINUE2)after handling current data
SF	ADD	R4,R2,R4;	(SEVENTY-FIVE)
	BRnz	COUNT;		if lower than the score threshold of grade B,judge as C,and caz the rest of scores are lower than current score,they are also judged as C
	ADD	R6,R6,#1;	if reach the standard of grade B,the counter of grade B auto-increase
	ADD	R3,R3,#1;	ranking counter auto-increase
	BRnzp	CTN2;		unconditionally jump to pointer moveright after handling current data
;storage of(number of students of)A&B
COUNT	STI	R5,NA;		store the value of the counter of grade A
	STI	R6,NB;		store the value of the counter of grade B
	NOT	R5,R5;
	NOT	R6,R6;
	ADD	R5,R5,#1;
	ADD	R6,R6,#1;	fetch the negative value of the counter of grade A&B separately
	LD	R7,TOTAL;	fetch the total number of students
	ADD	R7,R7,R5;
	ADD	R7,R7,R6;	numbers of students:total-A&B=C
;statistics&storage of C
	AND	R0,R0,#0;
	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;	clear the registers except R7
;R7 load the number of students of grade C currently,only the number of students of grade C may be double digit value(decimal)
;and caz using the ASCII codes to output the number(value),so the tens digit and the single digit are stored separately
	LD	R0,JUDGE;
	NOT	R0,R0;
	ADD	R0,R0,#1;	R0fetch the value -10
	ADD	R7,R0,R7;	R7 minus 10,do a classification discussion about if it's a double digit
	BRp	S1;		if so,jump to dealing with double digit
	NOT	R0,R0;
	ADD	R0,R0,#1;
	ADD	R7,R0,R7;	if not,R7+=10(restore)
	AND	R0,R0,#0;	clear R0
	STI	R0,NC1;		if R7<10,the tens digit is 0,still store it(avoid pollution of other data)
	BRnzp	S2;		unconditionally jump to storing single digit number
S1	AND	R0,R0,#0;
	ADD	R0,R0,#1;	if R7>=10,R0 assigned as 1,representing the tens digit of R7(the number of students of grade C)is 1
	STI	R0,NC1;		store the tens digit
S2	STI	R7,NC2;		store the single digit
	AND	R0,R0,#0;
	AND	R7,R7,#0;	clear R0&R7
;output
	LEA	R0,GAP;		fetch the prompt of grade A
	TRAP	x22;		output the prompt of grade A
	LDI	R0,NA;		fetch the number of students of grade A
	LD	R1,ASCII;	fetch the ASCII code value of '0'
	ADD	R0,R1,R0;	change the number of students into ASCII number(by minus ASCII'0')
	OUT;			output the(ASCII)number of grade A
	LEA	R0,NL;		fetch the newline(code)
	PUTS;			output the newline
	LEA	R0,GBP;		fetch the prompt of grade B
	PUTS;			output the prompt of grade B
	LDI	R0,NB;		fetch the number of students of grade B
	ADD	R0,R1,R0;	change the number of students into ASCII number
	OUT;			output the(ASCII)number of grade B
	LEA	R0,NL;		fetch the newline
	PUTS;			output the newline
	LEA	R0,GCP;		fetch the prompt of grade C
	PUTS;			output the prompt of grade C
	LDI	R0,NC1;		fetch the tens digit of the number of students of grade C
	BRz	UNIT;		if the number of students of grade C is less than 10(the tens digit is 0),jump to the single digit output
	ADD	R0,R1,R0;	change the tens digit into ASCII number
	OUT;			output the(ASCII)number of the tens digit
UNIT	LDI	R0,NC2;		fetch the single digit of the number of students of grade C 
	ADD	R0,R1,R0;	change the single digit into ASCII number
	OUT;			output the(ASCII)number of the single digit
	HALT;			
;database
SCORE	.FILL x3500;		original data stores at x3500
RESULT	.FILL x3600;		result stores at x3600
TOTAL	.FILL x0010;		the total number of students is x0010(16)
TIMES	.FILL x000F;		the value of loop counter is x00FF(15)
;*judge after decrease,so when it comes to 0,loop will work again before break,so the value of counter is one less than the total number of students
GA	.FILL x0055;		GRADE A score threshold x0055(85)
GB	.FILL x004B;		GRADE B score threshold x004B(75)
GAP	.STRINGZ "Grade_A ";	GRADE A PROMPT
GBP	.STRINGZ "Grade_B ";	GRADE B PROMPT
GCP	.STRINGZ "Grade_C ";	GRADE C PROMPT
NA	.FILL x3700;		the number of students of grade A(NUM A)
NB	.FILL x3701;		the number of students of grade B(NUM B)
JUDGE	.FILL x000A;		const x000A(10),for judging if the number of students of grade C is a double digit
NC1	.FILL x3702;		the tens digit of the number of students of grade C(NUM C1)
NC2	.FILL x3703;		the single digit of the number of students of grade C(NUM C2)
NL	.STRINGZ "\n";		NEWLINE
ASCII	.FILL x0030;		ASCII code value of '0':x0030(48)
	.END