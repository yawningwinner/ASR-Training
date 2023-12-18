#! /bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --partition=cpup
#SBATCH --time=0-01:00:00
#SBATCH --error=%J.stage1.err
#SBATCH --output=%J.stage1.out
echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Job id is $SLURM_JOBID"
echo "Job submission directory is : $SLURM_SUBMIT_DIR"

set -e
set -u
set -o pipefail

cd /nlsasfs/home/nltm-st/akankss/espnet/egs2/001_hindi_all/asr1/
#################conda environment path ################################
source /nlsasfs/home/nltm-st/akankss/espnet/tools/miniconda/bin/activate  # sources conda into the path
export PATH="/nlsasfs/home/nltm-st/akankss/local/bin/:$PATH" # to source local installations into the path
conda activate espnet # activating the conda env
# add the main run scripts here
./asr.sh --stage 1 --stop-stage 1 --train_set train --valid_set dev --test_sets test --eval_valid_set true
conda deactivate  # deactivates espnet
conda deactivate  # deactivates base
##########################################################
echo "Ended at `date`"
