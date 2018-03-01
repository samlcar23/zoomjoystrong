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

point:		POINT INT INT END_STATEMENT	{ point($2, $3); }
;

line:			LINE INT INT INT INT END_STATEMENT { line($2, $3, $4, $5); }
;

circle:		CIRCLE INT INT INT END_STATEMENT { circle($2, $3, $4); }
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT { rectangle($2, $3, $4, $5); }
;

set_color:		SET_COLOR INT INT INT END_STATEMENT { set_color($2, $3, $4); }
;

%%

int main(int argc, char** argv){
	printf("\n==========\n");
	printf("Hello\n");

	setup();

	yyparse();
	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
