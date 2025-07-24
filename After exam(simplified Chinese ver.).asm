;课题名称:排序成绩并求等级
	.ORIG	x3000
	LD	R1,SCORE;	R1读取SCORE内存地址
	LDR	R2,R1,#0;	R2读取SCORE的内容
	LD	R3,TOTAL;	R3读取TOTAL的内容，用于循环计数器
	LD	R4,RESULT;	R4读取RESULT内存地址用于存放结果,此处为先复制一遍原始数据以便后续操作
STORE	AND	R5,R5,#0;	R5清零
	LDR	R5,R1,#0;	R5读取R1的内容,即遍历读取原始数组的内容
	STR	R5,R4,#0;	R5读取的内容存放到R4
	ADD	R1,R1,#1;	R1++,即原始数组下标自增,数组指针右移
	ADD	R4,R4,#1;	同上
	ADD	R3,R3,#-1;	计数器自减
	BRz	NEXT;		计数器为零时跳出循环
	BRnzp	STORE;		计数器不为零时继续循环
;冒泡排序
NEXT	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;
	AND	R7,R7,#0;	清空所有寄存器
	LD	R0,TIMES;	外层循环计数器
OUTER	LD	R1,TIMES;	内层循环计数器
	LD	R2,RESULT;	RESULT指针
INNER	LDR	R3,R2,#0;	读取指针当前数据
	LDR	R4,R2,#1;	读取指针下一位数据
	NOT	R5,R4;
	ADD	R5,R5,#1;	取后一位数据的负值
	ADD	R5,R3,R5;	比较
	BRzp	CTN1;		如果R3<=R4跳转CTN1(CONTINUE)
	STR	R4,R2,#0;	否则R3>R4
	STR	R3,R2,#1;	交换
CTN1	ADD	R2,R2,#1;	不交换时R2右移
	ADD	R1,R1,#-1;	内层计数器自减
	BRp	INNER;		内层计数器大于零时,说明循环次数不够,继续内层循环
	ADD	R0,R0,#-1;	否则外层计数器自减
	BRp	OUTER;		进行下一次内层循环,外层计数器等于零时跳出循环,排序完成
;统计A和B
	AND	R0,R0,#0;
	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;
	AND	R7,R7,#0;	清空所有寄存器
	LD	R0,RESULT;	RESULT指针
	LD	R1,GA;
	NOT	R1,R1;
	ADD	R1,R1,#1;	R1装载A级分数阈值(取负值是为了与当前数据相减以比较大小,下同)
	LD	R2,GB;
	NOT	R2,R2;
	ADD	R2,R2,#1;	R2装载B级分数阈值
	ADD	R3,R3,#1;	R3作为排名计数器(因为经过冒泡排序后,成绩数组下标+1即为排名,故R3+1使排名由1开始)
	BRnzp	CPR;		无条件跳转CPR(COMPARE)
CTN2	ADD	R0,R0,#1;	处理完当前数据时指针右移
CPR	LDR	R4,R0,#0;	R4读取当前数据
OF	ADD	R3,R3,#-4;	(OVER FOUR)
	BRp	RE;		排名计数器与4比较,若大于4直接判定为非A
	ADD	R3,R3,#4;	排名计数器值复原
	BRnzp	EF;		无条件跳转与A级分数阈值比较
TEMP	NOT	R1,R1;
	ADD	R1,R1,#1;
	ADD	R4,R1,R4;
	NOT	R1,R1;
	ADD	R1,R1,#1;
	BRnzp	SF;		复原当前数值(成绩)并无条件跳转与B级分数阈值比较
RE	ADD	R3,R3,#4;	计数器值复原(RESET)
OE	ADD	R3,R3,#-8;	(OVER EIGHT)
	BRp	COUNT;		排名计数器与8比较,若大于8直接结算,剩余成绩自动判C级
	ADD	R3,R3,#8;	计数器值复原
	BRnzp	SF;		无条件跳转与B级分数阈值比较
EF	ADD	R4,R1,R4;	(EIGHTY-FIVE)
	BRnz	TEMP;		未达到A级分数阈值,跳转与B级作比较
	ADD	R5,R5,#1;	达到评A标准,A级计数器自增
	ADD	R3,R3,#1;	排名计数器自增	
	BRnzp	CTN2;		处理完当前数据,无条件跳转指针右移(CONTINUE2)
SF	ADD	R4,R2,R4;	(SEVENTY-FIVE)
	BRnz	COUNT;		未达到B级分数阈值,自动判C级,后续分数都会小于等于当前分数,同样自动判C级
	ADD	R6,R6,#1;	达到评B标准,B级计数器自增
	ADD	R3,R3,#1;	排名计数器自增
	BRnzp	CTN2;		处理完当前数据,无条件跳转指针右移
