#' ---
#' title: "Regression and Other Stories: KidIQ cross-validation"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' ---

#' Linear regression and K-fold cross-validation. See Chapter 11 in
#' Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)

#' **Load packages**
library("rprojroot")
root<-has_dirname("ROS-Examples")$make_fix_file()
library("rstanarm")
library("foreign")
# for reproducability
SEED <- 1507

#' **Load children's test scores data**
kidiq <- read.dta(file=root("KidIQ/data","kidiq.dta"))

#' **Bayesian regression with the original predictors**
stan_fit_3 <- stan_glm(kid_score ~ mom_hs + mom_iq, data=kidiq,
                       seed=SEED, refresh = 0)
print(stan_fit_3)

#' **Leave-one-out cross-validation**
loo3 <- loo(stan_fit_3)
loo3

#' **K-fold cross-validation**
kcv3 <- kfold(stan_fit_3)
kcv3
