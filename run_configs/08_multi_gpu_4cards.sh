#!/bin/bash
# =============================================================================
# 配置 8: 4卡并行 (超长视频)
# 速度: ★★★★★ (3.3-3.8x 单卡)
# 质量: ★★★★☆ (良好)
# 适用: 10-30分钟视频，专业生产
# 硬件: 4×RTX 4090 或 4×A6000 (推荐 NVLink)
# =============================================================================

GPU_NUM=4

torchrun --nproc_per_node=$GPU_NUM --standalone generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    # === LoRA 加速配置 ===
    --lora_dir weights/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors \
    --lora_scale 0.8 \
    \
    # === FP8 量化 ===
    --quant fp8 \
    --quant_dir weights/InfiniteTalk/quant_models/infinitetalk_single_fp8.safetensors \
    \
    # === 4卡并行配置 ===
    --dit_fsdp \
    --t5_fsdp \
    --ulysses_size=$GPU_NUM \
    \
    # === 生成参数 ===
    --size infinitetalk-480 \
    --sample_steps 4 \
    --sample_shift 11.0 \
    --sample_text_guide_scale 1.0 \
    --sample_audio_guide_scale 2.0 \
    --base_seed 42 \
    \
    # === 超长视频配置 ===
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    --max_frame_num 45000 \
    --color_correction_strength 1.0 \
    \
    --save_file output_4gpu_ultra_long

# =============================================================================
# 性能预估 (30分钟视频, 45000帧):
# - 单卡: 90-120 分钟
# - 4卡:  24-32 分钟  (加速比 3.5-3.8x)
#
# 硬件要求:
# - 4×RTX 4090 24GB (推荐 NVLink)
# - 或 4×RTX A6000 48GB
#
# 性价比: ⭐⭐⭐⭐ (专业级)
# =============================================================================
