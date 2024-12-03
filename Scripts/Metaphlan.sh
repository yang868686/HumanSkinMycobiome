module load metaphlan

for i in $(ls *__host_removed_concatenate.fastq.gz | sed 's/__host_removed_concatenate.fastq.gz//'); \
do metaphlan --bowtie2db /scratch/project_2001318/maars/metaphlan_databases \
${i}__host_removed_concatenate.fastq.gz --input_type fastq \
--nproc $SLURM_CPUS_PER_TASK \
-t rel_ab_w_read_stats \
--add_viruses \
--unclassified_estimation \
-o ./metaphlan_out_abs/${i}_abs_profile.txt \
--bowtie2out ./metaphlan_out/${i}_metagenome.bowtie2.bz2 ; done 
