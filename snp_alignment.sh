#!/bin/bash

scriptName=snp_alignment
version="v0.1"

jar_dir="$HOME/Applications/xxx"
jar_name="GenotypeHarmonizer"

############################################################
# The help function                                        #
############################################################
help()
{
	echo "Member of script series for automatizing workflow for GWAS prephasing and imputation."
	echo "    Step 1: Alignment of the SNPs."
	echo
	echo "Syntax: snp_alignment -h|[p]|[n]|i|r|v|V"
	echo "options:"
	echo "h    Print this Help."
	echo "p    Specify path to the jar file."
	echo "     Default value: ~/Applications/xxx"
	echo "n    Specify name of the jar file."
	echo "     Default value: GenotypeHarmonizer"
	echo "i    Path to input study gwas files, PLINK file prefix only."
	echo "r    Path to reference, PLINK file prefix only."
	echo "v    Verbose mode."
	echo "V    Print software version and exit."
	echo
}

check_if_dir ()
{
	if [ ! -d "$1" ]
	then
		echo "Specified directory $1 doesn't exist."
		exit
	fi
}

check_if_file ()
{
	if [ ! -f "$1" ]
	then
		echo "Specified file $1 doesn't exist."
		exit
	fi
}

############################################################
# Main function                                            #
############################################################
# Get options
optstr="hp:n:i:r:vV"
while getopts ${optstr} option; do
	case $option in
		h | \?) # display Help
			help
			exit
			;;
		p) # set *.jar path
			check_if_dir ${OPTARG}
			jar_dir=${OPTARG}
			# if [ ! -d "${jar_dir}" ]
			# then
				# echo "Specified directory for the .jar file doesn't exist."
				# exit
			# fi
			# check trailing slash
			if [ ! "${jar_dir: -1}" = "/" ]
			then
				jar_dir="${jar_dir}/"
			fi
			;;
		n) # set *.jar name
			check_if_file ${OPTARG}
			jar_name=${OPTARG}
			# full_file_name=$(basename "$OPTARG")
			# file_dir=$(dirname "$OPTARG")
			# file_dir="${file_dir}/"
			# out_dir="${file_dir}"
			;;
		i) # get path to input files
			check_if_dir ${OPTARG}
			input_dir=${OPTARG}
			# check trailing slash
			if [ ! "${input_dir: -1}" = "/" ]
			then
				input_dir="${input_dir}/"
			fi
			;;
		r) # get path to reference files
			check_if_dir ${OPTARG}
			ref_dir=${OPTARG}
			# check trailing slash
			if [ ! "${ref_dir: -1}" = "/" ]
			then
				ref_dir="${ref_dir}/"
			fi
			;;
		v) # turn on verbose
			verbose=1
			;;
		V) # print software version
			echo "$scriptName $version"
			exit
	esac
done


# mkdir alignment
java -Xmx40g -jar ${jar_dir}${jar_name}.jar \
	--inputType PLINK_BED \
	--input ${input_dir} \  # PLINK file prefix only
	--update-id \
	--outputType PLINK_BED \
	--output alignment/all_chrs \
	--refType PLINK_BED \
	--ref ${ref_dir}  # PLINK file prefix only

