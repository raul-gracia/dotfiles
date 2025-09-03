#!/bin/bash

# Test terminal colors and contrast

echo "=== ANSI Color Test ==="
echo ""

# Basic 16 colors with labels
echo "Basic 16 colors (foreground on default background):"
for i in {30..37}; do
    echo -e "\033[${i}mColor $i (normal)\033[0m  \033[1;${i}mColor $i (bold)\033[0m"
done
for i in {90..97}; do
    echo -e "\033[${i}mColor $i (bright)\033[0m"
done

echo ""
echo "Basic 16 colors (as backgrounds with white text):"
for i in {40..47}; do
    echo -e "\033[97;${i}m  Color $i  \033[0m"
done
for i in {100..107}; do
    echo -e "\033[30;${i}m  Color $i  \033[0m"
done

echo ""
echo "=== 256 Color Palette ==="
echo ""

# Color cube
echo "Color cube (6x6x6):"
for green in {0..5}; do
    for red in {0..5}; do
        for blue in {0..5}; do
            color=$((16 + red * 36 + green * 6 + blue))
            echo -en "\033[48;5;${color}m  \033[0m"
        done
        echo -n "  "
    done
    echo
done

echo ""
echo "Grayscale ramp:"
for i in {232..255}; do
    echo -en "\033[48;5;${i}m  \033[0m"
done
echo

echo ""
echo "=== True Color (24-bit) Test ==="
echo ""

# RGB gradient
echo "RGB gradients:"
for i in {0..255..5}; do
    echo -en "\033[48;2;${i};0;0m \033[0m"
done
echo " Red"

for i in {0..255..5}; do
    echo -en "\033[48;2;0;${i};0m \033[0m"
done
echo " Green"

for i in {0..255..5}; do
    echo -en "\033[48;2;0;0;${i}m \033[0m"
done
echo " Blue"

echo ""
echo "=== Text Contrast Test ==="
echo ""

# Test common color combinations
echo "Common text/background combinations:"
echo -e "\033[37;40mWhite on Black\033[0m"
echo -e "\033[30;47mBlack on White\033[0m"
echo -e "\033[32;40mGreen on Black\033[0m"
echo -e "\033[34;40mBlue on Black\033[0m"
echo -e "\033[33;40mYellow on Black\033[0m"
echo -e "\033[31;40mRed on Black\033[0m"
echo -e "\033[35;40mMagenta on Black\033[0m"
echo -e "\033[36;40mCyan on Black\033[0m"

echo ""
echo "Dim/bright text variations:"
echo -e "\033[2mDim text\033[0m"
echo -e "\033[0mNormal text\033[0m"
echo -e "\033[1mBold text\033[0m"
echo -e "\033[1;37mBright white text\033[0m"

echo ""
echo "=== Special Effects ==="
echo ""
echo -e "\033[1mBold\033[0m \033[2mDim\033[0m \033[3mItalic\033[0m \033[4mUnderline\033[0m \033[5mBlink\033[0m \033[7mReverse\033[0m \033[9mStrikethrough\033[0m"