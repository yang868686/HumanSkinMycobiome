module load biokit

for i in $(ls *_1.fastq.gz | sed 's/_1.fastq.gz//'); do
bowtie2 -p $SLURM_CPUS_PER_TASK -x /scratch/project_2001318/maars/GRCh38_noalt_as/GRCh38_noalt_as \
  -1 ${i}_1.fastq.gz \
  -2 ${i}_2.fastq.gz \
  --un-conc-gz \
  ./bowtie2_out/${i}_host_removed.%.fastq.gz \
  2>./bowtie2_out/${i}_Map2humanStat.xls | samtools view -S -b -o ./bowtie2_out/${i}_mapped_and_unmapped.bam - ; done
