# Assignment 2
Nico Ares, Dante Aviñó, Miguel Borge, Isaac Soul



## Structural bioinformatics Project – Assignment 2: Sequence analysis.

**1. Does your protein have an HMM available in the PFAM database?**

Our 2CG9 protein didn’t have a valid fasta file in the pdb database since it had no gaps. To deal with this issue we obtained a valid fasta file from uniprot through the following accession name: UniProtKB - P02829 (HSP82_YEAST). We then used the pfam database to obtain the best sequence alignment for our desired protein through the hmmscan command from the HMMER package. Once we had the output file for the hmmscan, we observed that the best model for our protein was the “HSP90”, which we used to obtain the hidden markov model with the hmmfetch command.

```bash
# Searching in Pfam database HMMs fitting 2CG9 protein sequence:
hmmscan /shared/databases/pfam-3/Pfam-A.hmm 2CG9_uniprot.fasta > 2CG9_uniprot.out
```

![img](https://lh5.googleusercontent.com/Wn85kUgjf5uUfa14JTZ8kgxd4EauC1QNCYtrPhrDEJmtCudLvstw4zPUzaJap49VFWwpFHHY8GTYGYoli-MGgi26sP5S_vr5SQYb-c5LPvvMLolxT_DdTU4ZS76h2Hn8-W0Qirty)

```bash
# Extracting profiles from Pfam corresponding to HSP90 protein family domains:
hmmfetch /shared/databases/pfam-3/Pfam-A.hmm "HSP90" > HSP90_domain.hmm
```

![img](https://lh5.googleusercontent.com/Rc4LvSs5-SpoBpaBRoIpkBQi_oZ-rxMcy5gx38_4QnUIgPwyutExr0v84LoMJeblKvs_YnwLBD_N7YEfrP9PrL8_T4N7kva2hvY4A2ctUFRzZl7lj_SLdROIygKUVJWCDIi9KyFj)



**2. Choose a set of 6 to 8 amino acid sequences that belong to the protein family you are studying. These sequences should represent the evolutionary history of your protein family, so you want them to have some diversity between them and avoid redundant or highly similar pairs of sequences. You will use these sequences to build a multiple sequence alignment. From what database should you retrieve these sequences? Why?**

We have used the hmmsearch command, using the hidden markov model for our protein target (2CG9), and we’ve compared our results for pdb and uniprot. 

Before acknowledging the results, we know that PDB is very redundant since it has the same proteins repeated several times and that it is very biased. Some protein families are overrepresented due to medical significance, easier crystallography, etc. and other families are underrepresented. Also if we create a PSSM with a biased database our PSSM will be biased too.

Now by looking at the obtained results we’ve seen that our knowledge on PDB being redundant and biased is certain since we have very high bias scores and lots of repeated proteins. On the other hand, uniprot gives a less biased percentage and also a higher score so therefore we’ve chosen to retrieve our proteins for which we’re going to perform the multiple sequence alignment from uniprot.

```bash
# Query on the PDB Database
hmmsearch hsp90_pdb.hmm /shared/databases/blastdat/pdb_seq > hsp90_pdb_2.out
```

![img](https://lh5.googleusercontent.com/MaO8UD7KstofjQcLt4fwfT_yHIba9NM3kQgAAR3XMiTHmBd2cFOkZngosRvV-3KL5Aq1LXksiFOaKALnnSjaGl9vuMU6f3cQLSlWsANmukDq3dEBGs3Ua6VznjsXYqGCfuDIdR7Q)

```bash
# Query on the UniProt Database
hmmsearch hsp90_pdb.hmm /shared/databases/blastdat/uniprot_sprot > hsp90_uniprot.out
```

![img](https://lh3.googleusercontent.com/26qsgETHQoUOFFCsXBJq0aY2yp5GWnm1AmSGSLa2QHGPPKyxD_0-F6DTcwZTj6lq3yeqs0WNwrn8tmgPhPv2pqJPnzMv2BTsi4wepwVNqa70zOXy3A8iXDeMDz8p7RxZB0IpBEvo)



**3. Make a sequence alignment with the sequences you just obtained in the previous step. To create this alignment, use the HMM you found in PFAM and the programs from the HMMer package.**

Sequences, obtained from the hmmsearch command, from which we create the multiple sequence alignment fasta file using the cat file.fa >> output_file.fa command:

```bash
# Joining all fasta sequences in a single file, putting our target fasta sequence (P02829.fasta) as the first one: 
cat P02829.fasta > FINAL.fasta
cat B8IU50.fasta > FINAL.fasta
cat P04811.fasta > FINAL.fasta
...
```

sp|B8IU50|HTPG_METNO  Chaperone protein htpG OS=Methylobacterium nodulans GN=htpG

sp|P04811|HSP83_DROVI  Heat shock protein 83 (Fragment) OS=Drosophila virilis GN=Hsp83

sp|P11501|HS90A_CHICK  Heat shock protein HSP 90-alpha OS=Gallus gallus GN=HSP90AA1

sp|P35016|ENPL_CATRO  Endoplasmin homolog OS=Catharanthus roseus GN=HSP90

sp|P58477|HTPG_RHIME  Chaperone protein htpG OS=Rhizobium meliloti (strain 1021) GN=htpG

sp|Q86L04|TRAP1_DICDI  TNF receptor-associated protein 1 homolog, mitochondrial OS=Dictyostelium discoideum GN=trap1

sp|Q9CQN1|TRAP1_MOUSE  Heat shock protein 75 kDa, mitochondrial OS=Mus musculus GN=Trap1



With our MSA file (FINALf.fasta) we perform the hmmalign command (hmmalign HSP90_domain.hmm FINALf.fasta > HSP90_hmm.sto):

![img](https://lh3.googleusercontent.com/oBGme0HEduFDeV7C5T-vqIg4dBF03n90vwd8mhwonmCT9Zm0oqDZGWyqvm8bt_zcOUc_xEkT24lgfF79lp0xGcH43ltl2Ir8dVD4V65lj6yr0P1QMfN3VJftmsa8sNNuZP8MSvc8)



We can also perform the clustalw2 command with the FINALf.fasta file (clustalw2 FINALf.fasta):

![img](https://lh6.googleusercontent.com/Z0An_ZwFzPgL-9AXt6d16lyFygfu7y6jCqmqLsgLbZkX_t3aU5gUkFGkjnu_zhziVlb9TrmlBkUK2fC2mD3FwUuGbqc1uTEOzlrshxAKRVmn0CeB4pwSuj5robbM5eN4wK9yQWXC)

```
# Run ClustalW to perform MSA using HSP90 sequences
clustalw2 FINAL.fasta 

# Use hmmalign to make a MSA with HSP90 sequences
hmmalign HSP90.hmm fastas/FINAL.fasta > HSP90.sto
# Change format of the MSA using perl script:
perl /shared/PERL/aconvertMod2.pl -in h -out c <HSP90.sto>HSP90.clu

```



**4. Search for conserved regions in your alignment. Do these regions correspond with the essential regions you described in the previous assignment (question 6)? Why do you think this is happening? Provide images of your alignment to support your explanation. In these images, the alignments should be in clustalw format, use the perl script we learnt in practice 2 to change the format of the alignments produced by hmmer programs.**

Q6) Our protein presents a motif ( regions of protein structure that may or may not be defined by a unique chemical or biological function) from position 723 to 732, essential for tetratricopeptide repeat (TPR) repeat-binding domains, which bind specific peptide ligands and are thought to mediate protein–protein interactions in a variety of biological systems, in this case the TPR repeat-binding motif mediates interaction with TPR repeat-containing proteins like the co-chaperone STUB1.

This motif consists of two protein regions: the first one (728-732), is essential for interaction with SMYD3, TSC1 and STIP1/HOP and the second one (729-732), is essential for interaction with SGTA and TTC1.

This region is also essential for other proteins of our family because since our essential region is found in the motif we can state that it is shared among other proteins.



**5. Work with the mutation you choose in the previous assignment (assignment 1, question 7). Find where this mutation would happen in the alignment you created in question 3. Compare the mutated amino acid with the amino acids that you find at that position in your alignment, do they share similar properties or not? Make a hypothesis of how this mutation is affecting the function of the protein. Provide images of your alignment to support your explanation.**

Q7) One of the mutations that can occur in position 598 of our protein, concretely in the endothelial cells, is the substitution of the C amino acid to either the A, N or D amino acids which causes the reduction of ATPase activity and client protein activation. This mutation is signaled by the S-nitrosylation of which our chaperone Hsp90 is a target. This S-nitrosylation affects the positive effect Hsp90 has on eNOS and limits the eNOS activation. This can derive into serious health issues like excess production of superoxide, hypertension, hypercholesterolemia, diabetes mellitus and many more since eNOS, an enzyme that generates the vasoprotective molecule nitric oxide (NO·), is a major weapon of endothelial cells to fight vascular disease.