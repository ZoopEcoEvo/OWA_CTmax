# OWA Lineage CTmax Project 
*Goal*: Measure critical thermal maxima (CTmax) for the four OWA lineages to examine whether adaptation to different stressors affects upper thermal limits in Acartia tonsa.

*Methods*: CTmax is measured by exposing individuals to increasing temperatures and monitoring them for the onset of a comatose state (i.e. till they are no longer responsive to stimuli). This is equivalent to “ecological death” – being unable to escape lethal conditions, predation, etc.

Measurements are made on fresh adult females. Individuals should be picked from the cultures and held in fresh food media (800 ug C/L of Tetreselmis and Rhodomonas) for 24 hours before the CTmax assay. Ideally, females from each of the four lineages will be included every day. We use a custom system, comprising a reservoir, water bath, and Arduino temperature logger. Water in the reservoir is heated at a fairly constant rate (between 0.1oC and 0.3oC per minute). This water is pumped up into a plexiglass water bath, where individual copepods are held in glass tubes. There are also three temperature probes in separate tubes distributed throughout the water bath. As the water passes through the bath, it heats the water in the tubes. The clear walls of the water bath allow us to constantly monitor the individuals as temperature rises. After the individual reaches its CTmax it is removed from the water bath. Each assay typically takes less than 3 hours to set up, run, and breakdown. 

We will aim for measuring CTmax for a minimum of 80 individuals (4 lineages x 4 replicates per lineage x 5 individuals per replicate). Each CTmax assay includes 10 individuals; will need 8 separate assays. Based on how much variance we’ve previously observed for CTmax in laboratory cultures, this design should detect any change in CTmax larger than 1oC. We’ll analyze this data using a linear mixed effects model (CTmax ~ lineage; experimental day and replicate bucket as random effects)

## Timeline: 
### Week of October 24
-	All cultures checked for presence of copepodites
-	Randomization script written to design experimental set-up
-	Practice runs

### Week of October 31
-	Assuming adults are present in all cultures, CTmax assays are run on Tuesday, Wednesday, Thursday, and Friday. 

### Week of November 7
-	Assuming adults are present in all cultures, CTmax assays are run on Tuesday, Wednesday, Thursday, and Friday. 

### Week of November 14
-	Coding and analysis of results
