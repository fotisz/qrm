## By Marius Hofert

## Why studying copulas: A motivating example


library(copula)

## Generate some data (just skip this step, let's pretend we don't see it)
n <- 1000 # sample size
set.seed(271) # for reproducibility
U <- rCopula(n, copula = gumbelCopula(iTau(gumbelCopula(), tau = 0.5))) # geek zone
X <- qnorm(U) # quantile transformation
X. <- qexp(U) # quantile transformation

## Plots
layout(rbind(1:2))
plot(X,  xlab = expression(X[1]),     ylab = expression(X[2]))
plot(X., xlab = expression(X[1]*"'"), ylab = expression(X[2]*"'"))

## Q: For which data is the dependence between the two variables "larger"?

## This is difficult to answer, as both axis show different scales/ranges etc.
## We can transform the data to have the same marginals by using the probability
## transformation. Instead of ("cheating" by) using the above chosen marginal
## distribution functions (dfs), we make the realistic assumption that we don't
## know them, so we would estimate them by their empirical dfs (edfs) and then
## apply these marginal empirical dfs to the respective data columns. The function
## pobs() of the R package indirectly does that for you; see (*) for the 'why'.
## By the probability transformation, we then get the the marginal dfs of both
## data sets X and X. are (approximately) U(0,1), so allow for a comparison.
U  <- pobs(X)
U. <- pobs(X.)
## (*) Applying the edf \hat{F}_{n,j} of the jth margin to the data X_{ij},
## i in {1,..,n}, we obtain U_{ij} = \hat{F}_{n,j}(X_ij)
## = (1/n)\sum_{k=1}^n \I_{\{X_{kj} \le X_{ij}\}} = R_{ij}/n, where R_{ij}
## denotes the rank of X_{ij} among X_{1j},..,X_{nj}. One then typically uses
## the slightly scaled version R_{ij}/(n+1) to avoid that that U_{ij} can be 1
## (so on the boundary of [0,1]^d). The function pobs() computes exactly that.

## Now plot the pseudo-observations
plot(U,  xlab = expression(U[1]),     ylab = expression(U[2]))
plot(U., xlab = expression(U[1]*"'"), ylab = expression(U[2]*"'"))

## A: The dependence between the components (= columns) of X and X. is the same!
##    Therefore, in order to study dependence (independently of the margins),
##    we need to study the distributions of random vectors with U(0,1) marginals,
##    hence copulas.

## Visually check whether the margins are indeed (approximately) U(0,1)
layout(matrix(1:4, ncol = 2))
plot(U[,1],  ylab = expression(U[1]))
plot(U[,2],  ylab = expression(U[2]))
plot(U.[,1], ylab = expression(U[1]*"'"))
plot(U.[,2], ylab = expression(U[2]*"'"))
## Hence U and U. above are "pseudo"-observations (hence the name "pobs") of the
## underlying copulas. They give us insight in the actual dependence structure
## (copula) underlying our data sets X and X.
