nextflow.enable.dsl=2

// Run FASTQC
include { FASTQC		} from "../modules/fastqc/main"

// Run FASTP
include { FASTP			} from "../modules/fastp/main"

// Run BWAMEM2_INDEX
include { BWAMEM2_INDEX		} from "../modules/bwamem2/index/main"

// Run BWAMEM2_MEM
include { BWAMEM2_MEM		} from "../modules/bwamem2/mem/main"

// Run MULTIQC
include { MULTIQC		} from "../modules/multiqc/main"



workflow WES {

	// Channel for FASTQ read
	fastq_reads = channel.fromPath(params.sample_sheet) \
		   | splitCsv(header:true) \
		   | map { row -> tuple(row.sample, file(row.fastq_1), file(row.fastq_2)) }

	// Channel for genomic FASTA (building index)
	genomic_fasta = channel.fromPath(params.fasta)


	// Channel for collecting reports
	reports = Channel.empty()

	// FASTQC
	fastqc_out = FASTQC(fastq_reads)
	reports = reports.mix(fastqc_out.html.collect{ sample, html -> html })
	reports = reports.mix(fastqc_out.zip.collect{ sample, zip -> zip })


	// FASTP
	fastp_out = FASTP(fastq_reads)
	reports = reports.mix(fastp_out.json.collect{ sample, json -> json })
	reports = reports.mix(fastp_out.html.collect{ sample, html -> html })

	// BWAMEM2 INDEX
	bwamem2_index = BWAMEM2_INDEX(genomic_fasta)

	// BWAMEM2 MEM
	bwamem2_mem = BWAMEM2_MEM(fastp_out.reads, bwamem2_index.collect())

	// MULTIQC
	multiqc_out =  MULTIQC(reports.collect())
}
