knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(Hmisc)
library(gmodels)
library(ggplot2)
library(tidyverse)
library(beeswarm)
setwd("C:/Users/linan/Documents/GitHub/diabetes-log-regression-modelling")
db <- read.csv(file= "C:/Users/linan/Documents/GitHub/diabetes-log-regression-modelling/diabeteslog.csv", header = TRUE, sep = ",")
# Dimensions of the dataset
dim(db)

# Structure of the dataset
str(db)

# First few rows of the dataset
head(db)

# Concise summary of the dataset
glimpse(db)

# Summary statistics
summary(db)

db$gender <- as.factor(db$gender)
db$smoking <- as.factor(db$smoking)
db$chol <- as.numeric(db$chol)
db$bp.1s <- as.numeric(db$bp.1s)
db$age <- as.numeric(db$age)
db$weight <- as.numeric(db$weight)
db$height <- as.numeric(db$height)
db$waist <- as.numeric(db$waist)
db$dm <- as.factor(db$dm)
summary(db)
t <- table(db$gender, exclude = NULL)
t
round(100*prop.table(t), digits = 2)
x <- table(db$dm)
x
round(100*prop.table(x), digits = 2)
summary(db$chol)
summary(db$weight)
summary(db$height)
height.si <- db$height*0.0254
weight.si <- db$weight*0.453592
db$bmi <- weight.si/height.si^2
summary(db$bmi)
bmi <- db$bmi

db$bmi_cat <- ifelse(bmi<18.5, "underweight",
                  ifelse(bmi >= 18.5 & bmi <=25, "normal",
                         ifelse(bmi > 25 & bmi <= 30, "overweight",
                                ifelse(bmi > 30, "obese", NA))))

db$bmi_cat <- as.factor(db$bmi_cat)

bmicat <- table(db$bmi_cat)

bmicat

round(100*prop.table(bmicat), digits=2)
summary(db)
#Frequencies of diabetes by BMI category

dm_by_bmi_cat <- table(db$bmi_cat, db$dm, exclude = NULL)

dm_by_bmi_cat

#Age group
age <- db$age

db$age_group <- ifelse(age<45, "<45",
                  ifelse(age >= 45 & age <65, "45-64",
                         ifelse(age >= 65 & age <75, "65-74",
                                ifelse(age >= 75, ">=75", NA))))

db$age_group <- as.factor(db$age_group)

agecat <- table(db$age_group)

agecat

round(100*prop.table(agecat), digits=2)
#Frequencies of age group by gender

agegroup_by_gender <- table(db$age_group, db$gender, exclude = NULL)

agegroup_by_gender

round(100*prop.table(agegroup_by_gender), digits = 2)

glm(db$dm~1, family = binomial (link=logit))
m <- glm(db$dm~1, family=binomial(link=logit))
summary(m)
table(m$y)
# Gender variable
n <- glm(db$dm ~ db$gender, family = binomial (link=logit))
summary(n)
exp(n$coefficient)
exp(confint(n))
levels(db$gender)
gender <- relevel(db$gender, ref = "male")
levels(db$gender)
n <- glm(db$dm~db$gender, family = binomial (link=logit))
summary(n)
dm_by_age <- table(db$age, db$dm)

freq_table <- prop.table(dm_by_age, margin = 1)

odds <- freq_table[,"yes"]/freq_table[,"no"]

logodds <- log(odds)

plot(rownames(freq_table), logodds)
# Age variable
l <- glm(db$dm~db$age, family = binomial (link = logit))
summary(l)
exp(l$coefficient)
exp(confint(l))
hist(db$age)
d <- density(db$age)
plot(d, main = "Density of Age")
b <- density(db$bmi, na.rm = TRUE)
plot(b, main = "Density of BMI")
b <- glm(db$dm ~ db$bmi, family = binomial (link = logit))
summary(b)
exp(b$coefficients)
exp(confint(b))
db$hdl <- as.numeric(db$hdl)
h <- density(db$hdl, na.rm = TRUE)
plot(h, main = "Density of HDL")
h <- glm(db$dm ~ db$hdl, family = binomial(link = logit))
summary(h)
exp(h$coefficients)
db$chol <- as.numeric(db$chol)
c <- density(db$chol, na.rm = TRUE)
plot(c, main = "Density of Cholesterol")
chol <- glm(db$dm~db$chol, family = binomial(link = logit))
summary(chol)
exp(chol$coefficient)
exp(confint(chol))
# Odds of male and female
# Create crosstable
odds_gender <- table(db$gender, db$dm)

# calculate the frequency
dm_gender_prop <- prop.table(odds_gender, margin = 1)

# calculate the odds
odds_dm_gender <- dm_gender_prop[,"yes"]/dm_gender_prop[,"no"]

# log the odds
logodds_gender <- log(odds_dm_gender)

# plot the logodds
dotchart(logodds_gender)
# create crosstab
dm_by_age <- table(db$age, db$dm)

