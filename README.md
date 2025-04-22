🧪 Log-Regression-Diabetes

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

📊 Key Variables
dm: Presence of diabetes (Yes/No)

age: Age in years

gender: Male/Female

smoking: 1 = current, 2 = never, 3 = ex-smoker

bmi: Calculated using height and weight

hdl: High-density lipoprotein cholesterol

chol: Total cholesterol

bp.1s: Systolic blood pressure

📈 Highlights of Findings
Age and BMI are significant predictors of diabetes.

The odds of diabetes increase with age and BMI.

Males had slightly higher odds of diabetes, but the result was not statistically significant.

Higher HDL appears protective, while higher cholesterol is associated with increased odds of diabetes.

📦 Requirements
R (version ≥ 4.0)

R packages:

dplyr, ggplot2, Hmisc, gmodels, tidyverse, beeswarm

🗂 Data
The dataset diabeteslog.csv contains patient-level data and is used to conduct the logistic regression analysis. Some variables may contain missing values (e.g., dm).

Note: Ensure the dataset is in the correct path or update the setwd() and read.csv() paths accordingly.

🚀 How to Run
Open the .Rmd file in RStudio.

Ensure all required packages are installed.

Click Knit to generate an HTML report containing the analysis.

🧠 Author
Lina
