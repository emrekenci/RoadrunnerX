#!/bin/bash
set -eo pipefail

# Clone or update the repository
if [ "$CLONE_REPO" = "1" ]; then
  if [ ! -d "RoadrunnerX" ]; then
    git clone https://github.com/felafax/RoadrunnerX.git
  else
    cd RoadrunnerX || exit
    git pull
    cd .. || exit
  fi
fi

if [ "$TORCH_XLA" = "1" ]; then
  # install pytorch stuff
  pip install torch~=2.3.0 torch_xla[tpu]~=2.3.0 torchvision -f https://storage.googleapis.com/libtpu-releases/index.html
  pip install --upgrade transformers
fi

echo 'export PJRT_DEVICE=TPU' >>~/.bashrc

# Mount the Google Cloud Storage bucket
# if [ -n "${UID+x}" ] && [ -n "$UID" ]; then
#   gcsfuse --implicit-dirs --only-dir "$UID" felafax-storage "/home/felafax-storage/"
# else
gcsfuse --implicit-dirs felafax-storage "/home/felafax-storage/"
# fi

# Start Jupyter Lab
exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
