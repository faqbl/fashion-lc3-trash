;��������:����ɼ�����ȼ�
	.ORIG	x3000
	LD	R1,SCORE;	R1��ȡSCORE�ڴ��ַ
	LDR	R2,R1,#0;	R2��ȡSCORE������
	LD	R3,TOTAL;	R3��ȡTOTAL�����ݣ�����ѭ��������
	LD	R4,RESULT;	R4��ȡRESULT�ڴ��ַ���ڴ�Ž��,�˴�Ϊ�ȸ���һ��ԭʼ�����Ա��������
STORE	AND	R5,R5,#0;	R5����
	LDR	R5,R1,#0;	R5��ȡR1������,��������ȡԭʼ���������
	STR	R5,R4,#0;	R5��ȡ�����ݴ�ŵ�R4
	ADD	R1,R1,#1;	R1++,��ԭʼ�����±�����,����ָ������
	ADD	R4,R4,#1;	ͬ��
	ADD	R3,R3,#-1;	�������Լ�
	BRz	NEXT;		������Ϊ��ʱ����ѭ��
	BRnzp	STORE;		��������Ϊ��ʱ����ѭ��
;ð������
NEXT	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;
	AND	R7,R7,#0;	������мĴ���
	LD	R0,TIMES;	���ѭ��������
OUTER	LD	R1,TIMES;	�ڲ�ѭ��������
	LD	R2,RESULT;	RESULTָ��
INNER	LDR	R3,R2,#0;	��ȡָ�뵱ǰ����
	LDR	R4,R2,#1;	��ȡָ����һλ����
	NOT	R5,R4;
	ADD	R5,R5,#1;	ȡ��һλ���ݵĸ�ֵ
	ADD	R5,R3,R5;	�Ƚ�
	BRzp	CTN1;		���R3<=R4��תCTN1(CONTINUE)
	STR	R4,R2,#0;	����R3>R4
	STR	R3,R2,#1;	����
CTN1	ADD	R2,R2,#1;	������ʱR2����
	ADD	R1,R1,#-1;	�ڲ�������Լ�
	BRp	INNER;		�ڲ������������ʱ,˵��ѭ����������,�����ڲ�ѭ��
	ADD	R0,R0,#-1;	�������������Լ�
	BRp	OUTER;		������һ���ڲ�ѭ��,��������������ʱ����ѭ��,�������
;ͳ��A��B
	AND	R0,R0,#0;
	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;
	AND	R7,R7,#0;	������мĴ���
	LD	R0,RESULT;	RESULTָ��
	LD	R1,GA;
	NOT	R1,R1;
	ADD	R1,R1,#1;	R1װ��A��������ֵ(ȡ��ֵ��Ϊ���뵱ǰ��������ԱȽϴ�С,��ͬ)
	LD	R2,GB;
	NOT	R2,R2;
	ADD	R2,R2,#1;	R2װ��B��������ֵ
	ADD	R3,R3,#1;	R3��Ϊ����������(��Ϊ����ð�������,�ɼ������±�+1��Ϊ����,��R3+1ʹ������1��ʼ)
	BRnzp	CPR;		��������תCPR(COMPARE)
CTN2	ADD	R0,R0,#1;	�����굱ǰ����ʱָ������
CPR	LDR	R4,R0,#0;	R4��ȡ��ǰ����
OF	ADD	R3,R3,#-4;	(OVER FOUR)
	BRp	RE;		������������4�Ƚ�,������4ֱ���ж�Ϊ��A
	ADD	R3,R3,#4;	����������ֵ��ԭ
	BRnzp	EF;		��������ת��A��������ֵ�Ƚ�
TEMP	NOT	R1,R1;
	ADD	R1,R1,#1;
	ADD	R4,R1,R4;
	NOT	R1,R1;
	ADD	R1,R1,#1;
	BRnzp	SF;		��ԭ��ǰ��ֵ(�ɼ�)����������ת��B��������ֵ�Ƚ�
RE	ADD	R3,R3,#4;	������ֵ��ԭ(RESET)
OE	ADD	R3,R3,#-8;	(OVER EIGHT)
	BRp	COUNT;		������������8�Ƚ�,������8ֱ�ӽ���,ʣ��ɼ��Զ���C��
	ADD	R3,R3,#8;	������ֵ��ԭ
	BRnzp	SF;		��������ת��B��������ֵ�Ƚ�
EF	ADD	R4,R1,R4;	(EIGHTY-FIVE)
	BRnz	TEMP;		δ�ﵽA��������ֵ,��ת��B�����Ƚ�
	ADD	R5,R5,#1;	�ﵽ��A��׼,A������������
	ADD	R3,R3,#1;	��������������	
	BRnzp	CTN2;		�����굱ǰ����,��������תָ������(CONTINUE2)
