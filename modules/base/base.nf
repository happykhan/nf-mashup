process TRIANGLETOFULL {
    tag {"Reticulating splines"}
    label 'process_low'
    publishDir "${params.outdir}/triangletofull"
    
    input:
    path("triangle.txt")

    output:
    path("dist_table.phy")

    script:
    """
    triangle_to_fullphy.py triangle.txt 
    """
    stub:
    """
    touch dist_table.phy
    """   

}