module load python-data

name=$(sed -n "$SLURM_ARRAY_TASK_ID"p sample_names.txt)

python /projappl/project_2001318/MiCoP/run-bwa.py ./sequences/$name"_hf_host_removed.1.fq.gz" ./sequences/$name"_hf_host_removed.2.fq.gz" \
--fungi \
--output /scratch/project_2001318/maars_20230904/trimmed_20230904/micop_out/bwa_results/$name"_alignments.sam"
