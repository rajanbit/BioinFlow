process BWAMEM2_INDEX{

	publishDir params.outdir+"/bwamem2_index", mode:"copy"

	input:
		path fasta

	output:
		path "reference.fasta.*"
		

	script:
		"""
		cp ${fasta} reference.fasta
		samtools faidx reference.fasta
		bwa-mem2 index ${fasta} -p reference.fasta
		"""
}
