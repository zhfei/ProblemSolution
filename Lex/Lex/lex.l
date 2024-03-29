
/* 1.声明 */

/* %{ %} 直接导出到C文件中 */
%{
/* 明示常量的定义 */
#define IF 1
#define THEN 2
#define ELSE 3
#define ID 4
#define NUMBER 5
#define RELOP 6
#define DO 7
#define WHILE 8
%}

/* 正则变量声明 */
/* 正则表达式的定义 */
delim       [ \t\n]
ws          {delim}+
letter      [A-Za-z]
digit       [0-9]
id          {letter}({letter}|{digit})*
number      [+-]?{digit}+(\.{digit}+)?(E[+-]?{digit}+)?


/* 2.转换规则 */

%%
{ws}        {  }
if          { return(IF); }
then        { return(THEN); }
while       { return(WHILE); }
do          { return(DO); }
else        { return(ELSE); }
{id}        { return(ID); }
{number}    { return(NUMBER); }
"<"         { return(RELOP); }
"<="        { return(RELOP); }
"<>"        { return(RELOP); }
">"         { return(RELOP); }
">="        { return(RELOP); }
"="         { return(RELOP); }
%%

/* 3.辅助函数 */

/*
 yyout：yylex() 的输出流结果指针
 yytext: yylex() 输出结果存储的变量
 */
void writeout(int c){
    switch(c){
        case RELOP: fprintf(yyout, "(RELOP, \"%s\")\n", yytext);break;
        case WHILE: fprintf(yyout, "(WHILE, \"%s\")\n", yytext);break;
        case DO: fprintf(yyout, "(DO, \"%s\")\n", yytext);break;
        case NUMBER: fprintf(yyout, "(NUM, \"%s\")\n", yytext);break;
        case ID: fprintf(yyout, "(ID, \"%s\")\n", yytext);break;
        default:break;
    }
    return;
}

/*
 yyin：yylex() 输入流句柄指针
 yyout: yylex() 输出流句柄指针
 */
int main (int argc, char ** argv){
    int c;
    if (argc>=2){
        if ((yyin = fopen(argv[1], "r")) == NULL){
            printf("Can't open file %s\n", argv[1]);
            return 1;
        }
        if (argc>=3){
            yyout=fopen(argv[2], "w");
        }
    }

    /* yyin和yyout是lex中定义的输入输出文件指针，它们指明了
     * lex生成的词法分析器从哪里获得输入和输出到哪里。
     * 默认：键盘输入，屏幕输出。
     */
    while ((c = yylex()) != 0) {
        writeout(c);
    }

    if(argc>=2){
        fclose(yyin);
        if (argc>=3) fclose(yyout);
    }
    return 0;
}
