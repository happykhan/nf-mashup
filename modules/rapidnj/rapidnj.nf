process RAPIDNJ {
    label 'rapidnj'
    label 'process_medium'
    tag {"Building tree"}

    publishDir "${params.outdir}/tree"


    input:
    path("dist_table.phy")

    script:
    """
    rapidnj --cores ${task.cpus} -i pd dist_table.phy > tree.nwk
    """
    output:
    path "tree.nwk"

    stub:
        """
        touch tree.nwk
        """

}