#!/bin/bash
psiblast -query target.fa -num_iterations 5 -out_pssm target_uni.pssm -db /shared/databases/blastdat/uniprot_sprot.fasta
psiblast -db /shared/databases/blastdat/uniprot_sprot -num_iterations 5 -in_pssm target_uni.pssm -out target_uni_pssm.out