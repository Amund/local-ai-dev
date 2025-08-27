# Local AI Dev

`vs-code + continue + docker`

This is my personal AI-assisted development system with no internet connection. If it can be of use to anyone, please feel free to use it.

## Description

This repository contains the complete configuration to run multiple Qwen3 models in parallel with [llama-swap](https://github.com/mostlygeek/llama-swap/) in a Docker container with Vulkan support. It allows you to benefit from complete AI assistance locally, without any internet connection required.

It works not so bad on my desktop, an average computer with a 8Gb GPU. You can adjust models parameters in `config.yml` to adapt for your hardware.

## Configured Models

The project uses the following models:
- **Qwen3-Coder-30B-A3B-Instruct**: Non-thinking MoE coder
- **Qwen3-30B-A3B-Thinking**: Thinking MoE chat
- **Qwen3-4B-Instruct**: Lighter fill-in-the-middle (FIM)
- **Qwen3-Embedding-0.6B**: Embedding model
- **Qwen3-Reranker-0.6B**: Reranking model (**TODO**)

**TODOs**: reranker has problem at this time (https://github.com/ggml-org/llama.cpp/pull/14029)

## Pre-requisites

- [vs-code](https://code.visualstudio.com/)
- [continue](https://marketplace.visualstudio.com/items?itemName=Continue.continue) plugin
- docker (with compose)

## Installation

- Clone this repository
- Download models with `make download-models`
- Copy continue agent to its global config folder with `make copy-agent`
- Start containers with `make up`
- In vscode, open continue, change "Local Agent" to "Qwen3 local"
- Ask something, and wait for the model's loading. Once loaded, the next response should be fast.
