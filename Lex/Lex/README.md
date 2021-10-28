####  Lex简介

Lex是一种语言，用Lex编写的程序成为lex源程序，使用lex编译器将lex源程序编译成C代码。

lex源代码的结构是

```
声明（变量声明，常量声明）
%%
转换规则
%%
辅助函数
```

lex程序提供了一个函数int yylex()和两个变量yyleng, yytext共外部使用

yylex
当调用函数yylex时，程序会从yyin指针所指向的输入流中逐个读取字符，最后返回最长匹配字符串。
yytext（变量）
匹配结束后，会将结果放置在yytext中
yyleng（变量）
设置匹配结果的长度




