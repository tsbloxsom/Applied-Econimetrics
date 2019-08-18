*\ Problem set 5 Truett Bloxsom
*\ Q1
sum
bysort birthyr: sum crimerate
bysort birthyr: sum conscripted

*\ Q2
reg crimerate conscripted indigenous naturalized i.birthyr, r
reg crimerate conscripted i.birthyr, r

reg property conscripted indigenous naturalized i.birthyr, r
reg murder conscripted indigenous naturalized i.birthyr, r
reg drug conscripted indigenous naturalized i.birthyr, r
reg sexual conscripted indigenous naturalized i.birthyr, r
reg threat conscripted indigenous naturalized i.birthyr, r
reg arms conscripted indigenous naturalized i.birthyr, r
reg whitecollar conscripted indigenous naturalized i.birthyr, r

*\ Q3
gen eligible = 0
	replace eligible = 1 if draftnumber >= 175 & birthyr == 1958
	replace eligible = 1 if draftnumber >= 320 & birthyr == 1959
	replace eligible = 1 if draftnumber >= 341 & birthyr == 1960
	replace eligible = 1 if draftnumber >= 350 & birthyr == 1961
	replace eligible = 1 if draftnumber >= 320 & birthyr == 1962
	
*\ Q4

reg conscripted eligible indigenous naturalized i.birthyr, r 
reg conscripted eligible i.birthyr, r

*\ Q5
reg crimerate eligible indigenous naturalized i.birthyr, r

reg property eligible indigenous naturalized i.birthyr, r
reg murder eligible indigenous naturalized i.birthyr, r
reg drug eligible indigenous naturalized i.birthyr, r
reg sexual eligible indigenous naturalized i.birthyr, r
reg threat eligible indigenous naturalized i.birthyr, r
reg arms eligible indigenous naturalized i.birthyr, r
reg whitecollar eligible indigenous naturalized i.birthyr, r

*\ Q6
*\ reduced form coefficent from Q5 / first stage(does not change) from Q4
display .0017608/.658733

display .0005417/.658733 
display -.0000476/.658733
display -.0000589 /.658733
display .0000886 /.658733
display .0001447/.658733
display .000088 /.658733
display .0004204 /.658733

*\ Q7
ivregress 2sls crimerate (conscripted = eligible) indigenous naturalized i.birthyr, r first
ivregress 2sls crimerate (conscripted = eligible), r first
reg crimerate conscripted indigenous naturalized i.birthyr, r

ivregress 2sls property (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg property conscripted indigenous naturalized i.birthyr, r
ivregress 2sls murder (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg murder conscripted indigenous naturalized i.birthyr, r
ivregress 2sls drug (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg drug conscripted indigenous naturalized i.birthyr, r
ivregress 2sls sexual (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg sexual conscripted indigenous naturalized i.birthyr, r
ivregress 2sls threat (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg threat conscripted indigenous naturalized i.birthyr, r
ivregress 2sls arms (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg arms conscripted indigenous naturalized i.birthyr, r
ivregress 2sls whitecollar (conscripted = eligible) indigenous naturalized i.birthyr, r first
reg whitecollar conscripted indigenous naturalized i.birthyr, r

*\ Q8

*\ Q9

*\ Q10











