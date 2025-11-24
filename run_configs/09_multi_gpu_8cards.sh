#!/bin/bash
# =============================================================================
# 配置 9: 8卡混合并行 (工业级)
# 速度: ★★★★★ (6-7x 单卡)
# 质量: ★★★★★ (最高，720P)
# 适用: 超长视频 (30分钟+) / 高分辨率 / 工业生产
# 硬件: 8×A100 80GB (NVLink 必须)
# =============================================================================

GPU_NUM=8

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
    # === 8卡混合并行配置 (Ulysses + Ring) ===
    --dit_fsdp \
    --t5_fsdp \
    --ulysses_size=4 \
    --ring_size=2 \
    \
    # === 生成参数 (720P 高清) ===
    --size infinitetalk-720 \
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
    --max_frame_num 90000 \
    --color_correction_strength 1.0 \
    \
    --save_file output_8gpu_720p_ultra_long

# =============================================================================
# 性能预估 (60分钟 720P视频, 90000帧):
# - 单卡: 200-240 分钟
# - 8卡:  28-35 分钟  (加速比 6.5-7.2x)
#
# 硬件要求:
# - 8×A100 80GB (NVLink 必须!)
# - 或 8×H100 80GB
#
# 性价比: ⭐⭐⭐ (仅大规模生产)
#
# 并行策略:
# - Ulysses=4: 序列切分为 4 份
# - Ring=2: 每份再用环形注意力
# - 总共 4×2=8 卡
# =============================================================================
