//Problem set 3 truett bloxsom

 use "\\tsclient\C\Users\tsblo\Google Drive\UT Spring 2019\Adv econimetrics\nhis2000.dta"

//Q1
d
label dir
label list health_lbl
gen poor_health = 0
replace poor_health = 1 if health == 4 | health == 5
sum 

//Q2
twoway (lpoly mort5 age if poor_health, degree(1)) (lpoly mort5 age if !poor_health, degree(1))

//Q3
tab faminc_20t75 faminc_gt75, mi

gen income = ""
	replace income = "less than 20k" if faminc_20t75 == 0 & faminc_gt75 == 0
	replace income = "20k - 75k" if faminc_20t75 == 1
	replace income = "greater than 75k" if faminc_gt75 == 1
	replace income = "missing" if faminc_20t75 == . & faminc_gt75 == .

graph bar mort5, by(income)
graph bar mort5 poor_health, by(income)
graph bar mort5, by(income poor_health)

gen educ = ""
	replace educ = "less than highschool" if edyrs < 12
	replace educ = "completed highschool" if edyrs == 12
	replace educ = "some college" if edyrs > 12 & edyrs < 16
	replace educ = "completed college" if edyrs == 16
	replace educ = "post-graduate study" if edyrs > 16
	
graph bar mort5 poor_health, by(educ)

//Q4
gen incomeLT20k = 0
	replace incomeLT20k = 1 if faminc_20t75 == 0 & faminc_gt75 == 0
gen income20kt75k = 0
	replace income20kt75k = 1 if faminc_20t75 == 1
gen incomeGT75k = 0
	replace incomeGT75k = 1 if faminc_gt75 == 1
gen income_missing = 0
	replace income_missing = 1 if faminc_20t75 == . & faminc_gt75 == .
	
gen black_hisp = 0
	replace black_hisp = 1 if black == 1 & hisp == 1
gen white_hisp = 0
	replace white_hisp = 1 if white == 1 & hisp == 1

replace white = 0 if white_hisp == 1
replace hisp = 0 if white_hisp == 1
replace black = 0 if black_hisp == 1
replace hisp = 0 if black_hisp == 1
	
reg mort5 age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r

probit mort5 age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

logit mort5 age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

reg poor_health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r

probit poor_health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

logit poor_health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

//Q5
probit mort5 age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r

lincom black + incomeGT75k

//Q6

//Q7 recode health variables
probit poor_health uninsured age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

reg uninsured incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
// I tried to run probit here but stata output said: "outcome does not vary"

gen smokeing = 0
	replace smokeing = 1 if smokev == 20 
	replace smokeing = . if smokev == .

probit smokeing age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

probit poor_health uninsured smokeing age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

//Q8
probit mort5 poor_health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

save temp,replace

probit mort5 health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r

foreach var of varlist age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp {
  sum `var'
  replace `var' = r(mean)
  }

predict z_hat
twoway scatter z_hat health
use temp, clear

probit mort5 health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

//Q9

oprobit health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r
margins, dydx(*)

probit poor_health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r


//Q10
save temp, replace 

oprobit health age edyrs incomeGT75k income20kt75k black hisp other black_hisp white_hisp if !income_missing, r

foreach var of varlist age edyrs incomeGT75k income20kt75k {
  sum `var'
  replace `var' = r(mean)
  }

predict health_hat1, outcome(1)
predict health_hat2, outcome(2)
predict health_hat3, outcome(3)
predict health_hat4, outcome(4)
predict health_hat5, outcome(5)

keep if white == 1 | black == 1
contract white black health_hat*
	drop _f
collapse (mean) health_hat*, by(white black)
reshape long health_hat, i(black white) j(health)

twoway (scatter health_hat health if white == 1, connect(1)) ///
	(scatter health_hat health if white == 0, connect(1)), ///
	legend(label(1 "white") label(2 "black"))
 

use temp, clear



graph bar black white, by(health) percent




