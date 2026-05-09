# Nectar Dye Data Dictionary

Experiments are explained in the README, below the description of the columns of each datatable are documented.

## Nectar Dye Experiment

**File Name:** Nectar_Dye_Experiment.csv

### Column Names

- species: we used 3D printed filament bill replicas of Heliconia tortuosa's 4 most common hummingbird visitors.
  - GREH: green hermit (Phaethornis guy)
  - VISA: violet sabrewing (Campylopterus hemileucurus)
  - RTAH: rufous-tailed (Amazilia tzacatl)
  - CRWO: crowned woodnymph (Thalurania colombica)
- sex: F (female) or M (male)
- dye_on_stigma: the amount of dye that was seen on the stigma after insertion and extraction of the bill replicas was visually set into relatively arbitrary categories of Y (yes), lots, little, or N (no). This was later converted into a binary variable: "dye_on_stigma_binary", where yes, lots, and little, were all considered as "yes".
- dye_on_anthers: same as above, only based on the amount of dye on the anthers (instead of the stigma).
- flower: this reflects the condition of the flower collected flower. Whether it came from an open flower, a bagged flower, or a flower that was used as a pollen donor in a treatment.
- person: refers to the person that inserted and extracted the bill replica.
- bill_stained: this binary variable describes whether the insertion and extraction of the bill replica caused the bill to be stained by the injected dye.
- date: date of treatment (start to finish).
- collection_time: this is rough estimate of the time that the flowers were collected from the field.
- dye_time: this is a rough estimate of when the flowers were injected with dye. Flowers that were injected were immediately used to insert and extract bill replicas.
- notes: observer (Ferne's) commentary.

### Code-Generated Variables

- bill_type: combination of species and sex
- dye_on_stigma_binary: binary version of dye_on_stigma. Y (yes), lots, and little were converted to "Yes" and N (no) was kept as "No".
- dye_on_anthers_binary: binary verison of dye_on_anthers.
- dye_on_rep_strucs: binary response of dye landing on any reproductive structures (either anthers or stigma).
- foraging: hummingbirds were grouped together based on their foraging strategies; GREH and VISA were grouped together as "trapliner" (also called "specialist") and RTAH and CRWO were grouped together as "territorial" (also called "generalist").
