# **Nanopore-RRN-Sequncing **
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

