data survey;
infile"D:\大三\多變量\mydata\data2.csv" dsd firstobs=2;
input x1-x7;
proc print data=survey;
run;

ods pdf file="C:\Users\lab-116\Desktop\pc.pdf";
proc princomp data=survey out=pc;
var x1-x7;
proc print;
var x1-x7 prin1-prin3;
run;
ods pdf close;

ods pdf file="C:\Users\lab-116\Desktop\factor-pc.pdf";
proc princomp data=survey;
var x1-x7;
run;
proc factor res
method=prinit heywood nfact=3 rotate=varimax scree preplot plot;
var x1-x7;
run;
ods pdf close;

ods pdf file="C:\Users\lab-116\Desktop\factor-ml.pdf";
proc factor res data=survey  score
method=ml heywood nfact=2 rotate=varimax preplot plot;
var x1-x7;
run;
ods pdf close;

data cluster;
infile"D:\大三\多變量\mydata\data2.csv" dsd firstobs=2;
input x1-x7 id;
run;
ods pdf file="C:\Users\user\mydataclust.pdf";
PROC CLUSTER DATA=cluster S STANDARD METHOD=AVERAGE
 RMSSTD RSQUARE OUTTREE=TREE;
VAR x1-x7;
ID id;
RUN; 
PROC PLOT DATA=TREE;
PLOT _SPRSQ_*_NCL_='*' _RSQ_*_NCL_='@'/ Overlay HAXIS=0 TO 16 BY 2;
RUN;
PROC TREE DATA=TREE OUT=TREEOUT NCLUSTERS=6;
COPY x1-x7;
ID id;
RUN;
PROC SORT DATA=TREEOUT; BY CLUSTER;
PROC PRINT DATA=TREEOUT;
var id CLUSTER;
PROC means data=TREEOUT;
VAR x1-x7;
By cluster;
RUN;
ods pdf close;