;存放A和B
COUNT	STI	R5,NA;		存放A级计数器值
	STI	R6,NB;		存放B级计数器值
	NOT	R5,R5;
	NOT	R6,R6;
	ADD	R5,R5,#1;
	ADD	R6,R6,#1;	分别取A和B级计数器的负值
	LD	R7,TOTAL;	读取总人数
	ADD	R7,R7,R5;
	ADD	R7,R7,R6;	总人数减去得A和B级人数之和得到得C级的人数
;统计并存放C
	AND	R0,R0,#0;
	AND	R1,R1,#0;
	AND	R2,R2,#0;
	AND	R3,R3,#0;
	AND	R4,R4,#0;
	AND	R5,R5,#0;
	AND	R6,R6,#0;	清空除R7外的寄存器(R7当前装载得C级的人数,有且仅有得C级的人数为两位数,由于输出时使用ASCII数字显示,故分别存放十位和个位数)
	LD	R0,JUDGE;
	NOT	R0,R0;
	ADD	R0,R0,#1;	R0读取值-10
	ADD	R7,R0,R7;	R7与10相减,分类讨论是否为两位数
	BRp	S1;		若是,跳转处理两位数
	NOT	R0,R0;
	ADD	R0,R0,#1;
	ADD	R7,R0,R7;	若否,R7+=10(复原)
	AND	R0,R0,#0;	清零R0
	STI	R0,NC1;		当R7<10时,十位数为0,同样存放(避免内存地址存在其他数据)
	BRnzp	S2;		无条件跳转个位数存放
S1	AND	R0,R0,#0;
	ADD	R0,R0,#1;	当R7>=10时,R0赋值为1,表示R7的十位数为1
	STI	R0,NC1;		存放十位数
S2	STI	R7,NC2;		存放个位数
	AND	R0,R0,#0;
	AND	R7,R7,#0;	清空R0和R7
;输出
	LEA	R0,GAP;		读取A级提示词
	TRAP	x22;		输出A级提示词
	LDI	R0,NA;		读取A级人数
	LD	R1,ASCII;	读取'0'ASCII码值
	ADD	R0,R1,R0;	将人数值转化为ASCII数字
	OUT;			输出A级人数(的ASCII数字)
	LEA	R0,NL;		读取换行符
	PUTS;			输出换行符
	LEA	R0,GBP;		读取B级提示词
	PUTS;			输出B级提示词
	LDI	R0,NB;		读取B级人数
	ADD	R0,R1,R0;	将人数值转化为ASCII数字
	OUT;			输出B级人数(的ASCII数字)
	LEA	R0,NL;		读取换行符
	PUTS;			输出换行符
	LEA	R0,GCP;		读取C级提示词
	PUTS;			输出C级提示词
	LDI	R0,NC1;		读取C级人数十位数
	BRz	UNIT;		若C级人数小于10,直接跳转个位数输出
	ADD	R0,R1,R0;	将十位数转化为ASCII数字
	OUT;			输出十位数(的ASCII数字)
UNIT	LDI	R0,NC2;		读取C级人数的个位数
	ADD	R0,R1,R0;	将个位数转化为ASCII数字
	OUT;			输出个位数(的ASCII数字)
	HALT;			
;数据区
SCORE	.FILL x3500;		原始数据存放在x3500
RESULT	.FILL x3600;		结果存放在x3600
TOTAL	.FILL x0010;		总人数为x0010(16)
TIMES	.FILL x000F;		循环次数计数器为x00FF(15)
GA	.FILL x0055;		GRADE A分数阈值x0055(85)
GB	.FILL x004B;		GRADE B分数阈值x004B(75)
GAP	.STRINGZ "Grade_A ";	A级提示词(GRADE A PROMPT)
GBP	.STRINGZ "Grade_B ";	B级提示词(GRADE B PROMPT)
GCP	.STRINGZ "Grade_C ";	C级提示词(GRADE C PROMPT)
NA	.FILL x3700;		A级人数(NUM A)
NB	.FILL x3701;		B级人数(NUM B)
JUDGE	.FILL x000A;		判断常数x000A(10),用于C级人数是否为两位数的判断
NC1	.FILL x3702;		C级人数十位数(NUM C1)
NC2	.FILL x3703;		C级人数个位数(NUM C2)
NL	.STRINGZ "\n";		换行符(NEWLINE)
ASCII	.FILL x0030;		'0'的ASCII码值x0030(48)
	.END
