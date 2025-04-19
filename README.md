# PHI Monthly Report

R Shiny app that generates the PHI monthly report: https://worldhealthorg.shinyapps.io/phi_report_shiny_app/ 
This app is runs 3 Rmd files to generate the PHI monthly report. The Rmd have the following roles:

1. `slides_overall_all_regions.Rmd` - main part of the report
2. `country_report.Rmd` - conclusion of the report
3. `country_conclusion.Rmd` - region-specific report


These Rmd's are built with officedown for Powerpoint and use a template file with the WHO style. Due to issues with the original WHO slide template, it was modified in order to be run with officedown.
The report has recently been modified to report the previous two months and compare with the previous 4 months before that (e.g in March, the report will report Januaury and February and compare with September-December). Some slides are placeholders with content that the PHI team adds by hand.

Inputs (all Excel files):
* Product tracker file
* DON tracker
* EIOS data All files can be provided by the PHI team.
* Signal Characterization tracker

