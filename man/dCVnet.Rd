% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dCVnet_main.R
\name{dCVnet}
\alias{dCVnet}
\title{Fit a doubly cross-validated elastic-net regularised logistic regression}
\usage{
dCVnet(
  y,
  data,
  f = "~.",
  nrep_outer = 2,
  k_outer = 10,
  nrep_inner = 5,
  k_inner = 10,
  alphalist = c(0.2, 0.5, 0.8),
  nlambda = 100,
  type.measure = "deviance",
  family = "binomial",
  offset = NULL,
  opt.lambda.type = c("min", "1se"),
  opt.empirical_cutoff = FALSE,
  opt.uniquefolds = FALSE,
  opt.ystratify = TRUE,
  ...
)
}
\arguments{
\item{y}{the outcome (can be numeric vector,
a factor (for binomial / multinomial) or a matrix for cox/mgaussian)
For factors see Factor Outcomes section below.}

\item{data}{a data.frame containing variables needed for the formula (f).}

\item{f}{a one sided formula.
The RHS must refer to columns in \code{data} and may include
interactions, transformations or expansions (like \code{\link{poly}}, or
\code{\link{log}}).
The formula \emph{must} include an intercept.}

\item{nrep_outer}{an integer, the number of repetitions (k-fold outer CV)}

\item{k_outer}{an integer, the k in the outer k-fold CV.}

\item{nrep_inner}{an integer, the number of repetitions (k-fold inner CV)}

\item{k_inner}{an integer, the k in the inner k-fold CV.}

\item{alphalist}{a numeric vector of values in (0,1]. This sets the search space for
optimising hyperparameter alpha.}

\item{nlambda}{an integer, number of gradations between
lambda.min and lambda.max to search.
See \code{glmnet} argument \code{nlambda}.}

\item{type.measure}{passed to \code{\link[glmnet]{cv.glmnet}}.
This sets the metric used for hyperparameter optimisation in the
inner cross-validation. Options: \code{"deviance"}, \code{"class"},
\code{"mse"}, \code{"mae"}}

\item{family}{the model family (see \code{\link{glmnet}})}

\item{offset}{optional model offset (see \code{\link{glmnet}})}

\item{opt.lambda.type}{Method for selecting optimum lambda. One of
\itemize{
\item{\code{"min"} - returns the lambda with best
CV score.}
\item{\code{"1se"} - returns the +1 se lambda}
}}

\item{opt.empirical_cutoff}{Boolean.
Use the empirical proportion of cases as the cutoff for outer CV
classification (affects outer CV performance only).
Otherwise classify at 50\% probability.}

\item{opt.uniquefolds}{Boolean.
In most circumstances folds will be unique. This requests
that random folds are checked for uniqueness in inner and outer loops.
Currently it warns if non-unique values are found.}

\item{opt.ystratify}{Boolean.
Outer and inner sampling is stratified by outcome.
This is implemented with \code{\link[caret]{createFolds}}}

\item{...}{Arguments to pass through to cv.glmnet
(may break things).}
}
\value{
a dCVnet object.
}
\description{
Double (nested) repeated k-fold cross-validation used to:
\itemize{
\item{Produce unbiased estimates of out-of-sample
classification performance (outer CV).}
\item{Select optimal hyperparameters for the elasticnet (inner CV).}
}
Elasticnet hyperparameters are
\bold{lambda} (the total regularisation penalty)
and \bold{alpha} (the balance of L1 and L2 regularisation types).
}
\section{Factor Outcomes}{

For categorical families (binomial, multinomial) input can be:
\itemize{
\item{numeric (integer): c(0,1,2)}
\item{factor: factor(1:3, labels = c("A", "B", "C")))}
\item{character: c("A", "B", "C")}
\item{other}
}
These are treated differently.

Numeric data is used as provided.
Character data will be coerced to a factor:
\code{factor(x, levels = sort(unique(x)))}.
Factor data will be used as provided, but \emph{must} have levels in
alphabetical order.

In all cases \emph{the reference category must be ordered first},
this means for the binomial family the 'positive' category is second.

Why alphabetical? Previously bugs arose due to different handling
of factor levels between functions called by dCVnet. These appear to be
resolved in the latest versions of the packages, but this restriction will
stay until I can verify.
}

\section{Notes}{

Sparse matrices are not supported by dCVnet.
}

\examples{
\dontrun{

# Iris example: Setosa vs. Virginica
#
# This example is fast to run, but not very informative because it is a
#  simple problem without overfitting and the predictors work 'perfectly'.
# `help(iris)` for more infomation on the data.

# Make a two-class problem from the iris dataset:
siris <- droplevels(subset(iris, iris$Species != "versicolor"))
# scale the iris predictors:
siris[,1:4] <- scale(siris[,1:4])

set.seed(1) # for reproducibility
model <- dCVnet(y = siris$Species,
                     f = ~ Sepal.Length + Sepal.Width +
                           Petal.Length + Petal.Width,
                     data = siris,
                     alphalist = c(0.2, 0.5, 1.0),
                     opt.lambda.type = "1se")

#Note: in most circumstances non-default (larger) values of
#      nrep_inner and nrep_outer will be required.

# Input summary:
dCVnet::parseddata_summary(model)

# Model summary:
summary(model)

# Detailed cross-validated model performance summary:
summary(performance(model))

# hyperparameter tuning plot:
plot(model)
# as above, but zoomed in:
plot(model)$plot + ggplot2::coord_cartesian(ylim = c(0,0.03), xlim=c(-4, -2))

# Performance ROC plot:
plot(model, type = "roc")

# predictor importance (better with more outer reps):
dCVnet::coefficients_summary(model)
#    show variability over both folds and reps:
dCVnet::plot_outerloop_coefs(model, "all")

# selected hyperparameters:
dCVnet::selected_hyperparameters(model, what = "data")

# Reference logistic regressions (unregularised & univariate):
ref_model <- dCVnet::reflogreg(model)

dCVnet::report_reference_performance_summary(ref_model)


}
}
