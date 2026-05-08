#--------------------------------------------------------------------------#
# This script analyzes pollen tube counts from nectar removal experiments in
# 2018 and 2019 in Las Cruces.
# Last updated by F. Kotlyar 08 May 2026
#--------------------------------------------------------------------------#

# ---- Load libraries and data ----

packages <- c("here", # for setting the working directory
              "tidyverse", # for data cleaning
              # (contains ggplot2, dplyr, stringr, tidyr, readr)
              "patchwork", # for combining plots
              "officer", # for manipulating word docx
              "lme4", # for linear mixed effects models
              "DHARMa", # for checking model assumptions
              "emmeans") # for calculating odds ratios

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# rerun the aviaries analysis to load figure and reset the results tables
source(here::here("Aviaries/scripts/aviaries_data_analysis.R"))

# remove the objects except for the figure
obs <- ls()
rm(list = obs[!(obs == "av_fig")])

# now load the nectar removal data
hpne <- read_csv("./Aviaries/rawdata/HPvsNE_data.csv") %>%
  janitor::clean_names()

hpne <- hpne %>% 
  filter(species == "H.tortuosa") %>%
  mutate(
    treatment = factor(treatment, levels = c("HP", "HPNE")),
    plant = as.factor(plant),
    experiment = as.factor(experiment)
  )

## ---- data summaries ----
xtabs(~ treatment, data = hpne)

writeLines(
  paste(
    "Total number of paired/blocked experiments:",
    unique(hpne$experiment) |> length()
  )
)

writeLines(
  paste(
    "Total number of unique plants used:",
    length( unique(hpne$plant) )
  )
)

# ---- Model fitting ----

mfit <- glmer(
  tube_count ~ treatment + (1 | experiment),
  data = hpne,
  family = poisson
)

## ---- assumptions checks ----

qresids <- simulateResiduals(mfit)
plot(qresids)

# ---- Results ----
## ---- results table ----

emg <- emmeans(mfit, ~ treatment, type = "response") %>%
  as_tibble() %>%
  mutate_if(is.numeric, round, digits = 2)

doc <- read_docx(here::here("Aviaries/results_tables.docx"))

doc <- body_add_break(doc)

doc <- body_add_table(doc, emg, style = "table_template")

# print(doc, here::here("Aviaries/results_tables.docx"))

### ---- sample sizes ----

sample_size_df <- as.data.frame(table(hpne$treatment))

sample_size_df <- sample_size_df %>% rename(sample_size = Freq, 
                                            treatment = Var1)

emg <- emg %>%
  left_join(sample_size_df, by = "treatment")

## ---- figure ----

thm <- theme_classic(base_size = 14) 

ne_fig <- ggplot(emg, aes(x = treatment, y = rate)) +
  geom_errorbar(aes(ymin = asymp.LCL, ymax = asymp.UCL), width = 0.1) +
  geom_text(aes(label = paste0("n = ", sample_size), y = asymp.UCL + 0.1), 
            vjust = 0, size = 4) +
  geom_point(size = 2.5, color = "white") +
  geom_point() +
  thm +
  xlab("Treatment") +
  ylab("Pollen tubes/style") +
  scale_x_discrete(labels = c("HP" = "Hand pollination", 
                              "HPNE" = "Nectar extraction")) +
  ylim(layer_scales(av_fig)$y$range$range) +
  ggtitle("b)")

av_fig <- av_fig + thm +
  ggtitle("a)")

av_fig + ne_fig + 
  plot_layout(axes = 'collect')

ggsave(
  here::here("Figures/av_hpne_results_fig.png"),
  width = 9,
  height = 5,
  units = "in",
  dpi = 300
)
