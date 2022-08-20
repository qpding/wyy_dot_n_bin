#!/bin/bash

scriptName=phase
version="v0.1"

############################################################
# The help function                                        #
############################################################
help()
{
	echo "Member of script series for automatizing workflow for GWAS prephasing and imputation."
	echo "    Step 2: Phasing the GWAS samples."
	echo
	echo "Syntax: snp_alignment -[h]|[v]|[V]"
	echo "options:"
	echo "h    Print this Help."
	echo "v    Verbose mode."
	echo "V    Print software version and exit."
	echo
}

for i in {1..22}
do
    mkdir chr$i
    $PLINK --bfile path/to/all_chrs --chr $i --make-bed --out ./chr$i/unphased_chr$i

    $SHAPEIT -B ./chr${i}/unphased_chr${i} -M ./references/genetic_map_chr${i}_combined_b37.txt -O ./chr${i}/phased_chr${i} -T 10

    echo "phased_chr$i generated!"
done

