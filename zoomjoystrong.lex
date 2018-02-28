%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%

([p][o][i][n][t])([ ][0-9]+[ ][0-9]+)								{return POINT;}
([l][i][n][e][ ][0-9]+[ ][0-9]+[ ][0-9]+[ ][0-9]+)					{return LINE;}
([c][i][r][c][l][e][ ][0-9]+[ ][0-9]+[ ][0-9]+)						{return CIRCLE;}
([r][e][c][t][a][n][g][l][e][ ][0-9]+[ ][0-9]+[ ][0-9]+[ ][0-9]+)	{return RECTANGLE;}
([s][e][t][_][c][o][l][o][r][ ][0-9]+[ ][0-9]+[ ][0-9]+)			{return SET_COLOR;}
([0-9]+)															{return INT;}
([0-9]+[.][0-9]+)													{return FLOAT;}
([q][u][i][t])														{return END;}
[;]																	{return END_STATEMENT;}
[\t\n]																;					

%%