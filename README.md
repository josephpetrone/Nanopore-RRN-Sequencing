# **Nanopore-RRN-Sequncing**
Pipeline and Methods for 16S-ITS-23S rRNA Nanopore Sequencing with Custom Barcodes 


## **Primer Descriptions**
### The construct of these RRN primers are for both the forward and reverse (5' - 3'): 
> 'Linker' -- '16-mer barcode' -- 'primer' 

### **The linker sequence is :** 
> "GATC"

### **The primer binding sequences used were :** 
> Forward 16S (5'-3') : AGRRTTYGATYHTDGYTYAG \
> Reverse 23S (5'-3') : CCRAMCTGTCTCACGACG 

### **The final primer sequences used:**
[RRN Full Primers and Barcodes](https://github.com/josephpetrone/Nanopore-RRN-Sequncing/blob/main/RRN%20primers%20and%20barcodes.xlsx)


## **PCR Protocol**
### **For each 25µL PCR tube :**
> - 2X Phusion Hot-Start High-Fidelity Polymerase----:   13µL 
> - 10µM RRN Primer/barcode Forward----------------:   1.25µL 
> - 10µM RRN Primer/barcode Reverse----------------:   1.25µL 
> - DNA Input-----------------------------------------:   2µL -or- 10ng 
> - Sterile Nuclease-Free Water-----------------------:   Complete to 25µL


## **Thermocylcer Conditions**
- Initial Denaturation 
> 98ºC : 30sec 
- 30 Cycles 
> 98ºC : 10sec \
> 71.5ºC : 30sec \
> 72ºC : 4min 
- Final Extenstion
> 72ºC : 7min30sec


## **Amplification QC**
** DO NOT VORTEX AND TRY TO USE WIDE-BORE TIPS TO PREVENT FRAGMENTATION **

**1. Verify Amplification via 1% agarose gel electrophoresis @ 100V for 30min** 

**2. Quantify product using Qubit HS chemistry**

**3. Pool equal concentrations of DNA into a low-bind 1.5mL tube**\
***Aim for ≥ 4.5µg (3 Libraries) of DNA in the pool*** \
***If volume < 100µL, complete to 100µL with elution buffer*** 

**4. Add 0.6X AMPureXP beads and wash twice with 75% EtOH**

**5. Elute in 100µL EDTA-free EB (2 Libraries)**


## **Library Prep** 
**Use the latest native ligation-sequencing kit from the Nanopore Store** \
***For our publication, we used SQK-LSK110 and SQK-LSK112*** \
***Once again, use wide-bore tips and flick to mix at any step where the DNA is being collected or mixed***
- Input AMPure purified DNA into the protcol (900ng-1.5µg)
- Increase END-PREP incubation step to 30min
- Increase all AMPure incubation steps to 10min and all elutions to 15min
- Increase adapter ligation step to 30min using Quick T4 Ligase  
- Use LFB for the final AMPure wash
- Load onto flowcell as usual
- Sequence until flowcell exhaustion and basecall using the highest modal "SUP" with the latest basecaller

## **Data Processing**
**If not rebasecalling, copy all passed fastqs to working folder location**
### **Read-Splitting**
**[Duplex-Tools](https://github.com/nanoporetech/duplex-tools)** \
***duplex-tools was installed to a conda environment***
> $conda activate duplextools

1st time: 
> $duplex-tools split_on_adapter --threads [N] --allow_multiple_splits [input_folder_to_fastq] [path/to/working/folder/1-duplextools/split1] Native
>
2nd time: 
> $duplex-tools split_on_adapter --threads [N] --allow_multiple_splits [path/to/working/folder/1-duplextools/split1] [path/to/working/folder/1-duplextools/split2] Native \
>
10th time: 
> $duplex-tools split_on_adapter --threads [N] --allow_multiple_splits [path/to/working/folder/1-duplextools/split9] [path/to/working/folder/1-duplextools/split10] Native \
> 
> $conda deactivate

### **Concatenate all Fastqs**
**Bash Manipulation**

> $cd /path/to/working/folder/1-duplextools/split10/ \
> 
> $mkdir all \
> 
> $zcat ./*.fastq.gz > ./all/"filename".fastq


### **Re-Filter Reads**
**[NanoFilt](https://github.com/wdecoster/nanofilt)** \
***NanoFilt was installed to a conda environment***
> $conda activate nanofilt \
> 
> $cd /path/to/working/folder \
> 
> $NanoFilt -q [value] --readtype (1D,2D,1D2) [path/to/working/folder/1-duplextools/split10/all/"filename".fastq] > [path/to/working/folder/2-nanofilt/"filename".fastq] \
>
> $conda deactivate

### **Demultiplex**
**[Nanoplexer](https://github.com/hanyue36/nanoplexer)** \
***nanoplexer was installed to a conda environment***

> $conda activate nanoplex
>
> $nanoplexer -b [barcodes.fa](https://github.com/josephpetrone/Nanopore-RRN-Sequncing/blob/main/barcodes.fa) -d [sample.txt](https://github.com/josephpetrone/Nanopore-RRN-Sequncing/blob/main/sample.txt) -p [path/to/working/folder/3-demultiplexed/ [path/to/working/folder/2-nanofilt/"filename".fastq] \



### **Adapter-Primer Removal**
**[cutadapt](https://github.com/marcelm/cutadapt)** \
***cutadapt was already installed as a module on UF Rearch Computing***
options: 
- -e = error
- -O = min overlap
- -o output
- -a primer1...reverse_complement_of_primer2
- -m = minimum read length
- -M = maximum read length


> $module load cutadapt 

Loop through demultiplexed files to retain names
> $cd [path/to/working/folder/3-demultiplexed]
>
> $for file in *.* \
> $do \
> $cutadapt -e 0.2 -O 15 --revcomp -m 3000 -M 7000 -o [path/to/working/folder/4-trimmed/trimmed_$file] -a AGRRTTYGATYHTDGYTYAG...CGTCGTGAGACAGKTYGG $file \
> $done


### **Concatenate Top and Bottom Strands**
**Bash Manipulation**

> $cd /path/to/working/folder/4-trimmed/ \
>  
> $mkdir reverse \
> $mkdir forward 
>
> $mv ./*_rev.fastq ./reverse \
> $mv ./*.fastq ./forward \
> $mv ./forward/*_unclassified.fastq ../ 
> 
> $mkdir combined \

Concatenate top and bottom (forward and reverse) into same file \
> $for f in ./forward/* \
> $do \
> $basename=${f##/}
> $prefix=${basename%%.**} \
> $cat "$f" ".reverse/${prefix}_"* > .combined/"combined.$basename" \
> $done


### **Taxonomic Classifier**
**[EMU](https://gitlab.com/treangenlab/emu)** \
***EMU was installed to a conda environment***

options:
- --type = map-ont, sr, map-pb
- --min-abundance = threshold
- --threads = cpu multithreading for minimap
- --db = database folder
- --N = max alignments for each read
- --output-dir = output directoru
- --keep-file = keeps sam alignment files for each sample (remove if FALSE)

> $cd /path/to/working/folder/ \
> $for file in ./4-trimmed/combined/* \
> $do \
> $emu abundance --type map-ont --threads 28 "$file" --db /path/to/database/[ncbi_202006_RRN](/ \
	--output-dir ./5-emu

done










