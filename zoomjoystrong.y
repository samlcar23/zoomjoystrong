%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start zoomjoystrong

%union {int i; char* str; float f;}

%token LINE
%token POINT
%token RECTANGLE
%token CIRCLE
%token SET_COLOR
%token END
%token END_STATEMENT
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT


%%

zoomjoystrong: command_statements END END_STATEMENT	{ finish(); return 0; }
	|		  END END_STATEMENT						{ finish(); return 0; }
;

command_statements: 	command
	|					command command_statements
;

command: 			point|line|circle|rectangle|set_color 
;

point:		POINT INT INT END_STATEMENT
;

line:			LINE INT INT INT INT END_STATEMENT
;

circle:		CIRCLE INT INT INT END_STATEMENT
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT
;

set_color:		SET_COLOR INT INT INT END_STATEMENT
;

%%

int main(int argc, char** argv){
	printf("\n==========\n");
	yyparse();
	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
