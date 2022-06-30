#!/bin/bash
#SBATCH --job-name=paper_run
#SBATCH --mail-type=END    
#SBATCH --mail-user=josephpetrone@ufl.edu	
#SBATCH --ntasks=1
#SBATCH --mem=50gb
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --time=2-00:00:00
#SBATCH --output=serial_test_%j.log   
#SBATCH --account=triplett
#SBATCH --qos=triplett-b

module load ufrc

#####################################################################################################################################################################################################################################################                               
#####################################################################################################################################################################################################################################################
##    ▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄              ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄       ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄       ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ ##
##  ▄█░░░░▌    ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌        ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌            ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌▐░▌     ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌##
## ▐░░▌▐░░▌    ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀          ▀▀▀▀█░█▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀              ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀      ▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌     ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ##
##  ▀▀ ▐░░▌    ▐░▌          ▐░▌                       ▐░▌          ▐░▌     ▐░▌                                ▐░▌          ▐░▌▐░▌               ▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌       ▐░▌▐░▌     ▐░▌       ▐░▌▐░▌               ▐░▌     ▐░▌          ##
##     ▐░░▌    ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ ▐░▌          ▐░▌     ▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄          ▐░▌ ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄      ▐░█▄▄▄▄▄▄▄█░▌▐░▌ ▐░▌   ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄      ▐░▌     ▐░█▄▄▄▄▄▄▄▄▄ ##
##     ▐░░▌    ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌          ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▄▄▄▄▄▄▄▄▄█░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░░▌##
##     ▐░░▌    ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀▀▀ ▐░▌          ▐░▌      ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀▀▀▐░░░░░░░░░░░▌ ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌     ▐░█▀▀▀▀▀▀▀█░▌▐░▌   ▐░▌ ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌      ▀▀▀▀█░█▀▀▀▀  ▀▀▀▀▀▀▀▀▀█░▌     ▐░▌      ▀▀▀▀▀▀▀▀▀█░▌##
##     ▐░░▌    ▐░▌       ▐░▌          ▐░▌             ▐░▌          ▐░▌               ▐░▌            ▐░█▀▀▀▀▀▀▀▀▀           ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌▐░▌       ▐░▌▐░▌          ▐░▌               ▐░▌     ▐░▌               ▐░▌##
## ▄▄▄▄█░░█▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄█░▌         ▄▄▄▄█░█▄▄▄▄      ▐░▌      ▄▄▄▄▄▄▄▄▄█░▌            ▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄█░▌     ▐░▌       ▐░▌▐░▌     ▐░▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌      ▄▄▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄  ▄▄▄▄▄▄▄▄▄█░▌##
##▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌        ▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░░▌            ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌       ▐░▌▐░▌      ▐░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌##
## ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀          ▀▀▀▀▀▀▀▀▀▀▀       ▀       ▀▀▀▀▀▀▀▀▀▀▀              ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀       ▀         ▀  ▀        ▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀       ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ ##
################################################################################################################################################################################################################ By: Joseph R. Petrone Early-2022  ##                               
#####################################################################################################################################################################################################################################################                               
                                                                                                                                                                                                                                                

####################################################
################# README / STARTUP #################
####################################################
####################################################
################ PIPING OFF GRIDION ################
####################################################

## Fancy seeing you here...
## First things first, lets make a folder on Hipergator to put all our Nanopore data on.
## You will need to SSH into HPC via command line but you must be on VPN or UF wifi
## Then run this command after the ">" of course...just change your name to your UF username
## > ssh josephpetrone@hpg2.ad.ufl.edu
## 	> Password: your password
## > cd /blue/triplett/share/rrn_analysis/gfsc/reads/
## > mkdir gfsc_rrn_run2_r10.4
##
##
## Now, lets get the data off the GRID
## You will need to SSH into the GRID via command line but you must be on either UF-WIFI or VPN
## Then run this command after the ">" of course...
## > ssh grid@GXB01180.ad.ufl.edu
## Password: on a sticker on the device
##
## Then navigate to your data files
## Normally, this is under the /data/ tab and is named after the run
## In this example, the data file is called "GFSC_rrn_experiment1_4_11_2022"
## There will be 2-3 folders within this directory until you get to "fastq_pass"
## > cd /data/GFSC_rrn_experiment1_4_11_2022/gfsc_rrn_1/20220411_1603_X2_FAT24044_27faaf0c/
##
## Here you will have a directory with FASTQ/FAST5 Pass/Fail.
## You will need to copy the pass folder into Hipergator to proceed
## You will enter this into the command line once in that directory on the GRID
## Obviously you will need to change the username and the path you want the fastq_pass to end up
## > scp -r ./fastq_pass josephpetrone@hpg2.rc.ufl.edu:/blue/triplett/share/rrn_analysis/gfsc/reads/gfsc_rrn_run2_r10.4/
## Password: noneofyourbusiness
##
## Now the fastq pass folder is on hipergator. Pat on the back.
## Next up is concatenating the fastq files into one large one for the demultiplexer to handle.
## To do that is super easy. Just navigate to that same directory on hipergator and run the following:
## > cat ./fastq_pass/*.fastq.gz > name_of_file_that_has_all_reads.fasta.gz
##
## B-E-A-U-TIFUL
## Now its time to let the script ride. 
## Once you're at this step, your computer is now being hacked...jk 
## Make sure to save a copy of this script and make edits to the paths / filenames
## It doesnt matter where you save your file or how you name it
## Just make sure you dont change the path to the conda environments/ EMU databases/ or the final name of the cudapt files
## If you do ... Joe's 30,000 mile  powertrain warranty becomes VOID
##
## BTW, a path looks something like this /and/is/the/path/through/directories/
##
## So by now, you have your ONT data on Hipergator concatenated. 
## The script (A COPY OF THIS ONE) should be editted for your filenames and paths.
## Make sure you have the resources at the top of the script ready to go.
## Thats the part that looks like "#SBATCH"
## "--mem" is going to be your RAM for the job
## "-t" is going to be the time limit
## "--cpus-per-task" is your multithreading
## "--qos=triplett-b" is the QOS of our account. "triplett-b" is burst resources and "triplett" would be normal resources.
## To see what resources we even have at this point in time, run this on hipergator:
## > showQos triplett-b
## or > showQos triplett
## Make sure you stay under those constraints, ya feel?
##
## OK, time to run it
## Make sure the copy of this script you are using is given full permission.
## Also, it needs to have an extension of ".sh" and then run this:
## > chmod +wrx ./copy_of_this_script.sh 
##
## To actually run this bad boi, you'll need to run this command:
## > sbatch ./copy_of_this_script.sh
## It should be running!
##
## Check by running this command:
## > squeue -A triplett
##
## That will show you if the script is running and for how long 
## You should see files being generated in the directories you chose
## Check the slurm file thats in the same directory.
## You'll see 


