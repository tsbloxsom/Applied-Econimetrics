* NOTE: You need to set the Stata working directory to the path
* where the data file is located.
####If you have a problem using this do file, I worked with Colby and Nicole so their do file is very similar###
set more off

clear
quietly infix               ///
  byte    age        63-64  ///
  byte    sex        65-65  ///
  int     race       66-68  ///
  int     uhrsworkt  69-71  ///
  int     educ       72-74  ///
  byte    wkswork1   75-76  ///
  long    incwage    77-83  ///
  using cps_18.dat

label var age       `"Age"'
label var sex       `"Sex"'
label var race      `"Race"'
label var uhrsworkt `"Hours usually worked per week at all jobs"'
label var educ      `"Educational attainment recode"'
label var wkswork1  `"Weeks worked last year"'
label var incwage   `"Wage and salary income"'

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define race_lbl 100 `"White"'
label define race_lbl 200 `"Black/Negro"', add
label define race_lbl 300 `"American Indian/Aleut/Eskimo"', add
label define race_lbl 650 `"Asian or Pacific Islander"', add
label define race_lbl 651 `"Asian only"', add
label define race_lbl 652 `"Hawaiian/Pacific Islander only"', add
label define race_lbl 700 `"Other (single) race, n.e.c."', add
label define race_lbl 801 `"White-Black"', add
label define race_lbl 802 `"White-American Indian"', add
label define race_lbl 803 `"White-Asian"', add
label define race_lbl 804 `"White-Hawaiian/Pacific Islander"', add
label define race_lbl 805 `"Black-American Indian"', add
label define race_lbl 806 `"Black-Asian"', add
label define race_lbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define race_lbl 808 `"American Indian-Asian"', add
label define race_lbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 810 `"White-Black-American Indian"', add
label define race_lbl 811 `"White-Black-Asian"', add
label define race_lbl 812 `"White-American Indian-Asian"', add
label define race_lbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 814 `"White-Black-American Indian-Asian"', add
label define race_lbl 815 `"American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 816 `"White-Black--Hawaiian/Pacific Islander"', add
label define race_lbl 817 `"White-American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 818 `"Black-American Indian-Asian"', add
label define race_lbl 819 `"White-American Indian-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 820 `"Two or three races, unspecified"', add
label define race_lbl 830 `"Four or five races, unspecified"', add
label define race_lbl 999 `"Blank"', add
label values race race_lbl

label define uhrsworkt_lbl 997 `"Hours vary"'
label define uhrsworkt_lbl 999 `"NIU"', add
label values uhrsworkt uhrsworkt_lbl

label define educ_lbl 000 `"NIU or no schooling"'
label define educ_lbl 001 `"NIU or blank"', add
label define educ_lbl 002 `"None or preschool"', add
label define educ_lbl 010 `"Grades 1, 2, 3, or 4"', add
label define educ_lbl 011 `"Grade 1"', add
label define educ_lbl 012 `"Grade 2"', add
label define educ_lbl 013 `"Grade 3"', add
label define educ_lbl 014 `"Grade 4"', add
label define educ_lbl 020 `"Grades 5 or 6"', add
label define educ_lbl 021 `"Grade 5"', add
label define educ_lbl 022 `"Grade 6"', add
label define educ_lbl 030 `"Grades 7 or 8"', add
label define educ_lbl 031 `"Grade 7"', add
label define educ_lbl 032 `"Grade 8"', add
label define educ_lbl 040 `"Grade 9"', add
label define educ_lbl 050 `"Grade 10"', add
label define educ_lbl 060 `"Grade 11"', add
label define educ_lbl 070 `"Grade 12"', add
label define educ_lbl 071 `"12th grade, no diploma"', add
label define educ_lbl 072 `"12th grade, diploma unclear"', add
label define educ_lbl 073 `"High school diploma or equivalent"', add
label define educ_lbl 080 `"1 year of college"', add
label define educ_lbl 081 `"Some college but no degree"', add
label define educ_lbl 090 `"2 years of college"', add
label define educ_lbl 091 `"Associate's degree, occupational/vocational program"', add
label define educ_lbl 092 `"Associate's degree, academic program"', add
label define educ_lbl 100 `"3 years of college"', add
label define educ_lbl 110 `"4 years of college"', add
label define educ_lbl 111 `"Bachelor's degree"', add
label define educ_lbl 120 `"5+ years of college"', add
label define educ_lbl 121 `"5 years of college"', add
label define educ_lbl 122 `"6+ years of college"', add
label define educ_lbl 123 `"Master's degree"', add
label define educ_lbl 124 `"Professional school degree"', add
label define educ_lbl 125 `"Doctorate degree"', add
label define educ_lbl 999 `"Missing/Unknown"', add
label values educ educ_lbl

