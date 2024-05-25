# Evaluate_LLMs_to_Genes

Welcome to the official repository for the paper "How do LLMs Understand Genes and Cells". 

This project explores the capabilities of large language models (LLMs) in the realm of cellular biology. By leveraging the LLaMA_Factory framework, we fine-tune LLMs for gene-related challenges, paving new paths in bioinformatics research.

## Quick Links

- [Dataset for Downstream Tasks](https://1drv.ms/f/c/1d37ede6eaa974dd/Et10qerm7TcggB0pAwAAAAAB3m7i9d0hrWYvK21KQgj0mA?e=8XTPd9)
- [LLaMA_Factory Framework](https://github.com/hiyouga/LLaMA-Factory)

## 

To replicate the experiments described in this paper, you first need to correctly install the LLaMA_Factory framework. Then, place the JSON data files from the above link into the LLaMA-Factory/data folder.

To start the fine-tuning process, run the provided training script by replacing {task_name} with the name of your specific task:

```bash
sh example_{task_name}.sh
```
