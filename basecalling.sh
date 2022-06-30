#!/bin/bash
#SBATCH --job-name=guppy
#SBATCH --mail-type=END    
#SBATCH --mail-user=josephpetrone@ufl.edu	
#SBATCH --ntasks=5
#SBATCH --mem=100gb
#SBATCH --nodes=1
#SBATCH --partition=gpu
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:a100:5
#SBATCH --time=4-00:00:00
#SBATCH --output=serial_test_%j.log   
#SBATCH --account=microbiology-dept
#SBATCH --qos=microbiology-dept


module load cuda/11.4.3 guppy/6.1.7

cd /path/to/folder

### Simplex
guppy_basecaller \
        --input_path /path/to/fast5_pass_folder \
        --save_path /path/to/output/folder \
        --config /apps/cuda/11.4.3/base/guppy/6.1.7/data/dna_r10.4_e8.1_sup.cfg \
        --compress_fastq \
        --gpu_runners_per_device 4 \
        --chunk_size 2000 \
        --chunks_per_runner 1000 \
        --min_qscore 10 \
        --recursive \
        -x "cuda:0 cuda:1 cuda:2 cuda:3 cuda:4"
        
        
## Duplex (need to call simplex with SUP first
guppy_basecaller_duplex \
        --input_path /path/to/fast5_pass_folder \
        --save_path /path/to/output/folder \
        --config /apps/cuda/11.4.3/base/guppy/6.1.7/data/dna_r10.4_e8.1_sup.cfg \
        --duplex_pairing_mode from_1d_summary \
        --duplex_pairing_file /path/to/sequencing_summary.txt \
        --compress_fastq \
        --gpu_runners_per_device 4 \
        --chunk_size 2000 \
        --chunks_per_runner 1000 \
        --min_qscore 10 \
        -x "cuda:0 cuda:1 cuda:2 cuda:3 cuda:4"
