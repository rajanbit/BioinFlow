process FASTQC {

	publishDir params.outdir+"/fastqc", mode:"copy"

	input:
		tuple val(sample), file(fastq_1), file(fastq_2)

	output:
		tuple val(sample), path("${sample}/*.html"), emit: html
		tuple val(sample), path("${sample}/*.zip") , emit: zip

	script:
		"""
		mkdir $sample
		fastqc ${fastq_1} ${fastq_2} --outdir ${sample}
		"""
}
