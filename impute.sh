#!/bin/bash

scriptName=impute
version="v0.1"

############################################################
# The help function                                        #
############################################################
help()
{
	echo "Member of script series for automatizing workflow for GWAS prephasing and imputation."
	echo "    Step 3: Imputation of the GWAS samples."
	echo
	echo "Syntax: snp_alignment -[h]|[v]|[V]"
	echo "options:"
	echo "h    Print this Help."
	echo "v    Verbose mode."
	echo "V    Print software version and exit."
	echo
}

############################################################
# Main function                                            #
############################################################
# Get options
optstr="hvV"
while getopts ${optstr} option; do
	case $option in
		h | \?) # display Help
			help
			exit
			;;
		v) # turn on verbose
			verbose=1
			;;
		V) # print software version
			echo "$scriptName $version"
			exit
	esac
done

impute2 -use_prephased_g -Ne 20000 -iter 30 -align_by_maf_g -os 0 1 2 3 -seed 1000000 -o_gz -int 1 5000001 -h 1000GP_Phase3_chr22.hap.gz -l 1000GP_Phase3_chr22.legend.gz -m genetic_map_chr22_combined_b37.txt -known_haps_g phased_chr22.haps -o chr22.chunk1 # chr22.chunk1.gz generated

impute2 -use_prephased_g -Ne 20000 -iter 30 -align_by_maf_g -os 0 1 2 3 -seed 1000000 -o_gz -int 5000001 10000001 -h 1000GP_Phase3_chr22.hap.gz -l 1000GP_Phase3_chr22.legend.gz -m genetic_map_chr22_combined_b37.txt -known_haps_g phased_chr22.haps -o chr22.chunk2  # chr22.chunk2.gz generated
