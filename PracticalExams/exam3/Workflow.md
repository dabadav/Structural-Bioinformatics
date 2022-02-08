Work with two protein structures called SH2.pdb and SH3.pdb. 

<u>a) Obtain the amino acid sequences corresponding with the two structures.</u>

```bash
# This program splits one PDB file in different chains and corrects the PDB format. It 
# also provides us the fasta sequence of each one of the chains. 
perl /shared/PERL/PDBtoSplitChain.pl -i SH2.pdb -o SH2
perl /shared/PERL/PDBtoSplitChain.pl -i SH3.pdb -o SH3
```

<u>b) Are there HMMs from PFAM for each of these structures?</u>

```bash
## Assign best profiles to target seq using hmmscan on pfam
hmmscan /shared/databases/pfam-3/Pfam-A.hmm SH2.fa > SH2.out
hmmscan /shared/databases/pfam-3/Pfam-A.hmm SH3.fa > SH3.out
## Extract profiles from Pfam that correspond to domains of target seq 
hmmfetch /shared/databases/pfam-3/Pfam-A.hmm "SH2" > SH2.hmm 
hmmfetch /shared/databases/pfam-3/Pfam-A.hmm "SH3_1" > SH3.hmm 
```

<u>c) Find 4 homologous sequence for SH2. Put them into a single multifasta file.</u> 

```bash
hmmsearch SH2.hmm /shared/databases/blastdat/pdb_seq > SH2_pdb_homologs.out
hmmsearch SH2.hmm /shared/databases/blastdat/uniprot_sprot > SH2_uni_homologs.out
```

```
wget https://www.uniprot.org/uniprot/P29349.fasta
wget https://www.uniprot.org/uniprot/Q06124.fasta
wget https://www.uniprot.org/uniprot/P16885.fasta
wget https://www.uniprot.org/uniprot/P29351.fasta
```

```
cat P29349.fasta > homologs.fasta
cat Q06124.fasta > 
```

<u>d) Make a MSA of the 4 sequences you obtained previously using the corresponding HMM & change the format of the alignment to clustalw format</u>

```
hmmalign SH2.hmm homologs.fa > homologs_MSA.sto 
perl /shared/PERL/aconvertMod2.pl -in h -out c <homologs_MSA.sto>homologs_MSA.aln 
```

<u>e) We want to study the L253R mutation in SH2. Model the structure of SH2 containing this mutation. Be aware that the structure that you have is not complete, therefore the first amino acid corresponds with position 232. Name your model as mutant_model.pdb.</u>

1. Open SH2.pdb in PyMol

2. Change aa in pos 253 to R (Arg)

```bash
perl /shared/PERL/PDBtoSplitChain.pl -i mutation_model.pdb -o mutation_model

# Create multifasta with SH2.fa & mutant_modelB.fa
cat SH2B.fa > target_template.fa
cat mutation_modelB.fa >> target_template.fa

# Clustalw2 alignment
clustalw2 target_template.fa 

# Change format to pir
perl /shared/PERL/aconvertMod2.pl -in c -out p < target_template.aln > target_template.pir
```

```
module load modeller/10.0
source activate modeller
mod10.0 modeling.py 
```

<u>f) Analyze the mutant model you generated previously with ProSa and compare it with a reference structure. Can you tell what is the effect of the mutation in the overall stability of the protein? What reference structure are you using? Take an image of the comparison of the two ProSa profiles and save it as prosa_analysis.png.</u>



<u>g) Search for a structure containing two proteins interacting, one being homolog to SH2 and the other to SH3. Name this file as template.pdb.</u>

