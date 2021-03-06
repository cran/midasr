% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulate.R
\name{midas_auto_sim}
\alias{midas_auto_sim}
\title{Simulate simple autoregressive MIDAS model}
\usage{
midas_auto_sim(
  n,
  alpha,
  x,
  theta,
  rand_gen = rnorm,
  innov = rand_gen(n, ...),
  n_start = NA,
  ...
)
}
\arguments{
\item{n}{sample size.}

\item{alpha}{autoregressive coefficients.}

\item{x}{a high frequency predictor variable.}

\item{theta}{a vector with MIDAS weights for predictor variable.}

\item{rand_gen}{a function to generate the innovations, default is the normal distribution.}

\item{innov}{an optional time series of innovations.}

\item{n_start}{number of observations to omit for the burn.in.}

\item{...}{additional arguments to function \code{rand_gen}.}
}
\value{
a \code{ts} object
}
\description{
Given the predictor variable, the weights and autoregressive coefficients, simulate MIDAS regression response variable.
}
\examples{
theta_h0 <- function(p, dk) {
  i <- (1:dk-1)/100
  pol <- p[3]*i + p[4]*i^2
  (p[1] + p[2]*i)*exp(pol)
}

##Generate coefficients
theta0 <- theta_h0(c(-0.1,10,-10,-10),4*12)

##Generate the predictor variable
xx <- ts(arima.sim(model = list(ar = 0.6), 1000 * 12), frequency = 12)

y <- midas_auto_sim(500, 0.5, xx, theta0, n_start = 200)
x <- window(xx, start=start(y))
midas_r(y ~ mls(y, 1, 1) + fmls(x, 4*12-1, 12, theta_h0), start = list(x = c(-0.1, 10, -10, -10)))
}
\author{
Virmantas Kvedaras, Vaidotas Zemlys
}
