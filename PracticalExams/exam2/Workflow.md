Working with a protein for which we have its sequence in a separate file (target.fa).

<u>a) Does it belongs to some family of PFAM?. If so, obtain the HMM profile from PFAM and name it p28b.hmm</u>

```
hmmscan /shared/databases/pfam-3/Pfam-A.hmm target.fa > target.out
hmmfetch /shared/databases/pfam-3/Pfam-A.hmm zf-C4 > target.hmm 
hmmsearch target.hmm /shared/databases/blastdat/pdb_seq > target_pdb_HMM.out 
hmmsearch target.hmm /shared/databases/blastdat/uniprot_sprot > target_uni_HMM.out
```



<u>b) Do you think that this protein belongs to some fold in SCOP?, which one?</u>

http://scop.mrc-lmb.cam.ac.uk/legacy/search.cgi?ver=1.75

Fold: [Glucocorticoid receptor-like (DNA-binding domain)](http://scop.mrc-lmb.cam.ac.uk/legacy/data/scop.b.h.fe.A.html) [57715] (1dsz)

Fold: [Nuclear receptor ligand-binding domain](http://scop.mrc-lmb.cam.ac.uk/legacy/data/scop.b.b.cdh.A.A.html) [48507]



<u>c) What function do you think this protein may have?</u>

Receptor for retinoic acid (PubMed:[19850744](https://www.uniprot.org/citations/19850744), PubMed:[16417524](https://www.uniprot.org/citations/16417524), PubMed:[20215566](https://www.uniprot.org/citations/20215566)).

DNA-binding transcription factor activity



<u>d) Find 4 homologous proteins in the swissprot database and align them using the HMM you obtained in question a). Then, change the format of this alignment from stockholm to clustalw. Name this alignment homologs.aln.</u>

```bash
psiblast -query target.fa -num_iterations 5 -out target_sprot.out -db /shared/databases/blastdat/uniprot_sprot.fasta
psiblast -query target.fa -num_iterations 5 -out target_sprot.out -db /shared/databases/blastdat/pdb_seq
```

```bash
wget https://www.uniprot.org/uniprot/Q6QMY5.fasta
wget https://www.uniprot.org/uniprot/Q5QJV7.fasta
wget https://www.uniprot.org/uniprot/O08580.fasta
wget https://www.uniprot.org/uniprot/P11474.fasta

cat Q6QMY5.fasta > homologs.fasta
cat Q5QJV7.fasta >> homologs.fasta
cat O08580.fasta >> homologs.fasta
cat P11474.fasta >> homologs.fasta

hmmalign p28b.hmm homolgs.fasta > homologs.sto
perl /shared/PERL/aconvertMod2.pl -in h -out c <homologs.sto>homologs.aln
```



<u>e) Find one template for our protein.</u>

1dsz



<u>f) Use the template you obtained in the previous question to make a model of our target protein. Name this file model.pdb.</u>

```
wget https://files.rcsb.org/download/1DSZ.pdb
perl /shared/PERL/PDBtoSplitChain.pl -i 1DSZ.pdb -o 1DSZ 
clustalw2 target_template.fa
perl /shared/PERL/aconvertMod2.pl -in c -out p <target_template.aln>target_template.pir 
```

```
wget https://files.rcsb.org/download/3D24.pdb
wget https://files.rcsb.org/download/1XB7.pdb
```

