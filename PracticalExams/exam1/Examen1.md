You can use your notes and materials of the classes if you want, you can also check biological databases.

```bash
ssh u106390@ec2-54-195-53-87.eu-west-1.compute.amazonaws.com
module load BLAST/2.10.1-Linux_x86_64 
```

 

**In this exercise we are working with a protein for which we have its sequence in a separate file (target.fa) and its structure in a separate pdb file (target.pdb). Answer the following questions about the protein we are studying:**

<u>a) What function do you think it may have?</u>

```bash
# Load BLAST module:
module load BLAST/2.10.1-Linux_x86_64

# Perform blastp query of target 
## in PDB database:
blastp -query target.fa -db /shared/databases/blastdat/pdb_seq -out target_pdb.out 
```

```bash
## in Uniprot database:
blastp -query target.fa -db /shared/databases/blastdat/uniprot_sprot -out target_uni.out 
```



```bash
# Perform psiblast to create PSSM:
psiblast -query target.fa -num_iterations 5 -out_pssm target_uni.pssm -db /shared/databases/blastdat/uniprot_sprot.fasta 
## Search for templates in Uniprot database:
psiblast -db /shared/databases/blastdat/uniprot_sprot -num_iterations 5 -in_pssm target_uni.pssm -out target_uni_PSSM.out

# ···> Round 5 ---> sp|P04242|HBAD_STRCA Hemoglobin subunit alpha-D
```

Find function in Uniprot: https://www.uniprot.org/uniprot/ P04242 #function

**[Answer]: Involved in oxygen transport from the lung to the various peripheral tissues.**



<u>b) Does it belongs to some family of PFAM?. If so, obtain the HMM profile from PFAM and name it p28b.hmm</u>

```bash
# Perfom hmmscan to retrieve HMM from input sequence:
hmmscan /shared/databases/pfam-3/Pfam-A.hmm target.fa > target_pfam.out 

# Perform hmmfetch to extract HMM
hmmfetch /shared/databases/pfam-3/Pfam-A.hmm Globin > p28b.hmm 
```



<u>c) the structure of this protein belongs to some fold in SCOP?, which one?</u> 



<u>d) Obtain at least three more sequences with known structure and align them with the sequence of the PROBLEM using the HMM profile.  Name the alignment p28b.aln</u>



<u>e) Obtain the secondary structure with DSSP and name it p28e.dssp</u>



<u>f) Do you think the prediction of secondary structure agrees with the actual secondary structure from DSSP?. Obtain an alignment as proof and name it p28f.aln. Is this prediction reliable?</u>



<u>g) Do you think the structure is correct? Can you prove it? show an image of the energies that prove it and name it p28g.png</u> 



<u>h) Find if there is some structural problem and show the location with an image (name it p28h.png). What's the sequence fragment with this problem?</u>



<u>i) Do you think the protein PROBLEM can work as a tetramer? show an image that can prove it (name it p28i.png)</u>



<u>j) Even if it was a monomer, do you think it will work with the function you selected in answer "a"? Use a sequence alignment (ie. you can reuse p28d.aln) to show the conservation/non-conservation of functional residues. Mark the functionally important amino-acids (conserved or non-conserved) in the alignment with the symbol # at the bottom.</u>



<u>k) To further proof your answer in "j": Show an image of the structure of the active site with the relevant aminoacids that preserve (or don't preserve) the function in its active form (i.e. if it requires a cofactor, such as ATP, Ca, etc. include it in the active site interacting with the corresponding residues of the PROBLEM). Name it p28k.png</u> 



<u>l) If the structure of the PROBLEM was incorrect (answer in g), try to fix it. Name the new monomer model as p28l.pdb</u>