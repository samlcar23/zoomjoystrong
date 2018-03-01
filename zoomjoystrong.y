%{
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start zipcode_list

%union {long i; char* str; double d;}

%token LINE
%token POINT
%token RECTANGLE
%token CIRCLE
%token SET_COLOR

%type<i> INT
%type<f> FLOAT



%%
zipcode_list:		zipcode_entry
				|	zipcode_entry zipcode_list
;

zipcode_entry:		TEXT SEPARATOR TEXT SEPARATOR TEXT SEPARATOR TEXT SEPARATOR TEXT SEPARATOR DOUBLE SEPARATOR DOUBLE SEPARATOR TEXT SEPARATOR TEXT SEPARATOR LONG SEPARATOR LONG SEPARATOR LONG SEPARATOR
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
