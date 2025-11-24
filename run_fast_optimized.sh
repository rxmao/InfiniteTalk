#!/bin/bash
# ComfyUI 等效配置 - 速度优化版（移除显存优化）

nohup python -u generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    --lora_dir weights/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors \
    --lora_scale 0.8 \
    \
    --quant fp8 \
    --quant_dir weights/InfiniteTalk/quant_models/infinitetalk_single_fp8.safetensors \
    \
    --size infinitetalk-480 \
    --sample_steps 4 \
    --sample_shift 11.0 \
    --sample_text_guide_scale 1.0 \
    --sample_audio_guide_scale 2.0 \
    --base_seed 1 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    --color_correction_strength 1.0 \
    \
    --save_file output_fast \
    > generate_fast.log 2>&1 &

echo "已启动优化版本"
echo "预计耗时: 5-8分钟 (10秒音频)"
echo "查看日志: tail -f generate_fast.log"

# 注意: 移除了这两个参数以提高速度
# --num_persistent_param_in_dit 0
# --offload_model true
