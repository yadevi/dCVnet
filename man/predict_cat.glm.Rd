% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dCVnet_utilities.R
\name{predict_cat.glm}
\alias{predict_cat.glm}
\title{predict_cat.glm}
\usage{
predict_cat.glm(glm, threshold = 0.5)
}
\arguments{
\item{glm}{a binomial family glm object}

\item{threshold}{the prediction threshold}
}
\description{
Category predictions from a binomial glm object.
}
\details{
Note: this is not implemented as an S3 generic despite the name.
It has no dispatch.
}
