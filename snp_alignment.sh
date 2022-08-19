#!/bin/bash

scriptName=snp_alignment
version="v0.1"

############################################################
# The help function                                        #
############################################################
help()
{
	echo "Member of script series for automatizing workflow for GWAS prephasing and imputation."
	echo "    Step 1: Alignment of the SNPs."
	echo
	echo "Syntax: snp_alignment -h|[j]|i|r|v|V"
	echo "options:"
	echo "h    Print this Help."
	echo "j    Specify path to GenotypeHarmonizer.jar."
	echo "     Default value: ~/Applications/xxx"
	echo "i    Path to input study gwas files, PLINK file prefix only."
	echo "r    Path to reference, PLINK file prefix only."
	echo "v    Verbose mode."
	echo "V    Print software version and exit."
	echo
}

############################################################
# Main function                                            #
############################################################
# Get options
while getopts "hj:i:r:vV" option; do
	case $option in
		h) # display Help
			help
			exit
			;;
		j) # set *.jar path
			jar_dir=${OPTARG}
			;;
		i) # get path to input files
			input_dir=${OPTARG}
			;;
		r) # get path to reference files
			ref_dir=${OPTARG}
			;;
		v) # turn on verbose
			verbose=1
			;;
		V) # print software version
			echo "$scriptName $version"
			exit
			;;
	   \?) # invalid option
			echo "Error: Invalid option"
			exit
			;;
	esac
done


# mkdir alignment
# java -Xmx40g -jar /user/path/to/GenotypeHarmonizer.jar \
    # --inputType PLINK_BED \
    # --input path_to_study_gwas \  # PLINK file prefix only
    # --update-id \
    # --outputType PLINK_BED \
    # --output alignment/all_chrs \
    # --refType PLINK_BED \
    # --ref path_to_reference  # PLINK file prefix only
