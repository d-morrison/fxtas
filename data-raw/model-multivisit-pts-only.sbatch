#!/bin/bash -f
#  model-multivisit-pts-only.sbatch
#
#  UGE job for model-multivisit-pts-only built Tue Jul 4 2018
#
#  The following items pertain to this script
#  Use current working directory
#$ -cwd
#SBATCH -o "./logs/model-multivisit-pts-only.R.joblog.%A.%2a"

#  Resources requested
##SBATCH --time 4-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
##SBATCH --oversubscribe
##SBATCH --ntasks-per-core 10
##SBATCH --ntasks-per-node 100
#SBATCH --mem-per-cpu 4G
#SBATCH --cpus-per-task 1

#  Email address to notify
#SBATCH --mail-user demorrison@ucdavis.edu
#  Do not notify at beginning and end of job
#SBATCH --mail-type FAIL,REQUEUE
#  Job is rerunable
#SBATCH --requeue
#
#  Job array indexes
#SBATCH --array=1-1:1
#
# Initialization for serial execution
#
# these variables are used in the script sourced below: /u/local/bin/qq.sge/qr.runtime
  export qqidir="$PWD"
  export qqjob="model-multivisit-pts-only.R"
  export qqodir="out/$qqjob/$SLURM_ARRAY_JOB_ID"
  mkdir -p "$qqodir"
  cd "$qqidir"

  echo ""
  echo "SLURM_CPUS_ON_NODE = $SLURM_CPUS_ON_NODE"
  echo "SLURM_CPUS_PER_TASK = $SLURM_CPUS_PER_TASK"
  echo "Task $SLURM_ARRAY_TASK_ID started on:   "` hostname -s `
  echo "Task $SLURM_ARRAY_TASK_ID started at:   "` date `
  echo ""
#
# Run the user program
#
  # if more than 10 jobtasks, send only "a" mail.  until...
  # ... the last but 1 task so it applies to last task. then send or not per user preference.
  # if( 1000 > 10 && $SLURM_ARRAY_TASK_ID == 999 ) then
  #   /u/local/bin/qalter -m a %A
  #   sleep 2
  # endif
  which R
  R --version
  echo "which conda"
  which conda
  source ~/.bashrc
#  echo "loading conda from /etc"
#  source /etc/profile.d/conda.sh
  which conda
  conda activate fxtas39
  which R
  R --version
  echo ""
  echo Rscript  "$qqjob" $SLURM_ARRAY_TASK_ID \>\& "$qqodir/out.$SLURM_ARRAY_TASK_ID"
#
  # /usr/bin/time -p \
  Rscript "./$qqjob" $SLURM_ARRAY_TASK_ID >&  "$qqodir/out.$SLURM_ARRAY_TASK_ID"
#
  echo ""
  echo "Task $SLURM_ARRAY_TASK_ID finished at:  "` date `