cd /path/to/main_folder/
module load conda

####### Change ME!!!! ##########
## Remember no spaces in bash variables
## This is whatever directory you copied the fast5_pass to.
first_dir=/blue/microbiology-dept/triplett-lab/josephpetrone/Nanopore/GFSC/GFSC_rrn_experiment2_5_24_2022

## This is going to be the main folder location that contains the subfolders from each step here
working_dir=/blue/microbiology-dept/triplett-lab/josephpetrone/Nanopore/GFSC/GFSC_rrn_experiment2_5_24_2022/RRN_pipeline

## This has to be the fastq pass directory
fastq_dir=/blue/microbiology-dept/triplett-lab/josephpetrone/Nanopore/GFSC/GFSC_rrn_experiment2_5_24_2022/1-hipergator_SUP_simplex_full/pass

## Multithreading CPU option. MUST PUT VALUE HERE
threads=28

## Path to nanoplexer barcode fasta (this one actually can stay)
nanoplex_dir=/blue/triplett/share/rrn_analysis/necessary_files

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
	$fastq_dir \
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
module load conda
export PATH=/blue/triplett/josephpetrone/rrn_analysis/demuliplex/nanoplex/bin:$PATH
conda activate /blue/triplett/josephpetrone/rrn_analysis/demuliplex/nanoplex
cd  $working_dir

nanoplexer -b $nanoplex_dir/barcodes.fa -d $nanoplex_dir/sample.txt -p ./3-demultiplexed ./2-nanofilt/*.fastq

conda deactivate

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

cd $working_dir/3-demultiplexed
mkdir $working_dir/4-trimmed
## Loop through demultiplexed fastq files
module load cutadapt/3.4



for file in *.*
do
	cutadapt -e 0.2 \
	-O 15 \
	--revcomp \
	-m 3000	\
	-M 7000	\
	-o $working_dir/4-trimmed/trimmed_$file \
	-a AGRRTTYGATYHTDGYTYAG...CGTCGTGAGACAGKTYGG \
	$file
done

################################################
################ CONCAT. F + R  ################
################################################
## Puts top and bottom stand into separate folders and then combines them into one file

cd $working_dir/4-trimmed

mkdir $working_dir/4-trimmed/reverse
mkdir $working_dir/4-trimmed/forward

mv ./*_rev.fastq ./reverse
mv ./*.fastq ./forward
mv ./forward/*_unclassified.fastq ../

mkdir $working_dir/4-trimmed/combined
cd $working_dir/4-trimmed/

for f in ./forward/*; do     
	basename=${f##*/};     
	prefix=${basename%%.*};     
	cat "$f" "./reverse/${prefix}_"* > ./combined/"combined.$basename"; done
done

## Removes any NULL files of unused barcodes
find ./combined/* -size 0 -print -delete

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
conda activate /blue/triplett/josephpetrone/rrn_analysis/emu

## Loop through demultiplexed fastq files
## Giving it all the files at once is too large of a "filename"

for file in ./4-trimmed/combined/*

do
  	emu abundance --type map-ont --threads $threads "$file" --db /blue/triplett/share/rrn_analysis/databases/ncbi_202006_RRN --output-dir ./5-emu

done

## Shutdown conda environment
conda deactivate

