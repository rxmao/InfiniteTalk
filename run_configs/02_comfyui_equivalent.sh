#!/bin/bash
# =============================================================================
# 配置 2: ComfyUI 工作流等效 (完全复刻)
# 速度: ★★★★☆ (很快)
# 质量: ★★★★☆ (良好)
# 适用: 复现工作流效果、生产环境
# =============================================================================

python generate_infinitetalk.py \
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    --input_json examples/single_example_image.json \
    \
    # === 精确复刻工作流配置 ===
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
    --base_seed 1 \
    \
    --mode streaming \
    --frame_num 81 \
    --motion_frame 9 \
    --num_persistent_param_in_dit 0 \
    --offload_model true \
    --color_correction_strength 1.0 \
    \
    --save_file output_comfyui_equivalent

# 预估速度: 22秒视频 → 约 1-2 分钟
# 质量: 与 ComfyUI 工作流完全一致
