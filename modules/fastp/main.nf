process FASTP {

	publishDir params.outdir+"/fastp", mode:"copy"

	input:
		tuple val(sample), file(fastq_1), file(fastq_2)

	output:
		tuple val(sample), path("${sample}/*.fastq.gz"), emit: reads
		tuple val(sample), path("${sample}/*.json"), emit: json
		tuple val(sample), path("${sample}/*.html"), emit: html

	script:
		"""
		mkdir ${sample}
		fastp -i ${fastq_1} -I ${fastq_2} -o ${sample}/${sample}_R1.fastq.gz -O ${sample}/${sample}_R2.fastq.gz\
			-h ${sample}/${sample}.html \
			-j ${sample}/${sample}.json
		"""
}