SF	ADD	R4,R2,R4;	(SEVENTY-FIVE)
	BRnz	COUNT;		δ�ﵽB��������ֵ,�Զ���C��,������������С�ڵ��ڵ�ǰ����,ͬ���Զ���C��
	ADD	R6,R6,#1;	�ﵽ��B��׼,B������������
	ADD	R3,R3,#1;	��������������
	BRnzp	CTN2;		�����굱ǰ����,��������תָ������
;���A��B
COUNT	STI	R5,NA;		���A��������ֵ
	STI	R6,NB;		���B��������ֵ
	NOT	R5,R5;
	NOT	R6,R6;
	ADD	R5,R5,#1;
	ADD	R6,R6,#1;	�ֱ�ȡA��B���������ĸ�ֵ
	LD	R7,TOTAL;	��ȡ������
	ADD	R7,R7,R5;
	ADD	R7,R7,R6;	��������ȥ��A��B������֮�͵õ���C��������
;ͳ�Ʋ����C
	AND	R0,R0,#0;
	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;	��ճ�R7��ļĴ���(R7��ǰװ�ص�C��������,���ҽ��е�C��������Ϊ��λ��,�������ʱʹ��ASCII������ʾ,�ʷֱ���ʮλ�͸�λ��)
	LD	R0,JUDGE;
	NOT	R0,R0;
	ADD	R0,R0,#1;	R0��ȡֵ-10
	ADD	R7,R0,R7;	R7��10���,���������Ƿ�Ϊ��λ��
	BRp	S1;		����,��ת������λ��
	NOT	R0,R0;
	ADD	R0,R0,#1;
	ADD	R7,R0,R7;	����,R7+=10(��ԭ)
	AND	R0,R0,#0;	����R0
	STI	R0,NC1;		��R7<10ʱ,ʮλ��Ϊ0,ͬ�����(�����ڴ��ַ������������)
	BRnzp	S2;		��������ת��λ�����
S1	AND	R0,R0,#0;
	ADD	R0,R0,#1;	��R7>=10ʱ,R0��ֵΪ1,��ʾR7��ʮλ��Ϊ1
	STI	R0,NC1;		���ʮλ��
S2	STI	R7,NC2;		��Ÿ�λ��
	AND	R0,R0,#0;
	AND	R7,R7,#0;	���R0��R7
;���
	LEA	R0,GAP;		��ȡA����ʾ��
	TRAP	x22;		���A����ʾ��
	LDI	R0,NA;		��ȡA������
	LD	R1,ASCII;	��ȡ'0'ASCII��ֵ
	ADD	R0,R1,R0;	������ֵת��ΪASCII����
	OUT;			���A������(��ASCII����)
	LEA	R0,NL;		��ȡ���з�
	PUTS;			������з�
	LEA	R0,GBP;		��ȡB����ʾ��
	PUTS;			���B����ʾ��
	LDI	R0,NB;		��ȡB������
	ADD	R0,R1,R0;	������ֵת��ΪASCII����
	OUT;			���B������(��ASCII����)
	LEA	R0,NL;		��ȡ���з�
	PUTS;			������з�
	LEA	R0,GCP;		��ȡC����ʾ��
	PUTS;			���C����ʾ��
	LDI	R0,NC1;		��ȡC������ʮλ��
	BRz	UNIT;		��C������С��10,ֱ����ת��λ�����
	ADD	R0,R1,R0;	��ʮλ��ת��ΪASCII����
	OUT;			���ʮλ��(��ASCII����)
UNIT	LDI	R0,NC2;		��ȡC�������ĸ�λ��
	ADD	R0,R1,R0;	����λ��ת��ΪASCII����
	OUT;			�����λ��(��ASCII����)
	HALT;			
;������
SCORE	.FILL x3500;		ԭʼ���ݴ����x3500
RESULT	.FILL x3600;		��������x3600
TOTAL	.FILL x0010;		������Ϊx0010(16)
TIMES	.FILL x000F;		ѭ������������Ϊx00FF(15)
GA	.FILL x0055;		GRADE A������ֵx0055(85)
GB	.FILL x004B;		GRADE B������ֵx004B(75)
GAP	.STRINGZ "Grade_A ";	A����ʾ��(GRADE A PROMPT)
GBP	.STRINGZ "Grade_B ";	B����ʾ��(GRADE B PROMPT)
GCP	.STRINGZ "Grade_C ";	C����ʾ��(GRADE C PROMPT)
NA	.FILL x3700;		A������(NUM A)
NB	.FILL x3701;		B������(NUM B)
JUDGE	.FILL x000A;		�жϳ���x000A(10),����C�������Ƿ�Ϊ��λ�����ж�
NC1	.FILL x3702;		C������ʮλ��(NUM C1)
NC2	.FILL x3703;		C��������λ��(NUM C2)
NL	.STRINGZ "\n";		���з�(NEWLINE)
ASCII	.FILL x0030;		'0'��ASCII��ֵx0030(48)
	.END
