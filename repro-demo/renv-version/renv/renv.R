dir.create("~/repro-demo/renv-version")
setwd("~/repro-demo/renv-version")
renv::init()

library(dplyr)
df <- data.frame(patient_id = c("P001", "P002", "P003"), age = c(54, 61, 47))
summary(df)

renv::deactivate()
unlink("renv/library", recursive = TRUE)
renv::activate()
renv::restore()