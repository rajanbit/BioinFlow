process MULTIQC {

	publishDir params.outdir+"/multiqc", mode:"copy"

	input:
		path reports

	output:
		path "multiqc_data/*"
		file "multiqc_report.html"

	script:
		"""
		multiqc --force ${reports}
		"""

}
