nextflow.enable.dsl = 2

include { devWorkflow		} from "./workflows/devWorkflow/main"

workflow BioinFlow {
    devWorkflow()
}


workflow {
    BioinFlow()
}

