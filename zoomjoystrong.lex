%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%

point					{return POINT;}
line					{return LINE;}
circle					{return CIRCLE;}
rectangle				{return RECTANGLE;}
set_color				{return SET_COLOR;}
end						{return END;}
([0-9]+)				{return INT;}
([0-9]+[.][0-9]+)		{return FLOAT;}
;						{return END_STATEMENT;}
[\t\n]					;					

%%