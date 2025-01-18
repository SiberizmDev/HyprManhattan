#!/bin/bash
exec 1> >(tee -a "/tmp/alacritty_debug.log")
exec 2>&1
echo "Script started at $(date)"

# Seçilen alanın koordinatlarını al
selection=$(slurp)
echo "Selection: $selection"

if [ -n "$selection" ]; then
    # Koordinatları parse et
    x=$(echo $selection | cut -d',' -f1)
    y=$(echo $selection | cut -d',' -f2 | cut -d' ' -f1)
    w=$(echo $selection | cut -d' ' -f2 | cut -d'x' -f1)
    h=$(echo $selection | cut -d'x' -f2)
    echo "Parsed values - x: $x, y: $y, w: $w, h: $h"
    
    # Alacritty'yi başlat
    alacritty --class="floating_term" &
    
    # Pencerenin başlamasını bekle
    sleep 0.3
    
    # Önce konumlandır
    hyprctl dispatch movewindowpixel "exact $x $y,class:^(floating_term)$"
    
    # Sonra boyutlandır
    hyprctl dispatch resizewindowpixel "exact $w $h,class:^(floating_term)$"
fi
echo "Script ended at $(date)"
