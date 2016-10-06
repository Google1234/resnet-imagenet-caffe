export PYTHONPATH="/home/heyihui/heyihui-local/caffe/python"
export PYTHONPATH="${PYTHONPATH}:/home/heyihui/resnet-cifar10-caffe"
# ${PYTHONPATH}:
set -x

GPUs=$1
NET=$2
# EXTRA_ARGS=${array[@]:3:$len}
# EXTRA_ARGS_SLUG=${EXTRA_ARGS// /_}
EXTRA_ARGS_SLUG=$3

solver=${NET}/solver.prototxt
LOG=${NET}"/logs/${NET}_${EXTRA_ARGS_SLUG}_`date +'%Y-%m-%d_%H-%M-%S'`.log"
exec &> >(tee -a "$LOG")
echo Logging output to "$LOG"

time /home/heyihui/heyihui-local/caffe/build/tools/caffe train -gpu ${GPUs} \
    -solver ${solver} \
    -sighup_effect stop
#    ${EXTRA_ARGS}

set +x

echo -e "\a"