# calculate frequency
dm_by_age_prop <- prop.table(dm_by_age, margin = 1)

# calculate the odds
odds_age <- dm_by_age_prop[,"yes"]/dm_by_age_prop[,"no"]

# log the odds
logodds_age <- log(odds_age)

# plot the age against the odds of having diabetes
plot(rownames(dm_by_age_prop), logodds_age)

# create crosstab
dm_by_age_group <- table(db$age_group, db$dm)

# calculate frequency
dm_by_agegroup_prop <- prop.table(dm_by_age_group, margin = 1)

# calculate the odds
odds_age_group <- dm_by_agegroup_prop[,"yes"]/dm_by_agegroup_prop[,"no"]

# log the odds
logodds_agegroup <- log(odds_age_group)

# plot the age against the odds of having diabetes
dotchart(logodds_agegroup)

# create crosstab for cholesterol
dm_by_chol <- table(db$chol, db$dm)

# calculate frequency
dm_by_chol_prop <- prop.table(dm_by_chol, margin = 1)

# calculate the odds
odds_chol <- dm_by_chol_prop[,"yes"]/dm_by_chol_prop[,"no"]

# log the odds
logodds_chol <- log(odds_chol)

# plot the age against the odds of having diabetes
plot(rownames(dm_by_chol_prop), logodds_chol, xlim = c(150,300))

# Dm by cholesterol group 
db$chol_cat <- ifelse(db$chol < 200, "normal",
                      ifelse(db$chol <240, "borderline high",
                             ifelse(db$chol > 240, "high", NA))) 

# chol_cat as categorical with order level
db$chol_cat <- factor(db$chol_cat, levels = c("normal","borderline high","high"))

#create a crosstab for dm and chol_cat
dm_by_cholcat <- table(db$chol_cat, db$dm)

# calculate the frequency for dm and chol_cat
dm_by_cholcat_prop <- prop.table(dm_by_cholcat, margin = 1)

# calculate the odds of having diabetes per chol_categories
odds_cholcat <- dm_by_cholcat_prop[,"yes"]/ dm_by_cholcat_prop[,"no"]

# calculate the logodds
logodds_cholcat <- log(odds_cholcat)

# create chart
dotchart(logodds_cholcat)


# create crosstab
dm_by_hdl <- table(db$hdl, db$dm)

# calculate frequency
dm_by_hdl_prop <- prop.table(dm_by_hdl, margin = 1)

# calculate the odds
odds_hdl <- dm_by_hdl_prop[,"yes"]/dm_by_hdl_prop[,"no"]

# log the odds
logodds_hdl <- log(odds_hdl)

# plot the age against the odds of having diabetes
plot(rownames(dm_by_hdl_prop), logodds_hdl)
# Using categorized HDL
db$hdl_cat <- ifelse(db$hdl < 40, "low",
                     ifelse(db$hdl >= 40 & db$hdl <60, "normal",
                            ifelse(db$hdl >= 60, "high", NA)))

# use as factor
db$hdl_cat <- factor(db$hdl_cat, levels = c("low","normal","high"))

#create crosstab
db_by_hdlcat <- table(db$hdl_cat, db$dm)

# create prop table
db_by_hdlcat_prop <- prop.table(db_by_hdlcat, margin = 1)

# calculate the odds of having diabetes 
odds_hdlcat <- db_by_hdlcat_prop[,"yes"]/db_by_hdlcat_prop[,"no"]

# calculate the logodds
logodds_hdlcat = log(odds_hdlcat)

# plot the result
dotchart(logodds_hdlcat)
# create crosstab
dm_by_bmi <- table(db$bmi, db$dm)

# create prop table for bmi and dm
dm_by_bmi_prop <- prop.table(dm_by_bmi, margin = 1)
  
# calculate odds of dm by bmi
dm_by_bmi_odds <- dm_by_bmi_prop[,"yes"]/dm_by_bmi_prop[,"no"]

# calculate log odds of dm by bmi
logodds_bmi <- log(dm_by_bmi_odds)

# plot log odds of bmi and 
plot(rownames(dm_by_bmi_prop), logodds_bmi)
bmi_cat <- factor(db$bmi_cat, levels = c("underweight","normal","overweight","obese"))

# create crosstab for BMI categories and diabetes status
dm_by_bmi_cat <- table(db$bmi_cat, db$dm)

# create prop table for dm by cat
dm_by_bmi_cat_prop <- prop.table(dm_by_bmi_cat, margin = 1)

# calculate odds of DM by bmi cat
odds_dm_by_bmi_cat <- dm_by_bmi_cat_prop[,"yes"]/dm_by_bmi_cat_prop[,"no"]

# calculate log odds of dm by bmi cat
logodds_bmi_cat <- log(odds_dm_by_bmi_cat)

# plot the prop and logodds
dotchart(logodds_bmi_cat)

