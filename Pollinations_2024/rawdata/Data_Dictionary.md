# Pollinations 2024 Data Dictionary

Experiments are explained in the README. Description of variables from each datatable are documented below. Note: PRM stands for "Pollinator Recognition Mechanism".

## PRM_Trials

**File Name:** PRM_Trials.csv

Pollination data from the first round of pollinations (March 2024), when the main researcher on this project (Ferne Kotlyar) was still in the field.

### Field Variables

- Patch: Clusters within or near the Kress Patch.
  - The Kress Patch, named after John Kress, is an open area at the Las Cruces Biological station with many (likely clonal) inflorescences in 3 distinct clusters (denoted by K1, K2, and K3). All pollinations occurred either in one of 3 clusters of the Kress patch or in the "Mike" patch, which was a small cluster close to the Kress patch, containing one open inflorescence.
- Plant_ID: Label of the inflorescence.
  - Each inflorescence was fitted with a plastic tag that contained a number recorded in this variable.
- Bract_Num: Bract number of the given inflorescence (also called "Bract").
- Bract_Total: Total number of bracts on a given inflorescence. As the season continued and the plants continued to grow, this number would increase on a given inflorescence.
- Treatment: In the field, we originally used 4 different treatments as described below. In the end, one treatment was removed (electrostatics) as it added noise to the results.
  - Nectar Drop (ND): Later renamed to "simulated visit". After hand pollination, we inserted a 3D printed replica of a female green hermit hummingbird bill.
  - Nectar Extraction (NE): Hand pollination, then nectar extraction.
  - Hand Pollination Only (HPO): Later renamed to "hand pollination". Application of pollen from far flowers (more than 100 m away) onto the stigmas of target flowers.
  - Electrostatics (E): Application of pollen using a charged rod. This treatment was later removed and is not presented in the final manuscript.
- Pollen_Donor: Plant_ID of the inflorescence from which we took pollen to pollinate flowers.
- PD_Covered: Binary indicator (Y = yes \| N = no) of whether or not the pollen donor (PD) was covered before use.
- Poll_Date: Date of pollination (year-month-date).
- Poll_Time: Time of pollination. All pollinations took place between 7:52 AM and 10:30 AM.
- Coll_Date: Date of flower collection (year-month-date).
- Coll_Time: Time of flower collection. Most collections took place between 1:30 PM and 5:00 PM.
- Damage: After collection, the flowers were assessed on a scale from 0 (no damage) to 2 (lots of damage). The primary goal was to determine if damage to the flower was preventing the nectar extraction treatment from working.
- Num_Above_Tape: When a new bract was started, the number of fruits outside of the flagging tape (denoting the start of our treatment) was counted. The goal was to have an estimate of bract age (the greater the number of fruits "above the tape", the older the bract is).
- Style_Collected: Binary indicator (Y = yes \| N = no) of whether or not a style was collected and stored for future pollen tube analysis.
- Applier_Technique: Name of the person who applied a given treatment.
- Applier_Pollen: Name of the person who applied the pollen onto the stigma.
- Killed: Binary indicator (Y = yes \| N = no) of whether or not a flower/fruit was killed. Flowers were killed using nail polish.
- Closed_Date: Date that the bract was "closed" (year-month-day). A bract was closed the same way it was opened, by placing a piece of flagging tape underneath the fruits to mark the location. All fruits between the two pieces of flagging tape were treated in the field. A different coloured flagging tape was used for each treatment.
- Closed_Time: Time that the bract was closed.
- Notes: Notes.

## PRM_Extended

**File Name:** PRM_Extended.csv

Field data taken by Michael in April 2024 that has the same structure as in "PRM_Trials.xlsx". However, some columns were **not** recorded including: Bract_Total, PD_Covered, Coll_Date (usually the day after Poll_Date), Coll_Time, Damage, Style_Collected, Applier_Technique (in this dataset, this was always Michael), Applier_Pollen (again, in this dataset, this was always Michael), Killed, Closed_Date, and Closed_Time.

Additionally, in this dataset, there were additional treatments. Instead of ND, which in the last dataset (PRM_Trials) were always treated with far pollen, in this dataset, the ND technique was used with self (S), near-neighbour (NN), and far pollen and marked accordingly with ND-S, ND-NN, and ND-Far, respectively.

### Field Variables (different from above)

- Bract: Same as "Bract_Num".
- Out: Same as "Num_Above_Tape".
- Notes: This time, the notes are in Spanish.

## Fruit_Set_2024

**File Name:** Fruit_Set_2024.xlsx

Final fruit set of **all** fruits that were collected in 2024. Includes fruit and seed details. The column headers are in Spanish in the original datasheet, but are translated into English in the code. This dataset also contains fruits from an additional experiment where only two fruits survived (Stub-Control); these will be removed from the dataset.

### Field Variables

- Fecha: Date (year-month-day). Date that the fruit was collected and weighed.
- Obs: Observer. Person that recorded the measurements. In this case, all measurements were taken by MAP: Michael (Mike) Atencio-Picado.
- Parche: Patch, as above.
- Planta: Plant_ID.
- Bractea: Bract or Bract_Num.
- Treatment: Same treatments as above. However, it also includes fruits collected from other treatments as well such stub pollination and Nectar Drop (ND) combined with pollen from different distances (self, near-neighbour, or far).
- Method: Denotes the treatment type.
- PRM: Pollinator Recognition Mechanism - this is the main treatment that is described in "Pollinations 2024".
- Stub: Stub pollination treatments. None of the artificial pollinations from this treatment resulted in fruits apart from the control.
- PRM-Ext: Pollinator Recognition Mechanism Extended - this is the extension of the main treatment with a few additional details. For the purpose of this manuscript, only the treatments that matched "PRM" were used.
- Dia-olv: Diameter of the fruit in mm.
- Peso-fruta: Weight of the fruit in grams.
- \# Semillas: Number of seeds in a fruit. *H. tortuosa* can produce a maximum of 3 seeds per fruit.
- Peso 1: Weight of the first seed in grams.
- Peso 2: Weight of the second seed in grams.
- Peso 3: Weight of the third seed in grams.
- Falsa: Binary indicator of whether the fruit was false (i.e., contained no seeds) or not. 1 = yes it was false, 0 = no, it was not false.
  - Note: Fruits can be false by containing no seeds, but seeds can also be false when they are soft (instead of being hard) to the touch.
- Notas: Notes.
