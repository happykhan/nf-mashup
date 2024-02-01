# nf-mashup
I dunno, something runs mash and makes NJ trees. 

* runs mash sketch on different fasta files 
* runs mash paste to merge these into a reference database
* run mash dist using the individual sketches against the ref database to get distance values 

## TODO: 
* Create a distance matrix table 
* Create an NJ tree using rapidnj

## Installation

To install and set up the pipeline, follow these steps:

1. Install Nextflow by following the instructions provided in the [Nextflow documentation](https://www.nextflow.io/docs/latest/getstarted.html).

2. Clone the repository:

    ```bash
    git clone git@github.com:happykhan/nf-mashup.git
    ```

3. Change into the cloned directory:

    ```bash
    cd nf-mashup
    ```

4. Run the pipeline using Nextflow:

    ```bash
    nextflow run main.nf
    ```
