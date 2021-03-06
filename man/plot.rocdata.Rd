% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dCVnet_plotting.R
\name{plot.rocdata}
\alias{plot.rocdata}
\title{plot.rocdata}
\usage{
\method{plot}{rocdata}(
  x,
  legend = TRUE,
  alphalabel = c(0.25, 0.5, 0.75),
  guide_labels = c(group = "Model", threshold = expression(P[Threshold]), refline =
    "Chance\\nPerformance"),
  ...
)
}
\arguments{
\item{x}{\code{\link[=extract_rocdata]{rocdata}} object}

\item{legend}{logical. Display a legend?}

\item{alphalabel}{should certain alpha values (probability thresholds)
on the curve be highlighted with symbols indicating threshold?}

\item{guide_labels}{a named list of 3 labels used in the legend:
\itemize{
\item{group = label for the Grouping factor}
\item{threshold = label for the Threshold factor}
\item{refline = label for the Reference line}
}}

\item{...}{additional arguments (unused)}
}
\value{
a ROC plot, as above.
}
\description{
acts on a \code{\link[=extract_rocdata]{rocdata}} object
to provide a ROC plot with the following:
\itemize{
\item{y-axis : Sensitivity (i.e. True Positive Rate)}
\item{x-axis : 1 - Specificity (i.e. False Positive Rate)}
\item{curve : shows c.d.f. as classification threshold varies}
}
}
\details{
requires \pkg{ggplot2}.
}
