#!/bin/bash
# =============================================================================
# 配置 4: 高质量模式 (High Quality)
# 速度: ★★☆☆☆ (较慢)
# 质量: ★★★★★ (最佳)
# 适用: 最终交付、展示作品、重要项目
# =============================================================================

python generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    # === 不使用 LoRA，原始模型质量 ===
    --size infinitetalk-480 \
    --sample_steps 40 \
    --sample_shift 7.0 \
    --sample_text_guide_scale 5.0 \
    --sample_audio_guide_scale 4.0 \
    --base_seed 42 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    \
    --use_apg \
    --apg_momentum -0.75 \
    --apg_norm_threshold 55 \
    \
    --save_file output_high_quality

# 预估速度: 22秒视频 → 约 8-10 分钟
# 质量: 最高，细节最丰富
