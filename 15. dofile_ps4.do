*\ Problem set 4 Truett Bloxsom (tsb962)
*\ Q1

*\use "\\tsclient\C\Users\tsblo\Google Drive\UT Spring 2019\Adv econimetrics\n
*\> lsy_deming.dta"

d
sum

gen white2 = 0
replace white2 = 1 if black == 0 & hispanic == 0

tabulate head_start black, row
tabulate head_start white2, row
tabulate head_start hispanic, row
tab white2
tab black
tab hispanic

tabulate head_start firstborn, row

tab head_start dadhome_0to3, col

*\ Q2
gen sample = 1
foreach var in hispanic black male firstborn lninc_0to3 momed lnbw {
replace sample = 0 if missing(`var')
} 

reg comp_score~6 head_start if sample == 1, cluster(mom_id)
reg comp_score~6 head_start if sample ==1, r
reg comp_score~6 head_start lninc if sample == 1, cluster(mom_id)

reg comp_score~6 head_start if sample == 1, cluster(mom_id)
reg comp_score~6 head_start if sample == 1, r

*\ Q3

xtset mom_id
xtreg comp_score~6 head_start if sample == 1, i(mom_id) re

*\ Q4

xtreg comp_score~6 head_start if sample == 1, i(mom_id) fe

xtreg comp_score~6 head_start hispanic black male firstborn lninc momed lnbw if sample == 1, i(mom_id) fe

xtreg comp_score~6 head_start male firstborn lninc lnbw if sample == 1, i(mom_id) fe

*\ Q5
reg male head_start if sample == 1, cluster(mom_id)
xtreg male head_start if sample == 1, fe

reg firstborn head_start if sample == 1, cluster(mom_id)
xtreg firstborn head_start if sample == 1, fe

reg lninc head_start if sample == 1, cluster(mom_id)
xtreg lninc head_start if sample == 1, fe

reg lnbw head_start if sample == 1, cluster(mom_id)
xtreg lnbw head_start if sample == 1, fe


*\ Q6

sum comp_score~6
gen comp_score6_standard = (comp_score_5to6 - r(mean))/r(sd)
sum comp_score~10
gen comp_score10_standard = (comp_score_7to10 - r(mean))/r(sd)
sum comp_score~14 
gen comp_score14_standard = (comp_score_11to14 - r(mean))/r(sd)

xtreg comp_score6_standard head_start if sample == 1, i(mom_id) fe
xtreg comp_score10_standard head_start if sample == 1, i(mom_id) fe
xtreg comp_score14_standard head_start if sample == 1, i(mom_id) fe

*\ Q7
xtreg repeat head_start if sample == 1, fe
xtreg learndis head_start if sample == 1, i(mom_id) fe
xtreg hsgrad head_start if sample == 1, i(mom_id) fe
xtreg somecoll head_start if sample == 1, i(mom_id) fe
xtreg fphealth head_start if sample == 1, i(mom_id) fe


*\ Q8
gen male_head_start = male*head_start
xtreg repeat head_start male male_head_start if sample == 1, i(mom_id) fe
xtreg learndis head_start male male_head_start if sample == 1, i(mom_id) fe
xtreg hsgrad head_start male male_head_start if sample == 1, i(mom_id) fe
xtreg somecoll head_start male male_head_start if sample == 1, i(mom_id) fe
xtreg fphealth head_start male male_head_start if sample == 1, i(mom_id) fe

xtreg repeat head_start male if black == 1 & sample == 1, i(mom_id) fe
xtreg repeat head_start male if hispanic == 1 & sample == 1, i(mom_id) fe

xtreg learndis head_start male if black == 1 & sample == 1, i(mom_id) fe
xtreg learndis head_start male if hispanic == 1 & sample == 1, i(mom_id) fe

xtreg hsgrad head_start male if black == 1 & sample == 1, i(mom_id) fe
xtreg hsgrad head_start male if hispanic == 1 & sample == 1, i(mom_id) fe

xtreg somecoll head_start male if black == 1 & sample == 1, i(mom_id) fe
xtreg somecoll head_start male if hispanic == 1 & sample == 1, i(mom_id) fe

xtreg fphealth head_start male if black == 1 & sample == 1, i(mom_id) fe
xtreg fphealth head_start male if hispanic == 1 & sample == 1, i(mom_id) fe

*\ Q9

xtreg comp_score~6 head_start male firstborn lninc lnbw dadhome_0to3 ppvt_3, i(mom_id) fe
xtreg repeat head_start male firstborn lninc lnbw dadhome_0to3 ppvt_3, i(mom_id) fe
xtreg learndis head_start male firstborn lninc lnbw dadhome_0to3 ppvt_3, i(mom_id) fe
xtreg hsgrad head_start male firstborn lninc lnbw dadhome_0to3 ppvt_3, i(mom_id) fe
xtreg somecoll head_start male firstborn lninc lnbw dadhome_0to3 ppvt_3, i(mom_id) fe
xtreg fphealth head_start male firstborn lninc lnbw dadhome_0to3 ppvt_3, i(mom_id) fe

gen miss_dad = 0
replace miss_dad = 1 if dadhome_0to3 == .

gen miss_score = 0
replace miss_score = 1 if ppvt_3 == .

reg head_start miss_dad miss_score, r
