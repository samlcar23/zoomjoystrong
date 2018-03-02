%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int validLocation(int x, int y);
	int validColor(int r, int g, int b);
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

set_color:	SET_COLOR INT INT INT END_STATEMENT { 
				if(validColor($2, $3, $4) == 1){
					set_color($2, $3, $4); 
				} else {
					finish();
				}
			}
;

point:		POINT INT INT END_STATEMENT	{ 
					
				if(validLocation($2, $3) == 1){
					point($2, $3);
				}
			}
;

line:			LINE INT INT INT INT END_STATEMENT { 
				
				if(validLocation($2, $3) == 1){
					if(validLocation($4, $5) == 1){
						line($2, $3, $4, $5);
					}
				}
			}
;

circle:		CIRCLE INT INT INT END_STATEMENT { 
				if(validLocation($2, $3) == 1){
					circle($2, $3, $4);
				}
			}
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT {
				if(validLocation($2, $3) == 1){
					rectangle($2, $3, $4, $5);
				}
			}
;


%%

/*******************************************************************
* Main prints out a welcome message and starts the program.
********************************************************************/
int main(int argc, char** argv){
	printf("===============================================\n");
	printf("Welcome to ZoomJoyStrong! A fun game (sort of)!\n");

	setup();

	yyparse();
	return 0;
}

/*****************************************************************
*yyerror prints out an error message.
*
* @param msg a message to print
*****************************************************************/
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
	yyparse();
}

/****************************************************************
* validLocation checks to see if the provided point is within
* the window.
*
*@param x the x coordinate
*@param y the y coordinate
*@return 0 for invalid location and 1 for valid location
****************************************************************/
int validLocation(int x, int y){
	if((0 <= x && x <= WIDTH) && (0 <= y && y <= HEIGHT)){
		return 1;
	} else {
		printf("(%d, %d) is not a valid location.\nClosing Program.\n", x, y);
		return 0;
	}
}

/****************************************************************
* validColor checks to see if the rgb value is between 0 and 255.
*
*@param r the r value
*@param g the g value
*@param b the b value
*@return 0 for invalid color and 1 for valid color
****************************************************************/
int validColor(int r, int g, int b){
	if (r < 0 || r > 255) {
		printf("The value of r (%d) in rgb is not valid.\n", r);
		return 0;
	} else if (g < 0 || g > 255) {
		printf("The value of g (%d) in rgb is not valid.\n", g);
		return 0;
	} else if (b < 0 || b > 255) {
		printf("The value of b (%d) in rgb is not valid.\n", b);
		return 0;
	} else {
		return 1;
	}
}
