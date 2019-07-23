//This do file presents solutions to ECO 348K Problem Set 1

//Open the dataset
use project_star_ps1,clear

/////////////
//Problem 1//
/////////////

//Describe the dataset to learn what variables are in it.
d

//Summarize the data.
sum

//The question asks about the characteristics of the population.
//Since the relevant variables are categorical, we will tabulate
//them to answer the question.

//First, we tabulate student sex. 51 percent of the sample is
//male, which does not seem unusual
tab ssex

//Next, we tabulate student race. 33 percent of the sample is 
//black, which is higher than the US average.
tab srace

//Next, we tabulate socio-economic status, as indicated by 
//free lunch. Nearly half of the sample receives free lunch,
//which suggests that the sample is fairly low income.
tab sesk

//Finally, we tabulate school location. The sample has schools
//in urban, suburban, and rural areas, with the last category
//accounting for nearly half the sample.
tab schtypek

//Overall, we can conclude that the sample has a relatively
//high share of students with minority or low SES background.
//The results will be most easily applied to similar populations.

/////////////
//Problem 2//
/////////////

//Initial assignment could differ from actual enrollment because
//some parents could try to 'correct' placements they disliked.
//This selective assignment to classrooms could invalidate
//random assignment, so that differences in student outcomes
//across classroom types may not reflect causal effects of 
//classroom type.

//Because the classroom types and student characeristics are 
//categorical, we use chi-squared tests of independence. The
//tests show no significant relationship between race or sex
//and classroom type, but a marginally significant relationship
//(p = 0.09) between free lunch receipt and classroom type.
//The last result is somewhat concerning, but it appears to
//reflect a high concentration of free lunch students in the
//regular+aide condition, with no difference between small
//and regular classes. 
tab cltypek srace,chi2 row nofreq
tab cltypek ssex,chi2 row nofreq
tab cltypek sesk,chi2 row nofreq

/////////////
//Problem 3//
/////////////

//We first summarize the data by classroom type. Mean test 
//scores are highest in small classes for both reading and math.
bysort cltypek: sum treadssk tmathssk

//Using the formula from Lecture Note 1, page 7, the t-statistic 
//for the small vs. regular difference in reading scores is:
disp (440.55-434.73)/sqrt(32.50^2/1739+30.94^2/2006)

//And the t-statistic for math scores is:
disp (490.93-483.19)/sqrt(49.51^2/1762+47.64^2/2032)

//Using t-tests, we obtain the same results. The very small
//differences starting at the third decimal point are due
//to degrees of freedom adjustments.
ttest treadssk if cltypek<3,by(cltypek) unequal
ttest tmathssk if cltypek<3,by(cltypek) unequal

//Both differences are highly statistically significant, with
//p-values of 0.0000. The difference in average reading scores 
//is 5.8 points, and the difference in average math scores is
//7.7 points, which is larger. However, we know from question 1 
//that the standard deviation of reading scores is 31.7, while 
//that of math scores is 47.7. So the reading score impact is
//0.18 standard deviations, while the math score impact is 0.16
//standard deviations, which are quite similar.

/////////////
//Problem 4//
/////////////

//We use the ttest command to test for differences
//between classroom types 2 and 3.
ttest treadssk if cltypek>1,by(cltypek) unequal
ttest tmathssk if cltypek>1,by(cltypek) unequal

//The results do not suggest that teachers aides improve 
//test scores. Both differences are insignificantly different
//from zero, and both are smaller than 0.03 test score 
//standard deviations.

/////////////
//Problem 5//
/////////////

//Separate tests for black and white students.
ttest tcombssk if cltypek<3&srace==1,by(cltypek) unequal
ttest tcombssk if cltypek<3&srace==2,by(cltypek) unequal

//The point estimate is larger for black students (srace=2)
//than white students (srace=1). Is the difference 
//statistically significant? We compute the t-statistic
//for the difference:

di (15.85-12.79)/sqrt(4.28^2+2.94^2)

//This t-statistic is much smaller than 1.64 or 1.96,
//the critical values for a two-sided test at 10% or 5%
//significance. We conclude that there is no significant
//heterogeneity by race.

//We do the same for poor and non-poor families, finding
//no significant difference in effects:
ttest tcombssk if cltypek<3&sesk==1,by(cltypek) unequal
ttest tcombssk if cltypek<3&sesk==2,by(cltypek) unequal
di (14.26-13.79)/sqrt(3.36^2+3.34^2)

/////////////
//Problem 6//
/////////////

//The t-tests above assume independence across students,
//which may be unreasonable because they share classroom
//environments. One way to correct for this issue is to
//collapse the data to classrooom averages:
collapse treadssk tmathssk cltypek,by(classid)
ttest treadssk if cltypek<3,by(cltypek) unequal
ttest tmathssk if cltypek<3,by(cltypek) unequal

//The point estimates are very similar to before, but the
//t-statistics are much smaller. The smaller t-statistics
//reflects a positive intra-classroom correlation in students'
//test scores. Despite these changes, however, the reading 
//score effect is still significant at the 2% level, and the 
//math score effect is still significant at the 6% level.

/////////////
//Problem 7//
/////////////

//We need to reopen the student-level dataset.
use project_star_ps1,clear

//For clarity (this is not necessary), we define a small
//classroom dummy, and we drop the regular+aide classes
//from the dataset.
gen small = (cltypek==1)
drop if cltypek==3

//To reproduce the individual-level results from question (3),
//we run the following regressions:
reg treadssk small,r
reg tmathssk small,r

//To reproduce the collapsed results from question (6), we
//first collapse the data to the classroom level and then 
//re-run the regressions:
collapse treadssk tmathssk small,by(classid)
reg treadssk small,r
reg tmathssk small,r

//The collapsed approach may be overly conservative because
//it does not allow for any independent information from 
//different students in the same class. An alternative is to
//run an individual-level regression with classroom clustering.
//To do this, we first open and set up our individual-level
//dataset again:
use project_star_ps1,clear
gen small = (cltypek==1)
drop if cltypek==3

//We then run regressions with clustered standard errors:
reg treadssk small,cluster(classid)
reg tmathssk small,cluster(classid)

//As expected, the t-statistics are between original individual
//and collapsed t-statistics. Both effects are now significant at
//the 5% level!

/////////////
//Problem 8//
/////////////

//To judge whether effects of 0.16-0.18 standard deviations are
//large or small, it is often useful to compare them to other test
//score gaps in the data.

//Black-white test score gaps are about twice as large as the 
//class size effects:
use project_star_ps1,clear
ttest treadssk if srace<3,by(srace) unequal
ttest tmathssk if srace<3,by(srace) unequal

//Test score gaps by school lunch receipt are about three times  
//as large as the class size effects:
ttest treadssk,by(sesk) unequal
ttest tmathssk,by(sesk) unequal

//Boy-girl test score gaps are about the same size as the 
//class size effects:
ttest treadssk,by(ssex) unequal
ttest tmathssk,by(ssex) unequal

//A reasonable conclusion is that the effect of class size on
//kindergarten test scores is meaningfully large but not revolutionary.






