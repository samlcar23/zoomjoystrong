%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start zipcode_list

%union {int i; float f;}

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

point_entry:		POINT INT INT END_STATEMENT
;

line_entry:			LINE INT INT INT INT END_STATEMENT
;

circle_entry:		CIRCLE INT INT INT END_STATEMENT
;

rectangle_entry:	RECTANGLE INT INT INT INT END_STATEMENT
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
