process MASHSKETCH {
    label 'mash'
    label 'process_single'
    tag {"Sketching $sample"}

    input:
    tuple val(sample), file(fasta)

    script:
    """
    mash sketch -p ${task.cpus} $fasta -o ${sample}.msh
    """
    output:
    path "${sample}.msh"

    stub:
        """
        touch ${sample}.msh
        """

}

process MASHTRIANGLE {
    label 'mash'
    label 'process_medium'
    tag {"Calculate distances"}

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
    label 'mash'
    label 'process_single'
    tag {"MASHPASTE"}

    publishDir "${params.outdir}/mashref"

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
    label 'mash'
    label 'process_single'
    tag {"MASHDIST"}
    
    publishDir "${params.outdir}/mashdist"


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