save cps_18.dat,replace

###Q2###
use cps_18.dta, clear
d
gen lwage2 = log(incwage / (uhrsworkt * wkswork1)) 
gen white = 0
replace white = 1 if race == 100
gen black = 0
replace black = 1 if race == 200
gen other = 0
replace other = 1 if race != 100 & race != 200

label list educ_lbl
gen educ_new = 0
replace educ_new = 0 if educ == 0 | educ == 1 | educ == 2 | educ == 999
replace educ_new = 1 if educ == 11 
replace educ_new = 2 if educ == 12
replace educ_new = 2.5 if educ == 10
replace educ_new = 3 if educ == 13
replace educ_new = 4 if educ == 14
replace educ_new = 5 if educ == 21
replace educ_new = 5.5 if educ == 20
replace educ_new = 6 if educ == 22
replace educ_new = 7 if educ == 31
replace educ_new = 7.5 if educ == 30
replace educ_new = 8 if educ == 32
replace educ_new = 9 if educ == 40
replace educ_new = 10 if educ == 50
replace educ_new = 11 if educ == 60
replace educ_new = 12 if educ == 70 | educ == 71 | educ == 72 | educ == 73
replace educ_new = 13 if educ == 80
replace educ_new = 14 if educ == 81 | educ == 90 | educ == 91 | educ == 92
replace educ_new = 15 if educ == 100
replace educ_new = 16 if educ == 110 | educ == 111
replace educ_new = 17 if educ == 120 | educ == 121
replace educ_new = 18 if educ == 122 | educ == 123 | educ == 124
replace educ_new = 21 if educ == 125

gen pot_exper = age - educ_new - 5
gen pot_exper_sq = (age - educ_new - 5)^2

drop if wkswork1 < 50 
drop if uhrsworkt < 35 
drop if uhrsworkt == 997 
drop if uhrsworkt == 999

sum

table sex
table race
sum uhrsworkt, d
count if uhrsworkt == 999

###Q3###
sum
reg lwage2 educ_new, beta
sum educ_new if !missing(lwage)
display (2.762406)^2 * .1024975  /*###finds cov(x,y) using beta1 and variance of x###*/
display .78214683 / (2.762406*.7316781)   /*###finds cor(x,y) using cov and st dev of x and y###*/
display (.38697305)^2

###Q4###
reg lwage2 educ_new pot_exper pot_exper_sq, r

###Q5###
reg lwage2 educ_new pot_exper pot_exper_sq black other sex, r

###Q6###
test sex == black

###Q7###
gen female = (sex ==2)
gen male = (sex == 1)
gen educ_male = educ_new * male 
reg lwage2 educ_new pot_exper pot_exper_sq black other sex educ_male, r

nlcom (_b[educ_new] + _b[educ_male]) / _b[educ_new]
nlcom _b[educ_new] / (_b[educ_new] + _b[educ_male])

###Q8###
use nlsy79.dta, clear
d
gen lwage = log(laborinc07 / hours07)
replace age79 = age79 + 28
gen pot_exper = age79 - educ - 5
sum pot_exper
gen pot_exper_sq = (pot_exper)^2
drop if hours07 / 50 < 35
sum 

###Q9###
reg lwage educ pot_exper pot_exper_sq male black hisp, r

###Q11###
reg lwage educ pot_exper pot_exper_sq male black hisp afqt81 educ_mom educ_dad, r

###Q12###
corr educ afqt81
corr afqt81 lwage
