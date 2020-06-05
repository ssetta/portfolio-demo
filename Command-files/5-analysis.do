/*
Created by Richard Ball
This version:  2017-07-11
Written for Stata 14--SE, 64-bit, for Windows
*/

/*WHEN THIS DO-FILE IS RUN, STATA'S WORKING DIRECTORY 
SHOULD BE SET TO THE "Command-Files" FOLDER. */


*TABLE 1
*(USING COUNTRY-LEVEL DATA)
clear
set more off
use ../Analysis-Data/country-analysis.dta
list CountryName cm_satis inc exp, table clean noobs


*TABLE 2, COLUMN 1
*(USING INDIVIDUAL-LEVEL DATA)
clear
set more off
use ../Analysis-Data/individual-analysis.dta
regress satis age age2


*TABLE 2, COLUMN 2
*(USING INDIVIDUAL-LEVEL DATA)
clear
set more off
use ../Analysis-Data/individual-analysis.dta
xi: regress satis age age2 i.country


*FIGURE 1
*(USING COUNTRY-LEVEL DATA)
clear
set more off
use ../Analysis-Data/country-analysis.dta
scatter cm_satis inc, mlabel(CountryName) 


*FIGURE 2
*(USING COUNTRY-LEVEL DATA)
clear
set more off
use ../Analysis-Data/country-analysis.dta
scatter cm_satis exp, mlabel(CountryName) 


*TEXT ON PAGE 4 OF THE PAPER, STATING THAT,
*WHEN COUNTRY FIXED EFFECTS ARE  NOT INCLUDED IN THE REGRESSION,
*ESTIMATED AGE AT MINIMUM SWB IS ABOUT
*47 YEARS AND 9 MONTHS
*(USING INDIVIDUAL-LEVEL DATA) 
clear
set more off
use ../Analysis-Data/individual-analysis.dta
quietly regress satis age age2
scalar define b1=_coef[age]
scalar define b2=_coef[age2]
scalar define ageatminsatis=-b1/(2*b2)
scalar list ageatminsatis


*TEXT ON PAGE 4 OF THE PAPER, STATING THAT,
*WHEN COUNTRY FIXED EFFECTS ARE INCLUDED IN THE REGRESSION,
*THE ESTIMATED AGE AT MINIMUM SWB IS ABOUT
*53 YEARS AND 11 MONTHS
*(USING INDIVIDUAL-LEVEL DATA)
clear
set more off
use ../Analysis-Data/individual-analysis.dta
quietly xi: regress satis age age2 i.country
scalar define b1=_coef[age]
scalar define b2=_coef[age2]
scalar define ageatminsatis=-b1/(2*b2)
scalar list ageatminsatis

