% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dCVnet_referencemodels.R
\name{reflogreg}
\alias{reflogreg}
\alias{reflogreg.default}
\alias{reflogreg.dCVnet}
\title{reflogreg}
\usage{
reflogreg(object, ...)

\method{reflogreg}{default}(object, ...)

\method{reflogreg}{dCVnet}(object, univariate = TRUE, doPCA = "auto", ncomp = "auto", ...)
}
\arguments{
\item{object}{an object to calculate reference logistic regressions for}

\item{...}{arguments to pass on}

\item{univariate}{calculate per-variable logistic-regression models.}

\item{doPCA}{first run PCA on the features can be "auto" or a boolean.
\itemize{
\item{\code{"auto"} determines based on ratio of
observations to predictors}
\item{\code{TRUE|FALSE} forces pca/no-pca.}
}}

\item{ncomp}{specify how many components for pca (integer).
\code{"auto"}}
}
\value{
a list containing: \itemize{
\item{\code{glm} - the multiple-predictor model (possibly PCA-reduced)}
\item{\code{univariate} - an optional \code{glmlist} of models,
one for each predictor}
}
}
\description{
Unregularised logistic regression models for comparison
}
\details{
Calculate reference logistic regressions to help interpret performance.
models for \eqn{n} observations of \eqn{p} predictors calculated are:
\itemize{
\item{a logistic regression using all variables (if \eqn{n > 5 * p}),
otherwise a logistic regression on the first \eqn{round(n / 5)}
principal components}
\item{a series of logistic regressions, one for each column in the
design matrix - a mass univariate approach}
}

The univariate component has a class ('glmlist') used in some summary
functions. This is not currently correctly implemented.
}
\section{Methods (by class)}{
\itemize{
\item \code{default}: reflogreg for \code{\link{dCVnet}} object

\item \code{dCVnet}: reflogreg for \code{\link{dCVnet}} object
}}

