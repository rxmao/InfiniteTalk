#!/bin/bash
# =============================================================================
# 配置 5: 低显存模式 (Low VRAM - 适用于 12GB 显卡)
# 速度: ★★★★☆ (快)
# 质量: ★★★★☆ (良好)
# 显存: 约 10-12GB (可在 RTX 3060/4060 Ti 运行)
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
    --size infinitetalk-480 \
    --sample_steps 4 \
    --sample_shift 11.0 \
    --sample_text_guide_scale 1.0 \
    --sample_audio_guide_scale 2.0 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    \
    # === 极致显存优化 ===
    --num_persistent_param_in_dit 0 \
    --offload_model true \
    --t5_cpu true \
    \
    --save_file output_low_vram

# 显存占用: 约 10-12GB
# 速度: 稍慢于标准配置（因为 CPU-GPU 传输）
