## dataset
[ -z "${dataset}" ] && dataset=range_tfs_train
[ -z "${template}" ] && template=vanilla

## LLMs to use
# [ -z "${path_to_llama_model}" ] && path_to_llama_model=microsoft/biogpt
# [ -z "${path_to_llama_model}" ] && path_to_llama_model=THUDM/chatglm3-6b
# [ -z "${path_to_llama_model}" ] && path_to_llama_model=bigscience/bloom
# [ -z "${path_to_llama_model}" ] && path_to_llama_model=mistralai/Mistral-7B-v0.1
# [ -z "${path_to_llama_model}" ] && path_to_llama_model=meta-llama/Llama-2-7b-hf
[ -z "${path_to_llama_model}" ] && path_to_llama_model=meta-llama/Llama-2-13b-hf

# [ -z "${lora_target}" ] && lora_target=query_key_value
[ -z "${lora_target}" ] && lora_target=q_proj,v_proj
# [ -z "${lora_target}" ] && lora_target=c_attn

## savedir
[ -z "${path_to_sft_checkpoint}" ] && path_to_sft_checkpoint=/savedir/adapter/range_tfs_llama13
[ -z "${path_to_predict_result}" ] && path_to_predict_result=/savedir/predict_results/range_tfs_llama13

## config
[ -z "${batch_size}" ] && batch_size=8
[ -z "${gradient_accumulation_steps}" ] && gradient_accumulation_steps=1
[ -z "${num_train_epochs}" ] && num_train_epochs=50

CUDA_VISIBLE_DEVICES=0 python src/train_bash.py \
    --stage sft \
    --do_train \
    --model_name_or_path $path_to_llama_model \
    --dataset $dataset \
    --template $template \
    --finetuning_type lora \
    --lora_target $lora_target \
    --output_dir $path_to_sft_checkpoint \
    --overwrite_cache \
    --per_device_train_batch_size $batch_size \
    --gradient_accumulation_steps $gradient_accumulation_steps \
    --lr_scheduler_type cosine \
    --logging_steps 10 \
    --save_steps 500 \
    --learning_rate 5e-5 \
    --num_train_epochs $num_train_epochs \
    --plot_loss \
    --overwrite_output_dir \
    --fp16 

dataset=range_tfs_test

CUDA_VISIBLE_DEVICES=0 python src/train_bash.py \
    --stage sft \
    --do_predict \
    --model_name_or_path $path_to_llama_model \
    --adapter_name_or_path $path_to_sft_checkpoint \
    --dataset $dataset \
    --template $template \
    --finetuning_type lora \
    --output_dir $path_to_predict_result \
    --per_device_eval_batch_size $batch_size \
    --predict_with_generate \
    --fp16