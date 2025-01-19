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
    
    # Önce Hyprland kuralını ayarla
    hyprctl keyword windowrulev2 "float,class:^(floating_term)$" >/dev/null
    hyprctl keyword windowrulev2 "size $w $h,class:^(floating_term)$" >/dev/null
    hyprctl keyword windowrulev2 "move $x $y,class:^(floating_term)$" >/dev/null
    
    # Alacritty'yi başlat
    alacritty --class="floating_term" &
    
    # Kuralları temizle (bir sonraki pencere için hazırlan)
    sleep 1
    hyprctl keyword windowrulev2 "unset,class:^(floating_term)$" >/dev/null
fi

echo "Script ended at $(date)"
