process MASHSKETCH {
    label 'mash'
    time '1h'
    tag {"SKETCH $sample"}

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

process MASHTRIANGLE {
    time '1h'
    label 'mash'
    tag {"MASHTRIANGLE"}

    input:
        path mash_files

    script:
        """
        mash triangle -p ${task.cpus} $mash_files > triangle.txt 2> triangle.err
        """
    output:
        path("triangle.txt")
        path("triangle.err")

    stub:
        """
        touch triangle.txt
        touch triangle.err
        """

}


process MASHPASTE {
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
    file reference
    file fasta

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
