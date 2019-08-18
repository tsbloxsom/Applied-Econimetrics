*\ problem set 6, truett bloxsom
*\ Q1
hist dist_from_cut,start(-2) w(.1) xline(0) 

*\Q2

gen cutoff_binary = 0
replace cutoff_binary = 1 if dist_from_cut >= 0
tab cutoff_binary

gen cut2 = (dist_from_cut)^2
gen cut3 = (dist_from_cut)^3

reg hsgrade_pct cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
reg male cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
reg age_at_entry cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
reg bpl_north_ame~a cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
reg english cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r

reg hsgrade_pct cutoff_binary dist_from_cut cut2 cut3, r
reg male cutoff_binary dist_from_cut cut2 cut3, r
reg age_at_entry cutoff_binary dist_from_cut cut2 cut3, r
reg bpl_north_ame~a cutoff_binary dist_from_cut cut2 cut3, r
reg english cutoff_binary dist_from_cut cut2 cut3, r

*\Q3

reg probation_year1 cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
reg probation_ever cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r

reg probation_year1 cutoff_binary dist_from_cut cut2 cut3, r
reg probation_ever cutoff_binary dist_from_cut cut2 cut3, r

*\Q4

gen bin2 = floor(dist_from_cut*10)/10

bysort bin2: egen proby1_mean = mean(probation_year1)
bysort bin2: egen probever_mean = mean(probation_ever)

reg probation_year1 cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
predict proby1_lin
reg probation_ever cutoff_binary dist_from_cut if dist_from_cut > -.6 & dist_from_cut < .6, r
predict probever_lin

gen cutb_dist = cutoff_binary*dist_from_cut
gen cutb_cut2 = cutoff_binary*cut2
gen cutb_cut3 = cutoff_binary*cut3

reg probation_year1 cutoff_binary dist_from_cut cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r
predict proby1_poly
reg probation_ever cutoff_binary dist_from_cut cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r
predict probever_poly


twoway (scatter proby1_mean bin) (line proby1_poly dist_from_cut if dist_from_cut >= 0) (line proby1_poly dist_from_cut if dist_from_cut < 0) (line proby1_lin dist_from_cut if dist_from_cut >= 0 & dist_from_cut < .6) (line proby1_lin dist_from_cut if dist_from_cut < 0 & dist_from_cut > -.6)
twoway (scatter probever_mean bin) (line probever_poly dist_from_cut if dist_from_cut >= 0) (line probever_poly dist_from_cut if dist_from_cut < 0) (line probever_lin dist_from_cut if dist_from_cut >= 0 & dist_from_cut < .6) (line probever_lin dist_from_cut if dist_from_cut < 0 & dist_from_cut > -.6)

*\Q5


reg nextGPA cutoff_binary dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r
reg left_school cutoff_binary dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r

reg nextGPA cutoff_binary dist_from_cut cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r
reg left_school cutoff_binary dist_from_cut cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r

*\Q6
gen hsmean2 = 0
replace hsmean2 = 1 if hsgrade_pct >= 50
tab hsmean2


bysort hsmean2: reg gradin4 cutoff_binary dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r
bysort hsmean2: reg gradin5 cutoff_binary dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r
bysort hsmean2: reg gradin6 cutoff_binary dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r

*\Q7

ivregress 2sls gradin4 (probation_ever = cutoff_binary) dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r
ivregress 2sls gradin5 (probation_ever = cutoff_binary) dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r
ivregress 2sls gradin6 (probation_ever = cutoff_binary) dist_from_cut cutb_dist if dist_from_cut > -.6 & dist_from_cut < .6, r

ivregress 2sls gradin4 (probation_ever = cutoff_binary) dist_from_cut cutb_dist cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r
ivregress 2sls gradin5 (probation_ever = cutoff_binary) dist_from_cut cutb_dist cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r
ivregress 2sls gradin6 (probation_ever = cutoff_binary) dist_from_cut cutb_dist cut2 cut3 cutb_dist cutb_cut2 cutb_cut3, r



