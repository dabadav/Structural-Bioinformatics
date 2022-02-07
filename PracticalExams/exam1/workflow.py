import subprocess as sp

modules = "module load BLAST/2.10.1-Linux_x86_64"
process = sp.Popen(modules.split(),stdout=sp.PIPE)
output, error = process.communicate()