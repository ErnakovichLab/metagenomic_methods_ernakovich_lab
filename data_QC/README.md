# Data Cleaning Workflow
Placeholder for inforamtion on the cleaning workflow

Current workflow:
 1. Assess initial quality with `fastqc`
 2. Evaluate multiple sequence quality with `multiqc`
 3. Use `cutadapt` to remove residual transposases, quality-filter the data, and remove NovaSeq PolyG's
 4. Assess cleaned sequence quality with `fastqc`
 5. Evaluate multiple sequence quality with `multiqc`
