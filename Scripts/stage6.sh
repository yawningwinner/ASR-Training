#! /bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
#SBATCH --partition=cpup
#SBATCH --time=2-00:00:00
#SBATCH --error=%J.stage6.err
#SBATCH --output=%J.stage6.out
echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Job id is $SLURM_JOBID"
echo "Job submission directory is : $SLURM_SUBMIT_DIR"

set -e
set -u
set -o pipefail

cd /nlsasfs/home/nltm-st/akankss/espnet/egs2/001_hindi_all/asr1
#################conda environment path ################################
source /nlsasfs/home/nltm-st/akankss/espnet/tools/miniconda/bin/activate
export PATH="/nlsasfs/home/nltm-st/akankss/local/bin/:$PATH"
conda activate espnet
./asr.sh --stage 6 --stop_stage 6 --train_set train --valid_set dev --test_sets test --nj 30 --lm_config "conf/train_lm_transformer2.yaml" --nbpe 128
conda deactivate
conda deactivate
##########################################################
echo "Ended at `date`"
