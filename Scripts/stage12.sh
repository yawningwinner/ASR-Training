#! /bin/bash
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
#SBATCH --gres=gpu:A100-SXM4:1
#SBATCH --partition=testp
#SBATCH --time=2-00:00:00
#SBATCH --error=%J.stage12.err
#SBATCH --output=%J.stage12.out
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
./asr.sh --stage 12 --stop_stage 12 --train_set train --valid_set dev --test_sets test --use_ngram false --use_lm true --ngpu 1 --gpu_inference true --inference_nj 1 --asr_exp "exp/asr_train_asr_e_branchformer_raw_bpe128" --lm_exp "exp/lm_train_lm_transformer2_bpe128" --ngram_exp exp/ngram --inference_config "conf/decode_asr.yaml"
conda deactivate
conda deactivate
##########################################################
echo "Ended at `date`"
