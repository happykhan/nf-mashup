process TRIANGLETOFULL {
    time '1h'    
    tag {"Reticulating splines"}
    publishDir "${params.output_dir}/triangletofull"
    
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