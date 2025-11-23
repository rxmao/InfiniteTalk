#!/bin/bash
# =============================================================================
# 配置 1: 极速模式 (Ultra Fast)
# 速度: ★★★★★ (最快)
# 质量: ★★★☆☆ (可用)
# 适用: 快速测试、草稿预览、大批量生产
# =============================================================================

python generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    --lora_dir weights/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors \
    --lora_scale 1.0 \
    --quant fp8 \
    --quant_dir weights/InfiniteTalk/quant_models/infinitetalk_single_fp8.safetensors \
    \
    --size infinitetalk-480 \
    --sample_steps 4 \
    --sample_shift 2.0 \
    --sample_text_guide_scale 1.0 \
    --sample_audio_guide_scale 2.0 \
    --base_seed 42 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    --num_persistent_param_in_dit 0 \
    --offload_model true \
    \
    --use_teacache \
    --teacache_thresh 0.2 \
    \
    --save_file output_ultra_fast

# 预估速度: 22秒视频 → 约 1 分钟
