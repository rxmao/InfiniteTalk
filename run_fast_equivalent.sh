#!/bin/bash
# =============================================================================
# InfiniteTalk 高速生成脚本 (等效于 ComfyUI 工作流配置)
# 基于: InfiniteTalk单人图生视频.json
# 速度: 约 8-10x 加速 (4步 vs 40步)
# =============================================================================

python generate_infinitetalk.py \
    \
    # ============ 模型路径配置 ============
    --ckpt_dir weights/Wan2.1-I2V-14B-480P \
    --wav2vec_dir weights/chinese-wav2vec2-base \
    --infinitetalk_dir weights/InfiniteTalk/single/infinitetalk.safetensors \
    \
    # ============ LoRA 加速配置 (关键!) ============
    --lora_dir weights/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors \
    --lora_scale 0.8 \
    \
    # ============ FP8 量化配置 (2x 推理加速) ============
    --quant fp8 \
    --quant_dir weights/InfiniteTalk/quant_models/infinitetalk_single_fp8.safetensors \
    \
    # ============ 输入配置 ============
    --input_json examples/single_example_image.json \
    --size infinitetalk-480 \
    \
    # ============ 采样参数 (等效工作流) ============
    --sample_steps 4 \                      # 工作流: steps=4
    --sample_shift 11.0 \                   # 工作流: shift=11.0
    --sample_text_guide_scale 1.0 \         # 工作流: cfg=1.0
    --sample_audio_guide_scale 2.0 \        # 工作流推荐值 (使用 LoRA 后)
    --base_seed 1 \                         # 工作流: seed=1
    \
    # ============ 视频生成参数 ============
    --mode streaming \                      # 长视频模式
    --frame_num 81 \                        # 工作流: frame_window_size=81
    --motion_frame 9 \                      # 工作流实际使用 25，但脚本推荐 9
    --max_frame_num 1000 \                  # 最大生成 40 秒 (1000帧 @ 25fps)
    \
    # ============ 显存优化 (等效工作流) ============
    --num_persistent_param_in_dit 0 \       # 工作流: block_swap=30 + offload_device
    --offload_model true \                  # 工作流: force_offload=true
    \
    # ============ 高级优化 ============
    --color_correction_strength 1.0 \       # 工作流: colormatch=mkl
    \
    # ============ 输出配置 ============
    --save_file infinitetalk_fast \
    --audio_save_dir save_audio_fast

# =============================================================================
# 性能预估 (22秒视频, 24GB 显卡):
# - 原始配置 (40步): ~10 分钟
# - 此配置 (4步):    ~1-2 分钟  (8-10x 加速)
# =============================================================================
