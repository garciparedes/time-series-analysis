rm(list = ls())

library(magrittr)
library(dplyr)
library(ggplot2)
library(latex2exp)
require(reshape2)
library(forecast)
library(cowplot)
library(lubridate)

MAX_LAG <- 72


RangeMean <- function(x, seasonality) {
    n <- length(x)
    seq(1, n, by=seasonality) %>%
    sapply(function(i){
        a <- x[i:(i + seasonality - 1)]
        c(mean=mean(a, na.rm=TRUE), range=diff(range(a,na.rm=TRUE)))
    }) %>%
    t() %>%
    as.data.frame()
}


Correlogram <- function(x, n = length(x) - 1, with.first = FALSE) {
    result <- acf(x, lag.max=n, plot=FALSE)$acf[1:n + !with.first]
    data.frame(lag = 1:length(result), values = result)
}


Periodogram <- function(x) {
    result <- TSA::periodogram(x, plot=FALSE)
    data.frame(freq = c(0, result$freq), spec = c(0, result$spec))
}


PlotTimeSeries <- function(df, seasonality, armonics = c()){
    p.a <- ggplot(df) +
        aes(x = index, y = values) +
        xlab("Fecha") +
        ylab("Valor") +
        geom_line()

    p.b <- ggplot(RangeMean(df$values, seasonality)) +
        aes(x = mean, y = range) +
        geom_point() +
        xlab("Media") +
        ylab("Rango") +
        expand_limits(y=0)

    p.c <- ggplot(Correlogram(df$values, MAX_LAG)) +
        aes(x = lag, y = values) +
        xlab("Retardo") +
        ylab("Correlación") +
        geom_bar(stat="identity") +
        geom_hline(yintercept = 2/sqrt(nrow(df)), color = "red") +
        geom_hline(yintercept = -2/sqrt(nrow(df)), color = "red")

    p.d <- ggplot(Periodogram(df$values)) +
        aes(x = freq, y = spec) +
        xlab("Frecuencia") +
        ylab("Valor") +
        geom_line()

    for (a in armonics) {
        p.d <- p.d + geom_vline(xintercept = a, color = "red", alpha = 0.4)
    }
    plot_grid(p.a, p.b, p.c, p.d)
}

BASE_PATH <- 'assignment-2/exercise-1/'
BASE_IMG_PATH <- paste0(BASE_PATH, 'res/img/')
BASE_DATA_PATH <- paste0(BASE_PATH, 'res/data/')

df <- read.csv(paste0(BASE_DATA_PATH, 'espectadores.csv'))

df$DATE <- dmy(df$DATE)

colnames(df) <- c("index", "values")

PlotTimeSeries(df, seasonality = 12, armonics = (1:6) / 12) %>%
  { save_plot(paste0(BASE_IMG_PATH, 'espectadores.png'), .,
             base_aspect_ratio = 1.75, base_height = 8) }


df.residuals.raw <- read.csv(paste0(BASE_DATA_PATH, 'ondassignificativaspredict.csv'))[1:204,]
df.residuals.raw$DATE <- dmy(df.residuals.raw$DATE)

df.residuals <- data.frame(index = df.residuals.raw$DATE,
                           values = df.residuals.raw$ERROR)

PlotTimeSeries(df.residuals, seasonality = 12) %>%
  { save_plot(paste0(BASE_IMG_PATH, 'residuos.png'), .,
             base_aspect_ratio = 1.75, base_height = 8) }

df.predicts <- data.frame(index = df.residuals.raw$DATE,
                          actual = df.residuals.raw$ACTUAL,
                          predict = df.residuals.raw$PREDICT)

p <- ggplot(df.predicts) +
     aes(x = index) +
     xlab("Fecha") +
     ylab("Valor") +
     geom_line(aes(y = actual, alpha = 0.7)) +
     geom_line(aes(y = predict, colour="Predicciones"))  +
     theme(aspect.ratio=1 / 3, legend.position="none")

save_plot(paste0(BASE_IMG_PATH, 'fitted.png'), plot_grid(p),
          base_aspect_ratio = 3, base_height = 3)
