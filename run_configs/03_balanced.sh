#!/bin/bash
# =============================================================================
# 配置 3: 平衡模式 (Balanced)
# 速度: ★★★☆☆ (较快)
# 质量: ★★★★☆ (优秀)
# 适用: 日常使用、客户交付
# =============================================================================

python generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    --lora_dir weights/Wan2.1_I2V_14B_FusionX_LoRA.safetensors \
    --lora_scale 0.6 \
    --quant fp8 \
    --quant_dir weights/InfiniteTalk/quant_models/infinitetalk_single_fp8.safetensors \
    \
    --size infinitetalk-480 \
    --sample_steps 8 \
    --sample_shift 7.0 \
    --sample_text_guide_scale 1.5 \
    --sample_audio_guide_scale 3.0 \
    --base_seed 42 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    --num_persistent_param_in_dit 0 \
    \
    --save_file output_balanced

# 预估速度: 22秒视频 → 约 3-4 分钟
# 质量: 接近原始 40 步的 95%