cor.test(db$hdl, db$chol, method = "pearson")
my_data<-db[,c("chol","hdl","glyhb","age","height","weight","bp.1s","bmi")]
cor_matrix <- cor(my_data, use = "complete.obs")
round(cor_matrix,4)
library(corrplot)

corrplot(cor_matrix, method = "color") #circle,color, pie
#Multiple Logistic Regression : age, gender and bmi as predictors
mlogr <- glm(db$dm~db$age+db$gender+db$bmi, family=binomial(link=logit))
summary(mlogr)
exp(mlogr$coefficient)
exp(confint(mlogr))
# Identify rows with missing values
rows_with_missing <- db[!complete.cases(db), ]

rows_with_missing

# Check for missing values in each column
missing_values <- colSums(is.na(db))

missing_values
# Calculate McFadden R-squared
# R2 = 1-logLik(fullmodel)/logLik(nullmodel) #Here, full model is mlogr and null model is m
R2 <- 1-logLik(mlogr)/logLik(m)
R2

# Calculate the c-statistics using 'Desctool' package
library(DescTools)
Cstat(mlogr)
# H-L test
require(ResourceSelection)

mlogr$y
#Run Hosmer-Lemeshow test

HL <- hoslem.test(x=mlogr$y, y=fitted(mlogr), g=10)
HL
# Plot the bserved vs expected number of cases for each of the groups
plot(HL$observed[,"y1"], HL$expected[,"yhat1"])
plot(HL$observed[,"y0"],HL$expected[,"yhat0"])
# plot observed vs. expected prevalence for each of the 10 groups 
plot(x = HL$observed[,"y1"]/(HL$observed[,"y1"]+HL$observed[,"y0"]), 
     y = HL$expected[,"yhat1"]/(HL$expected[,"yhat1"]+HL$expected[,"yhat0"])) 
# goodness of Fit test using generalhoslem package
require(generalhoslem)
logitgof(obs = mlogr$y, exp = fitted(mlogr), g=10)
#Analyze table of deviance
anova(mlogr, test="Chisq")

db$location <- as.factor(db$location)
db$insurance <- as.factor(db$insurance)
db$fh <- as.factor(db$fh)
db$bp.1d <- as.numeric(db$bp.1d)
db$frame <- as.factor(db$frame)
model <- glm(db$dm~db$age+db$bmi+db$chol+db$hdl+db$bp.1s+db$bp.1d, family = binomial(link="logit"))
summary(model)
anova(model, test="Chisq")
model2 <- glm(db$dm~db$age+db$bmi+db$chol+db$hdl, family = binomial(link="logit"))
summary(model2)
vars <- db[,c("age","chol","hdl","bmi","bp.1s","bp.1d")]
round(cor(vars, use="complete.obs"), 3)
# Removing systolic from the model 
model3 <- glm(db$dm~db$age+db$bmi+db$chol+db$hdl+db$bp.1s, family = binomial(link="logit"))
summary(model3)
model4 <- glm(db$dm~db$age+db$bmi+db$chol+db$hdl+db$bp.1d+db$bp.1s+db$gender+db$location+db$insurance+db$smoking+db$frame, family=binomial(link="logit"))
summary(model4)
exp(model4$coefficient)
exp(confint(model4))
# dm by smoking
smoke <- table(db$dm, db$smoking, exclude = NULL)
smoke
round(100*prop.table(smoke), digits = 2)
model5 <- glm(db$dm~db$age+db$bmi+db$chol+db$hdl+db$bp.1d+db$bp.1s+db$gender+db$smoking+db$frame, family=binomial(link="logit"))
summary(model5)
model7 <- glm(db$dm~db$age+db$bmi+db$chol+db$hdl+db$bp.1s+db$gender+db$smoking, family=binomial(link="logit"))
summary(model7)
# Calculate McFadden R-squared
# R2 = 1-logLik(fullmodel)/logLik(nullmodel) #Here, full model is mlogr and null model is m
Rmodel4 <- 1-logLik(model4)/logLik(m)
Rmodel4

Cstat(model4)

HL4 <- hoslem.test(x=model4$y, y=fitted(model4), g=10)
HL4 
# Calculate McFadden R-squared
# R2 = 1-logLik(fullmodel)/logLik(nullmodel) #Here, full model is mlogr and null model is m
Rmodel2 <- 1-logLik(model2)/logLik(m)
Rmodel2

Cstat(model4)

HL2 <- hoslem.test(x=model2$y, y=fitted(model2), g=10)
HL2 
# Calculate McFadden R-squared
# R2 = 1-logLik(fullmodel)/logLik(nullmodel) #Here, full model is mlogr and null model is m
Rmodel7 <- 1-logLik(model7)/logLik(m)
Rmodel7

Cstat(model7)

HL7 <- hoslem.test(x=model7$y, y=fitted(model7), g=10)
HL7 
