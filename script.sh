#!/bin/bash
#SBATCH --job-name=paper_run
#SBATCH --mail-type=END    
#SBATCH --mail-user=josephpetrone@ufl.edu	
#SBATCH --ntasks=1
#SBATCH --mem=50gb
#SBATCH --nodes=1
#SBATCH --cpus-per-task=30
#SBATCH --time=2-00:00:00
#SBATCH --output=serial_test_%j.log   
#SBATCH --account=triplett
#SBATCH --qos=triplett-b


module load conda
#module load cuda/11.4.3 guppy/6.1.7

####### Change ME!!!! ##########
## Remember no spaces in bash variables

## This is whatever directory you copied the fastq_pass to.
fastq_dir_dir=/path/to/fastq_pass


first_dir=/path/to/parent/directory/where/you/want/output/
## This is going to be the main folder location that contains the subfolders from each step here

working_dir=/blue/microbiology-dept/triplett-lab/josephpetrone/Nanopore/GFSC/GFSC_rrn_experiment4_7_28_2022/RRN_pipeline
## This is going to be the main folder location that contains the RRN-pipeline output from each step here


## Multithreading CPU option. MUST PUT VALUE HERE
threads=28
## Path to cutadapt  barcode fasta file
barcodes=/path/to/barcodes_linked2.fa

cd $first_dir



#############################################
############# READ SPLITTING ################
#############################################

mkdir RRN_pipeline
cd $working_dir
mkdir ./1-duplextools
echo $pwd

### duplex-tools

conda activate /blue/triplett/josephpetrone/duplextools

## Split 1
duplex_tools split_on_adapter --threads $threads \
	--allow_multiple_splits \
	$fastq_dir_dir/ \
	$working_dir/1-duplextools/split1 \
	Native

## Split 2
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split1 \
        $working_dir/1-duplextools/split2 \
        Native
rm -r $working_dir/1-duplextools/split1

## Split 3
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split2 \
        $working_dir/1-duplextools/split3 \
        Native
rm -r $working_dir/1-duplextools/split2

## Split 4
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split3 \
        $working_dir/1-duplextools/split4 \
        Native
rm -r $working_dir/1-duplextools/split3

## Split 5
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split4 \
        $working_dir/1-duplextools/split5 \
        Native
rm -r $working_dir/1-duplextools/split4

## Split 6
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split5 \
        $working_dir/1-duplextools/split6 \
        Native
rm -r $working_dir/1-duplextools/split5

## Split 7
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split6 \
        $working_dir/1-duplextools/split7 \
        Native
rm -r $working_dir/1-duplextools/split6

## Split 8
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split7 \
        $working_dir/1-duplextools/split8 \
        Native
rm -r $working_dir/1-duplextools/split7

## Split 9
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split8 \
        $working_dir/1-duplextools/split9 \
        Native
rm -r $working_dir/1-duplextools/split8

## Split 10
duplex_tools split_on_adapter --threads $threads \
        --allow_multiple_splits \
        $working_dir/1-duplextools/split9 \
        $working_dir/1-duplextools/split10 \
        Native
rm -r $working_dir/1-duplextools/split9


####This splitting needs to be ran until no more reads are split ~10 times
####Change the -input -output so that splitting is done on the output of the previous  iteration 

conda deactivate


#############################################
############# File Manipulation #############
#############################################

cd $working_dir/1-duplextools/split10
mkdir all
zcat ./*.fastq.gz > ./all/split10_all.fastq


#############################################
############ RE-FILTER READS ################
#############################################
### NanoFilt
## -q = Q-score cutoff
## --readtype (1D,2D,1D2)

module load nanofilt/2.7.1

cd $working_dir
mkdir 2-nanofilt

cat $working_dir/1-duplextools/split10/all/* | NanoFilt -q 10 --readtype 1D > $working_dir/2-nanofilt/split_filtered.fastq


#############################################
################ DEMULTIPLEX ################
#############################################
### Nanoplexer
## -b = multi-fasta containing all barcodes used (correct orientation for top and bottom strands)
## -d = a txt file containing the primer combination and what the sample should be named

module load cutadapt

cd  $working_dir
mkdir $working_dir/3-demultiplexed

cutadapt -j 25 \
	--action=none \
	-O 16 \
	-e 0.05 \
	--no-indels \
	--revcomp \
	-m 3000 \
	-M 7000 \
	-g file:$barcodes \
	-o $working_dir/3-demultiplexed/combined.demuxed_{name}.fastq \
	$working_dir/2-nanofilt/split_filtered.fastq


########################################################   
################ ADAPTER-PRIMER REMOVAL ################
########################################################
### Cutadapt
# -e = error
# -O = min overlap
# -o = output
# -a = primer1...Reverse_complement_of_primer2
# -m = minimum read length
# -M = maximum read length
# --revcomp = If primers found on bottom strand, reorient to top stand 

mkdir $working_dir/4-trimmed

cd $working_dir/3-demultiplexed

## Loop through demultiplexed fastq files

module load cutadapt/3.4

for file in *.*
do
	cutadapt -e 0.2 \
	-O 15 \
	--revcomp \
	-o $working_dir/4-trimmed/trimmed.$file \
	-a AGRRTTYGATYHTDGYTYAG...CGTCGTGAGACAGKTYGG \
	$file
done

######################################################
################ TAXONOMIC CLASSIFIER ################
######################################################
### EMU
## --type = (map-ont, sr, map-bp)
## --min-abundance = threshold for min-abundance
## --db = database folder
## --N = max alignments for each read
## --K = batch size for minimap
## --output-dir = output directory
## --keep-files = only 

cd $working_dir
## Load and activate conda emu enviroment

module load conda
export PATH=/blue/microbiology-dept/triplett-lab/josephpetrone/emu:$PATH
conda init /blue/microbiology-dept/triplett-lab/josephpetrone/emu
conda activate /blue/microbiology-dept/triplett-lab/josephpetrone/emu

## Loop through demultiplexed fastq files
## Giving it all the files at once is too large of a "filename"

for empanada in ./4-trimmed/*

do
  	emu abundance --type map-ont --keep-counts --keep-read-assignments --threads $threads "$empanada" --db /blue/microbiology-dept/triplett-lab/josephpetrone/RRN_db --output-dir ./5-emu

done

## Shutdown conda environment
conda deactivate
