#!/usr/bin/env nextflow

// Importing required functions from 'plugin/nf-validation'
include { validateParameters; paramsHelp; paramsSummaryLog; } from 'plugin/nf-validation'

include { MASHSKETCH; MASHPASTE; MASHDIST } from './modules/mash/mash'

// Setting the default value for params.help
params.help = false

// Checking if params.help is true
if (params.help) {
    // Displaying help message using paramsHelp function
    log.info paramsHelp("nextflow main.nf --index sample_data.csv")
    exit 0
}

// Setting the default value for params.index
params.index = "sample_data.csv"

// Validating the parameters
validateParameters()

// Logging the summary of the parameters
log.info paramsSummaryLog(workflow)

// Defining the workflow
workflow {
    // Creating a channel from the file specified in params.index
    FASTA = Channel.fromPath(params.index) \
        // Splitting the CSV file into rows with headers
        | splitCsv(header:true) \
        // Mapping each row to a tuple with sample and fasta file
        | map { row-> tuple(row.sample, file(row.fasta)) } 

    // Running the MASH module
    SKETCHES = MASHSKETCH( FASTA )
    REFERENCE = MASHPASTE( SKETCHES.collect() )
    SKETCHES.collect().view()
    REFERENCE.view()
    DISTANCES = MASHDIST( REFERENCE, SKETCHES )
}