% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dCVnet_utilities.R
\name{tidy_confusionmatrix}
\alias{tidy_confusionmatrix}
\title{tidy_confusionmatrix}
\usage{
tidy_confusionmatrix(mat)
}
\arguments{
\item{mat}{output from \code{confusionMatrix.default}.}
}
\value{
a one column data.frame
}
\description{
return contents of a \code{\link[caret]{confusionMatrix}} as a
'tidy' one column data.frame.
}
