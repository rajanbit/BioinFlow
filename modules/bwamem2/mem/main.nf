process BWAMEM2_MEM {

	publishDir params.outdir+"/mapped", mode:"copy"

	input:
		tuple val(sample), path(reads)
		path(index)

	output:
		tuple val(sample), path("${sample}/${sample}.bam"), emit: bam

	script:
		 """
		mkdir ${sample}
		bwa-mem2 mem reference.fasta ${reads} | samtools view -bS -o ${sample}/${sample}.bam -
		"""
}
