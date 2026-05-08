# Pollinations 2025 Data Dictionary

Experiments are explained in the README. Description of variables from each datatable are documented below.

## PRM_2025

**File Name:** PRM_2025.csv

Pollination data from the first round of pollinations (March 2025), when the main researcher on this project (Ferne Kotlyar) was still in the field. PRM: Pollinator Recognition Mechanism.

### Column Names

- patch: cluster denoting the location of the maternal inflorescence. Inflorescences growing directly in the "Kress Patch" were growing in very large clusters (10+ inflorescences within 3 m) in an open (non-shaded) area. Inflorescences growing outside of the Kress patch grew in forested areas either individually or in small clusters (2-4 inflorescences within 1 m). All patches were found on the Las Cruces Biological Station (LCBS) grounds. The following patches were included.
  - K1 - K3: inflorescences located in the Kress Patch, subdivided into clusters 1, 2, and 3.
  - KT: Kress Trail. These inflorescences grew along the forested trail leading to the Kress Patch.
  - tinamu: small cluster of inflorescences located behind the "Tinamu" house.
  - tower: scattered inflorescences beside the observation tower.
  - old_pots: two independent inflorescences that were collected and potted in 2023 from the LCBS forest. These were the only potted individuals and both inflorescences died without producing any fruit, they were therefore removed from the analysis.
- plant_id: label of the inflorescence.
  - Each inflorescence was fitted with a plastic tag that contained a number recorded in this variable.
- bract: bract number of the given inflorescence.
- treatment: initially, there were 7 treatments, but we prioritized increased sample size over increased treatments and stopped conducting two of the treatments. In the end, there 5 main treatments; they are listed below and further described in the Data README.
  - Nectar Drop (ND): later renamed to "simulated visit"
  - Control (Ctrl): later renamed to "open pollination"
  - Nectar (N)
  - Sugar Water (SW)
  - No Nectar (NN): later renamed to "bill insertion"
  - Hand Pollination (HP): this treatment was removed as it was conducted many times before and we had not reason to expect a difference in this experiment.
  - Sugar Drop (SD): same as NN, but then place a drop of sugar water on the stigma (instead of wiping a bill replica covered in sugar water on the stigma). This treatment was removed to increase sample size of the other treatments.
- pollen_donor: plant_id of the inflorescence from which we took pollen to pollinate flowers.
- poll_date: date of pollination (year-month-date).
- poll_time: time of pollination. All pollinations took place between 5:30 AM and 11:30 AM.
- num_above_tape: When a new bract was started, the number of fruits outside of the flagging tape (denoting the start of our treatment) was counted. The goal was to have an estimate of bract age (the greater the number of fruits "above the tape", the older the bract is).
- nectar_source: for the nectar treatment, we recorded the plant_id of the flower that was used as the nectar source; where possible, this was a different individual from the pollen donor. When this was not the nectar treatment, this column was left as "N/A".
- coll_date: date of flower collection (year-month-date).
- coll_time: time of flower collection. Most collections took place between 1:00 PM and 4:00 PM.
- donor_state: indicator of whether the pollen donor was "covered" or "open". This was left as "N/A" for open pollinated flowers (Ctrl).
- removed: binary indicator (Y = yes \| N = no) of whether or not a flower/fruit was killed. This time, fruits were removed to kill them instead of putting on nail polish.
- notes: notes.

## Fruit Set 2025

**File Name:** Fruit_Set_2025.csv

Fruit set data collected by Michael Atencio in May - July 2025, where he collected the fruits from "PRM_2025" (datasheet above). Many of the columns match those in "PRM_2025", but with slightly different names.

### Column Names

- Date: date (year-month-day). Date that the fruit was collected and weighed.
- Obs: observer. Person that recorded the measurements. In this case, all measurements were taken by MAP: Michael (Mike) Atencio-Picado.
- Parche: patch
- Plant_ID: plant_id
- Bract: bract
- Treatment: treatment
- Method: denotes the treatment type, as these were all taken from the same experiment, this is the same for all rows. RPM is a typo of PRM (Pollinator Recognition Mechanism).
- Dia-olv: diameter of the fruit in mm
- Peso_fruta: weight of the fruit in grams
- \# Semillas: number of seeds in a fruit
- Peso 1: weight of the first seed in grams
- Peso 2: weight of the second seed in grams
- Peso 3: weight of the third seed in grams
- Falsa: binary indicator of whether the fruit was false (i.e., contained no seeds) or not [1 = yes it was false, 0 = no, it was not false]
  - note: Fruits can be false by containing no seeds, but seeds can also be false when they are soft (instead of being hard) to the touch
- \# de frutas por Bractea: number of fruits per bract
- Notas: notes

## Self Nectar Pollination

**File Name:** Self_Nectar_Pollination.csv

Self-nectar pollination experiment (PRM: Nectar Self Experiment). Later in the season, we added an additional treatment (self nectar and open pollination as a control) to make sure that there was no difference between using another flower's nectar (as we did in the PRM experiment) and self nectar. We repeated the nectar treatment using the same methods as in the PRM experiment only with self nectar instead of another flower's nectar. These data were collected by Michael Atencio in April - May 2025.

### Column Names

- Date: date of pollination (year-month-date).
- Parch: patch
- Plant_ID: plant_id
- Bract: bract
- Treatment: treatment - contains only 2 treatments..
  - Nectar-Self (NS): same as the nectar treatment in the PRM experiment, but using nectar from a flower of the same inflorescence. This required the inflorescence to have at least 2 open flowers on the same day.
  - Control (CTRL): open pollination treatment as in the PRM experiment.
- Pollen_Donor: pollen_donor
- Time of Pollen: poll_time
- Out: num_above_tape
- Amount of Nectar: this was a subjective categorization of the amount of nectar in the donor flower. This was placed in 3 categories: little (LI), regular (RE), or lots (LO). For controls, this was left as "N/A".
- Bract_NS_Donor: represents the bract of the flower that was used as the nectar source (the plant_id was the same as the maternal/target flower.
- Notes: empty column with no notes.

## Self Nectar Fruit Set

**File Name:** Self_Nectar_Fruit_Set.csv

Fruit set data collected from the self nectar experiment. These data were collected by Michael Atencio in June - July 2025. The column names match those in "Fruit Set 2025".
