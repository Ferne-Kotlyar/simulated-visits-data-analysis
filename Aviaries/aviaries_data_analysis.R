#-------------------------------------------------------------------#
# This script analyzes pollen tube counts from aviary experiments in
# 2018 and 2019 in Las Cruces.
# Last updated by F. Kotlyar 31 Mar 2026
#-------------------------------------------------------------------#

# ---- Load libraries and data ----

library(tidyverse)
library(lme4)
library(DHARMa)
library(emmeans)
library(officer)

# if data get archived elsewhere, need to change this url
av_data <- read_csv("https://oregonstate.box.com/shared/static/rxu3bflp4yx31bv8u37cmz2lvlwpv6v6.csv")

# subset to just HETO
av_data <- av_data %>% filter(
    Species == "H.tortuosa"
  ) %>%
  # change the necessary variables to factors
  mutate(
    Treatment = factor(Treatment, levels = c("HP", "RTAH", "GREH")),
    Plant = as.factor(Plant),
    Experiment = as.factor(Experiment)
  ) %>%
  janitor::clean_names()

# ---- Data summary ----

exp_summary <- av_data %>%
  group_by(treatment, plant, band_or_color) %>%
  summarise(n = n())


# ---- Modeling ----

mfit <- glmer(
  tube_count ~ treatment + (1 | experiment),
  data = av_data,
  family = poisson
)

mfit

## ---- checking fit ----

qresids <- simulateResiduals(mfit)

plot(qresids)

# Looks good enough



# ---- Results ----

## ---- pairwise contrasts ----

emg <- emmeans(mfit, specs = ~ treatment)

contrast_tbl <- contrast(
  emg, 
  method = list(
    `RTAH / HP` = c(-1, 1, 0),
    `GREH / HP` = c(-1, 0, 1),
    `GREH / RTAH` = c(0, -1, 1)
  ), 
  adjust = "none", 
  type = "response"
) 

contrast_tbl2 <- confint(contrast_tbl) %>%
  mutate_if(
    is.numeric,
    round, digits = 2
  )

contrast_tbl <- as_tibble(contrast_tbl) %>%
  mutate_if(
    is.numeric,
    round, digits = 2
  )

estims_tbl <- confint(emg, type = "response") %>%
  as_tibble() %>%
  mutate_if(
    is.numeric,
    round,
    digits = 3
  )


### ---- sample sizes ----

sample_size_df <- as.data.frame(table(av_data$treatment))

sample_size_df <- sample_size_df %>% rename(sample_size = Freq, 
                                      treatment = Var1)

estims_tbl <- estims_tbl %>%
  left_join(sample_size_df, by = "treatment")

### ---- saving to word tables ----

library(officer)

doc <- read_docx()

doc <- body_add_table(
  doc,
  value = estims_tbl,
  style = "table_template"
)

doc <- body_add_break(doc)

doc <- body_add_table(
  doc,
  value = contrast_tbl,
  style = "table_template"
)

doc <- body_add_break(doc)

doc <- body_add_table(
  doc,
  value = contrast_tbl2,
  style = "table_template"
)

print(doc, here::here("Aviaries/results_tables.docx"))

## ---- figure ----

av_fig <- ggplot(estims_tbl, aes(x = treatment, y = rate)) +
  geom_errorbar(aes(ymin = asymp.LCL, ymax = asymp.UCL), width = 0.1) +
  geom_text(aes(label = paste0("n = ", sample_size), y = asymp.UCL + 0.1), 
            vjust = 0, size = 4) +
  geom_point(size = 2.5, color = "white") +
  geom_point() +
  ylab("Pollen tubes/style") +
  xlab("Treatment") +
  scale_x_discrete(labels = c("HP" = "Hand pollination", 
                              "RTAH" = "Rufous-tailed", 
                              "GREH" = "Green Hermit"))





