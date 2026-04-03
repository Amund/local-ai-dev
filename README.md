# Local AI Dev

`vs-code + continue + docker`

This is my personal AI-assisted development system with no internet connection. If it can be of use to anyone, please feel free to use it.

## Description

This repository contains the complete configuration to run multiple Qwen3 models in parallel with [llama-server](https://github.com/ggml-org/llama.cpp/blob/master/tools/server/README.md) in a Docker container with Vulkan support. It allows you to benefit from complete AI assistance locally, without any internet connection required.

It works not so bad on my desktop, an average computer with a 8Gb GPU. You can adjust models parameters in `config.ini` to adapt for your hardware.

## Pre-requisites

- [vs-code](https://code.visualstudio.com/)
- [continue](https://marketplace.visualstudio.com/items?itemName=Continue.continue) plugin
- docker (with compose)

## Installation

- Clone this repository
- Start containers with `make up`
- Check `http://localhost:9090/` to see if the server is running and models are available. You can launch first downloads from there. Models are then cached in the `models` folder.
- Copy opencode config to its global config folder with `make sync-opencode`
- Copy continue agent to its global config folder with `make sync-continue`

## Update

`llama.cpp` is updated frequently, so you can update the container with `make update`. Server is stopped and started again, with fresh image. `make restart` can be used to restart the server without updating the image.

## TODO

- Check rocm backend support. For now, vulkan backend is faster on my machine.
- Test a finetuned FIM model
