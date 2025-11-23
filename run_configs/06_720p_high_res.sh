#!/bin/bash
# =============================================================================
# 配置 6: 720P 高分辨率模式
# 速度: ★★☆☆☆ (慢)
# 质量: ★★★★★ (最佳分辨率)
# 显存: 约 20-24GB (需要 RTX 4090/A100)
# =============================================================================

python generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    --lora_dir weights/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors \
    --lora_scale 0.8 \
    --quant fp8 \
    --quant_dir weights/InfiniteTalk/quant_models/infinitetalk_single_fp8.safetensors \
    \
    --size infinitetalk-720 \
    --sample_steps 4 \
    --sample_shift 11.0 \
    --sample_text_guide_scale 1.0 \
    --sample_audio_guide_scale 2.0 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    \
    --save_file output_720p

# 预估速度: 22秒视频 → 约 3-5 分钟
# 分辨率: 720P (约 1280x720)
