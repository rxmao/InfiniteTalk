#!/bin/bash
# =============================================================================
# InfiniteTalk 快速启动菜单
# 自动选择最适合的配置并运行
# =============================================================================

echo "=========================================="
echo "  InfiniteTalk 快速启动菜单"
echo "=========================================="
echo ""
echo "请选择运行配置:"
echo ""
echo "  1) 🚀 极速模式        (1分钟, 适合测试)"
echo "  2) ⚡ ComfyUI等效     (1-2分钟, 推荐)"
echo "  3) ⚖️  平衡模式        (3-4分钟, 高质量)"
echo "  4) 💎 最高质量        (8-10分钟, 交付用)"
echo "  5) 💾 低显存模式      (2-3分钟, 12GB显卡)"
echo "  6) 🎬 720P高清        (3-5分钟, 需24GB)"
echo ""
echo "  0) 退出"
echo ""
read -p "请输入选项 [0-6]: " choice

case $choice in
    1)
        echo ""
        echo "启动: 极速模式 (4步 lightx2v)"
        echo "预计耗时: 约 1 分钟"
        bash 01_ultra_fast.sh
        ;;
    2)
        echo ""
        echo "启动: ComfyUI 等效配置"
        echo "预计耗时: 约 1-2 分钟"
        bash 02_comfyui_equivalent.sh
        ;;
    3)
        echo ""
        echo "启动: 平衡模式 (8步 FusionX)"
        echo "预计耗时: 约 3-4 分钟"
        bash 03_balanced.sh
        ;;
    4)
        echo ""
        echo "启动: 高质量模式 (40步无LoRA)"
        echo "预计耗时: 约 8-10 分钟"
        bash 04_high_quality.sh
        ;;
    5)
        echo ""
        echo "启动: 低显存模式 (适用12GB显卡)"
        echo "预计耗时: 约 2-3 分钟"
        bash 05_low_vram.sh
        ;;
    6)
        echo ""
        echo "启动: 720P 高分辨率模式"
        echo "预计耗时: 约 3-5 分钟"
        echo "⚠️  需要 20GB+ 显存"
        bash 06_720p_high_res.sh
        ;;
    0)
        echo "退出"
        exit 0
        ;;
    *)
        echo "无效选项，请重新运行脚本"
        exit 1
        ;;
esac
