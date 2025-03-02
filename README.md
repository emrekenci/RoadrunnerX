# RoadrunnerX -- tune LLaMa3.1 on Google Cloud TPUs for 30% lower cost and scale seamlessly!

![image](./utils/assets/image.jpg)

RoadRunnerX is a framework for continued-training and fine-tuning open source LLMs using **XLA runtime**. We take care of neceessary runtime setup and provide a Jupyter notebook out-of-box to just get started.
- Easy to use.
- Easy to configure all aspects of training (designed for ML researchers and hackers).
- Easy to scale training from a single VM with 8 TPU cores to entire TPU Pod containing 6000 TPU cores (**1000X**)!

## Goal
Our goal at [felafax](https://felafax.ai) is to build infra to make it easier to run AI workloads on non-NVIDIA hardware (TPU, AWS Trainium, AMD GPU, and Intel GPU).

## Currently supported models

- LLaMa-3/3.1 8B, 70B on Google Cloud TPUs. 
  - Supports LoRA and full-precision training.
  - Tested on TPU v3, v5p.
- LLaMa-3.1 405B will be available on our cloud platform at felafax.ai -- sign-up for the [waitlist](https://tally.so/r/mRLeaQ)!
- Gemma2 2B, 9B, 27B on Cloud TPUs. $${\color{red}New!}$$	 
  - Supports fast full-precision training.
  - Tested on TPU v3, v5p.

## Setup

**For a hosted version with a seamless workflow, please visit [app.felafax.ai](https://app.felafax.ai)** 🦊. 

If you prefer a self-hosted training version, follow the instructions below. These steps will guide you through launching a TPU VM on your Google Cloud account and starting a Jupyter notebook. With just 3 simple steps, you'll be up and running in under 10 minutes. 🚀

1. Install gcloud command-line tool and authenticate your account (SKIP this STEP if you already have gcloud installed and have used TPUs before! 😎)

   ```bash
    # Download gcloud CLI
    curl https://sdk.cloud.google.com | bash
    source ~/.bashrc

    # Authenticate gcloud CLI
    gcloud auth login

    # Create a new project for now
    gcloud projects create LLaMa3-tunerX --set-as-default

    # Config SSH and add
    gcloud compute config-ssh --quiet
   
    # Set up default credentials
    gcloud auth application-default login

    # Enable Cloud TPU API access
    gcloud services enable compute.googleapis.com tpu.googleapis.com storage-component.googleapis.com aiplatform.googleapis.com
   ```

2. Spin up a TPU v5-8 VM 🤠.

    ```bash
    sh ./launch_tuner.sh
    ```
    Keep an eye on the terminal -- you might be asked to input SSH key password and need to put in your HuggingFace token. 

3. Open the Jupyter notebook at `https://localhost:888` and start fine-tuning!

## Credits:
- PyTorch XLA FSDP and SPMD testing done by [HeegyuKim](https://github.com/HeegyuKim/torch-xla-SPMD).
- Examples from [PyTorch-XLA](https://github.com/pytorch/xla/) repo.
