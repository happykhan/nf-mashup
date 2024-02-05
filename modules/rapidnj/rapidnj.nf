process RAPIDNJ {
    time '1h'
    tag {"RAPIDNJ"}

    publishDir "${params.output_dir}/tree"


    input:
    path("dist_table.phy")

    script:
    """
    rapidnj -i pd dist_table.phy > tree.nwk
    """
    output:
    path "tree.nwk"

    stub:
        """
        touch tree.nwk
        """

}