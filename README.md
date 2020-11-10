## Generating a self-alignment cooler

First, create a paired end BED file containing the outputs of the self-alignments as described in https://github.com/mrvollger/colored_glass

Then take a look at `main.sh` for the commands to convert it to a cooler.

View with higlass using `higlass-manage view out.mcool`.