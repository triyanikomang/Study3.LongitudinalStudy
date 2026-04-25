# Calculating Sample Size for Longitudinal Study: Microbiome Study
#
#
# Version:  1.0
#
# Date:     2026  Apr
# Author:   Komang Triyani (triyanikomang.kartinawati@mail.utoronto.ca)
#
# ==============================================================================

#== Objectives ==================================================================

# We will:
# 1. Data Loading
# 2. Calculate sample size for longitudinal study

# Notes = Baseline samples and attrition will be calculated from prior feasibility study 


# =    1  Data loading  =========================================================

# Set working directory if needed
setwd("C:/Users/ameth/Documents/GitHub/Study3.LongitudinalStudy")

#Import dataset to Global Environment: "migrowd_final.csv"
data <- migrowd_final

#Completed stool collection
View(data)
table(data$stool_collection_status, useNA = "ifany")
round(prop.table(table(data$stool_collection_status, useNA = "always")) * 100, 1)
#Stool non-completion was the primary contributor to participant-level attrition, 
#with 54.9% of enrolled participants (n = 139/253) failing to provide a usable stool sample. 

# =    2  Sample size calculation ===============================================
## 2.1. Per Time-Point Attrition and Longitudinal Adjustment
# = MiGrowD-L will collect data at three annual time points (TP1:8–9 years; TP2:10–11 years; TP3:12–13 years). 
# The overall attrition observed in MiGrowD (54.9%) was used to derive a per time-point attrition rate 
# for the longitudinal design, applying the compound attrition formula: r.TP = 1 - (1 - Attrition)^(1/TP)
# where Attrition 0.549 is the total observed attrition and TP = 3 is the number of time points. 
Attrition <- 0.549
TP <- 3
r.TP <- 1 - (1 - Attrition)^(1/TP)
round(r.TP, digit = 4)
percent.rTP <- round(r.TP, digit = 4)*100 #per time-point attrition (r.TP)ₚ ≈ 23.31% per year.

## 2.2 Projected Participant Retention Across Three Annual Time Points
# Baseline population = 500
N0 = 500
# Per time point attrition = 23.31%
percent.rTP

#With baseline population, we calculate mean of attrition for 3 timepoints
TP1 <- 100 - percent.rTP 
TP2 <- 100 - percent.rTP # TP2 = 76.69
TP3 <- TP2 - percent.rTP # TP3 = 53.38
mean.retention <- (TP1 + TP2 + TP3)/3 # mean.retention = 76.69
attrition.total <- mean.retention/100

## 2.3 Longitudinal Attrition
# = To maintain adequate statistical power in the context of longitudinal attrition, 
# the base sample size (N0 = 500) was divided with mean.retention
N.Total <- round(N0/attrition.total)
N.Total 

