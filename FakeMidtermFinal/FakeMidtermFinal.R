#' ---
#' title: "Regression and Other Stories: Fake midterm and final exam"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' ---

#' Fake dataset of 1000 students' scores on a midterm and final
#' exam. See Chapter 6 in Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)
# switch this to TRUE to save figures in separate files
savefigs <- FALSE

#' **Load packages**
library("rstanarm")

#' **Simulate fake data**
N <- 1000
# set the random seed to get reproducible results
# change the seed to experiment with variation due to random noise
set.seed(2243)
true_ability <- rnorm(N, 50, 10)
noise_1 <- rnorm(N, 0, 10)
noise_2 <- rnorm(N, 0, 10)
midterm <- true_ability + noise_1
final <- true_ability + noise_2
exams <- data.frame(midterm, final)

#' **Linear regression**
#' 
#' The option `refresh = 0` supresses the default Stan sampling
#' progress output. This is useful for small data with fast
#' computation. For more complex models and bigger data, it can be
#' useful to see the progress.
fit_1 <- stan_glm(final ~ midterm, data=exams, refresh = 0)
print(fit_1, digits=2)

#' **Plot midterm and final exam scores**
#+ eval=FALSE, include=FALSE
if (savefigs) pdf(here("FakeMidtermFinal/figs","FakeMidtermFinal1.pdf"), height=4, width=4)
#+
par(mar=c(3, 3, 2, 1), mgp=c(1.7, .5, 0), tck=-.01)
par(pty="s")
plot(midterm, final, xlab="Midterm exam score", ylab="Final exam score", xlim=c(0,100), ylim=c(0,100), xaxs="i", yaxs="i", xaxt="n", yaxt="n", pch=20, cex=.5)
x <- seq(0,100,20)
axis(1, x)
axis(2, x)
for (i in x){
  abline(h=i, col="gray70", lty=2)
  abline(v=i, col="gray70", lty=2)
}
abline(coef(fit_1))
#+ eval=FALSE, include=FALSE
if (savefigs) dev.off()
