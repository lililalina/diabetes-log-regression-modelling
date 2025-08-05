🧪 Factors Associated with Diabetes 

This project performs logistic regression modeling to explore factors associated with the presence of diabetes in a given dataset. The analysis is performed using R and includes exploratory data analysis (EDA), univariate and multivariate logistic regression, and data visualization.

📁 Project Structure
1. Data Import & Cleaning: Read CSV, convert data types, handle missing values.
2. Feature Engineering:
3. Conversion of imperial units (height/weight) to metric
4. BMI calculation and categorization
5. Age grouping
6. HDL and cholesterol categorization
7. Exploratory Data Analysis (EDA):
8. Summary statistics
9. Frequency tables and proportions
10. Visualization of variable distributions (e.g., density plots)
11. Logistic Regression Models:
12. Univariate regression for each predictor (age, gender, BMI, HDL, cholesterol)
13. Multiple logistic regression
14. Odds ratio and confidence interval calculation
15. Visualization:
16. Odds and log-odds plots by categorical and continuous variables
17. Dotcharts and logit plots for interpretability


📊 Variables
1. dm: Presence of diabetes (Yes/No)
2. age: Age in years
3. gender: Male/Female
4. smoking: 1 = current, 2 = never, 3 = ex-smoker
5. bmi: Calculated using height and weight
6. hdl: High-density lipoprotein cholesterol
7. chol: Total cholesterol
8. bp.1s: Systolic blood pressure


📈 Results Summary
1. Age and BMI were statistically significant predictors of diabetes:
Each additional year of age was associated with a 5.1% increase in the odds of diabetes (OR = 1.05, 95% CI: 1.03–1.08, p < 0.001).
Each one-unit increase in BMI increased the odds of diabetes by 5.4% (OR = 1.05, 95% CI: 1.00–1.11, p = 0.040).

2. Cholesterol level was positively associated with diabetes:
A 1 mg/dL increase in cholesterol was linked to a 1.1% increase in the odds of diabetes (OR = 1.011, 95% CI: 1.004–1.018, p = 0.002).
HDL cholesterol was protective:
Each 1 mg/dL increase in HDL was associated with a 2.8% decrease in the odds of diabetes (OR = 0.972, 95% CI: 0.951–0.992, p = 0.009).

3. Gender (male) had slightly higher odds of diabetes, but the result was not statistically significant (OR = 1.15, 95% CI: 0.58–2.28, p = 0.69).

4. Systolic blood pressure (BP) was not significantly associated with diabetes (OR = 1.006, 95% CI: 0.99–1.02, p = 0.42).

5. Smoking status was also not significantly associated with diabetes:
Former smokers: OR = 0.90, 95% CI: 0.45–1.86, p = 0.78
Current smokers: OR = 0.90, 95% CI: 0.33–2.34, p = 0.83



📦 Requirements
R (version ≥ 4.0)
R packages:
dplyr, ggplot2, Hmisc, gmodels, tidyverse, beeswarm



🚀 How to Run
Open the .Rmd file in RStudio.
Ensure all required packages are installed.

Click Knit to generate an HTML report containing the analysis.

🧠 Author
Lina
