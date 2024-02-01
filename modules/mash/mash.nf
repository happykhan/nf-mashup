process MASHSKETCH {
    debug true
    label 'mash'
    time '1h'
    tag {"SKETCH $sample"}

    publishDir "${params.output_dir}/mashsketch"


    input:
    tuple val(sample), file(fasta)

    script:
    """
    mash sketch $fasta -o ${sample}.msh
    """
    output:
    path "${sample}.msh"

    stub:
        """
        touch ${sample}.msh
        """

}

process MASHPASTE {
    debug true
    time '1h'
    label 'mash'
    tag {"MASHPASTE"}

    publishDir "${params.output_dir}/mashref"

    input:
        path mash_files

    script:
        """
        mash paste reference $mash_files 
        """
    output:
        path("reference.msh")

    stub:
        """
        touch reference.msh
        """

}


process MASHDIST {
    debug true
    time '1h'
    label 'mash'
    tag {"MASHDIST"}
    
    publishDir "${params.output_dir}/mashdist"


    input:
    file fasta
    file reference

    script:
    """
    mash dist $reference $fasta > ${fasta}.dist
    """
    output:
        path("${fasta}.dist")

    stub:
        """
        touch ${fasta}.dist
        """

}
