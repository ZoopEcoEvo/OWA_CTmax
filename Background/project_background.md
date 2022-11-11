# OWA Lineage CTmax Project 
**Goal**: Measure critical thermal maxima (CTmax) for the four OWA lineages to examine whether adaptation to different stressors affects upper thermal limits in *Acartia tonsa*.

**Methods**: CTmax is measured by exposing individuals to increasing temperatures and monitoring them for the onset of a comatose state (i.e. until they are no longer responsive to stimuli). This is equivalent to “ecological death” – being unable to escape lethal conditions, predation, etc.

Measurements are made on fresh adult females. Individuals should be picked from the cultures and held in fresh food media (800 ug C/L of *Tetreselmis* and *Rhodomonas*) for 24 hours before the CTmax assay. Ideally, females from each of the four lineages will be included every day, but due to the complexity of our culturing system (four lineages with four replicate cultures each, which may not all be at the same developmental stage), we will use a randomized experimental design, with the number of individuals from each lineage randomly determined before each replicate experiment. 

For the CTmax measurements themselves, we use a custom system, comprising a reservoir, water bath, and Arduino temperature logger. Water in the reservoir is heated at a fairly constant rate (between 0.1^o^C and 0.3^o^C per minute). This water is pumped up into a plexiglass water bath, where individual copepods are held in glass tubes. There are also three temperature probes in separate tubes distributed throughout the water bath. As the water passes through the bath, it heats the water in the tubes. The clear walls of the water bath allow us to constantly monitor the individuals as temperature rises. After the individual reaches its CTmax it is removed from the water bath. Body lengths for each individual will also be measured. Each assay typically takes less than 3 hours to set up, run, and breakdown. 

We will aim for measuring CTmax for a minimum of 80 individuals (4 lineages x 4 replicates per lineage x 5 individuals per replicate). Each CTmax assay includes 10 individuals; will need 8 separate assays. Based on how much variance we’ve previously observed for CTmax in laboratory cultures, this design should detect any change in CTmax larger than 1oC. We’ll analyze this data using a linear mixed effects model (CTmax ~ lineage; experimental day and replicate bucket as random effects).

## Timeline: 
### Week of November 14
-	Randomization script written to design experimental set-up
-	Practice runs

### Week of November 21
-	Run a couple replicates before Thanksgiving (aim for 2)

### Week of November 28
- Run replicates (aim for 4)

### Week of December 5
- Final replicates (aim for 4)

### Week of December 12
- Analysis and visualization 