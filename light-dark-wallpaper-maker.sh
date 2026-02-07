#!/bin/bash

# Remove all " from typed path
clean_path() {
    echo "$1" | sed "s/^[“'\"«]//;s/[”'\"»]$//"
}

# Read image resolutions & fallback of ImageMagick if not available
get_resolution() {
    if command -v identify >/dev/null 2>&1; then
        res=$(identify -format "%wx%h" "$1" 2>/dev/null)
        if [ -n "$res" ]; then
            echo "$res"
            return
        fi
    fi
    echo "1920x1080"
}

# Is ImageMagick installed? (for text label)
has_imagemagick() {
    command -v identify >/dev/null 2>&1
}

clear
echo -e "  ╱                                              ╲  \n ╳   Light/Dark Dynamic Wallpaper Maker for KDE   ╳ \n  ╲                                              ╱  \n"

# 1. Input LIGHT Image Path
while :; do
    echo -e "Enter your own image path for 𖤓 Light Mode \n\nHint: You can drag-n-drop the image file to this terminal and its path will writen automatically. \n"
    read -p "Light Mode Image Path --> " raw_light_path
    light_path=$(clean_path "$raw_light_path")
    if [ -f "$light_path" ]; then
        light_res=$(get_resolution "$light_path")
        light_ext="${light_path##*.}"
        label=""
        ! has_imagemagick && label=" [Fallback because ImageMagick not installed]"
        echo -e "File detected: $(basename "$light_path") [$light_res$label]"
        break
    else
        echo -e "File not found. Make sure the path is correct. \nIf the file is in your home directory, write it completely as /home/yourname/... rather than ~/..."
    fi
done

echo -e "\n\n"

# 2. Input DARK Image Path
while :; do
    echo -e "Enter your own image path for ☾ Dark Mode \n\nHint: You can drag-n-drop the image file to this terminal and its path will writen automatically. \n"
    read -p "Dark Mode Image Path --> " raw_dark_path
    dark_path=$(clean_path "$raw_dark_path")
    if [ -f "$dark_path" ]; then
        dark_res=$(get_resolution "$dark_path")
        dark_ext="${dark_path##*.}"
        label=""
        ! has_imagemagick && label=" [[Fallback because ImageMagick not installed]"
        echo -e "File detected: $(basename "$dark_path") [$dark_res$label]"
        break
    else
        echo -e "File not found. Make sure the path is correct. \nIf the file is in your home directory, write it completely as /home/yourname/... rather than ~/..."
    fi
done

echo -e "\n---\n"

# 3. Folder and name settings
while :; do
    echo -e "Enter the folder name you want \nA new folder will be created to store 𖤓 Light Mode and ☾ Dark Mode image.\n"
    echo -e ".../🗁 Your-Wallpaper-Folder-Name \n\nThis name should not contain spaces."
    read -p "Wallpaper Folder Name: " folder_name
    if [ -n "$folder_name" ]; then break; fi
    echo "Folder name cannot be empty."
done

echo -e "\n\n"

while :; do
    echo -e "Enter the name (scheme) of the wallpaper you want \nThis name will be displayed in the wallpaper settings list.\n"
    echo "    ┌─────────────────────────┐    "
    echo "    │                      ☯︎  │    "
    echo "    │                         │    "
    echo "    │                         │    "
    echo "    │                         │    "
    echo "    └─────────────────────────┘    "
    echo -e "        Your Wallpaper Name        \n"
    read -p "Wallpaper (Scheme) Name: " wp_display_name
    if [ -n "$wp_display_name" ]; then break; fi
    echo "Wallpaper name cannot be empty."
done

echo -e "\n\n"

author_name=""
while :; do
    echo -e "Enter the author’s name (optional) \nThe author’s name will be displayed in the wallpaper settings, exactly below the wallpaper name.\n"
    echo "            WITH AUTHOR                       WITHOUT AUTHOR          "
    echo "    ┌─────────────────────────┐        ┌─────────────────────────┐    "
    echo "    │                      ☯︎  │        │                      ☯︎  │    "
    echo "    │                         │        │                         │    "
    echo "    │                         │        │                         │    "
    echo "    │                         │        │                         │    "
    echo "    └─────────────────────────┘        └─────────────────────────┘    "
    echo "        Your Wallpaper Name                Your Wallpaper Name        "
    echo -e "           \e[3mAuthor’s Name\e[0m                                              \n"
    echo "[1] Leave it empty (No Author)"
    echo "[2] Use my username ($(whoami))"
    echo "[3] Use my full username ($(getent passwd $USER | cut -d: -f5 | cut -d, -f1))"
    echo -e "[4] Custom (Best choice for crediting the original author of the image you own)\n"
    read -p "Enter your choice (Default 1) --> " auth_choice

    case $auth_choice in
        ""|1) author_name=""; break ;;
        2) author_name=$(whoami); break ;;
        3) author_name=$(getent passwd $USER | cut -d: -f5 | cut -d, -f1); break ;;
        4)
            read -p "Enter author’s name: " custom_author
            author_name="$custom_author"; break ;;
        *) echo "Please select correctly (1, 2, 3, or 4)." ;;
    esac
done

echo -e "\n\n"

# 4. Image resolution
label_res=""
! has_imagemagick && label_res=" [fallback]"
echo -e "Enter the image resolution for the file name \nor just press [Enter] to use $light_res$label_res \n\nYou can write the resolution like: \n1920x1080 \n1920:1080 \n1920/1080 \n1920 1080\n"
read -p "Image resolution for file name: " final_res

if [ -z "$final_res" ]; then
    final_res=$light_res
fi

# Normalize resolution for input and displayed in confirmation dialog
clean_res=$(echo "$final_res" | sed 's/[:/×* ]/x/g')
display_res=$(echo "$clean_res" | sed 's/x/×/g')

echo -e "\n---\n"

# 5. Path to save (local/user-only, system-wide, or custom)
while :; do
    echo "Select save location:"
    echo "[1] User-only (~/.local/share/wallpapers/)"
    echo "[2] System-wide (/usr/share/wallpapers/) - Requires sudo"
    echo "[3] Custom (Just for testing)"
    echo -e "\nNote: Some people find that their custom wallpapers do not appear in Desktop & Wallpaper Settings when saved in User-only.\nSaving in System-wide is recommended, so it appears immediately in Desktop & Wallpaper Settings after process is complete.\n"
    read -p "Select (1, 2, or 3) --> " loc_choice

    case $loc_choice in
    1)
        target_base="$HOME/.local/share/wallpapers"
        break
        ;;
    2)
        target_base="/usr/share/wallpapers"
        break
        ;;
    3)
        read -p "Insert custom path: " custom_path
        target_base=$(clean_path "$custom_path")
        if [ -d "$target_base" ]; then break; else echo "Folder/directory not found. You should mkdir it first."; fi
        ;;
    *) echo "Please select correctly (1, 2, or 3)." ;;
    esac
done

full_target_path="$target_base/$folder_name"

echo -e "\n\n"

# 6. Summary & confirmation
while :; do
    clear
    echo "──────────────────────────"
    echo "    SETTINGS OVERVIEW     "
    echo "──────────────────────────"
    echo "Light Image             : $(basename "$light_path") ($light_res)"
    echo "Dark Image              : $(basename "$dark_path") ($dark_res)"
    echo "Wallpaper Folder Name   : $folder_name"
    echo "Wallpaper Display Name  : $wp_display_name"
    echo "Author’s Name           : ${author_name:-[No Author]}"
    echo "Resolution File Name    : $display_res"
    echo "Target Location         : $full_target_path"
    echo "──────────────────────────"
    echo -e "Proceed & execute? \n    [y] Yes. Continue. \n    [n] No. Exit anyway. \n    [c] Cancel & start from begining."
    read -p "Your choice (y/n/c) --> " confirm

    case $confirm in
    [yY]*) break ;;
    [nN]*)
        echo "Program terminated."
        exit 0
        ;;
    [cC]*) exec "$0" ;;
    *)
        echo "Please select y, n, or c."
        sleep 1
        ;;
    esac
done

# 7. Execute
echo "Processing..."
CMD_PREFIX=""
[ "$loc_choice" -eq 2 ] && CMD_PREFIX="sudo"

$CMD_PREFIX mkdir -p "$full_target_path/contents/images"
$CMD_PREFIX mkdir -p "$full_target_path/contents/images_dark"

$CMD_PREFIX cp "$light_path" "$full_target_path/contents/images/$clean_res.$light_ext"
$CMD_PREFIX cp "$dark_path" "$full_target_path/contents/images_dark/$clean_res.$dark_ext"

# Menyusun metadata.json berdasarkan ada tidaknya author
if [ -z "$author_name" ]; then
    metadata_content="{
    \"KPackageStructure\": \"Plasma/Wallpaper\",
    \"KPlugin\": {
        \"Id\": \"$folder_name\",
        \"Name\": \"$wp_display_name\"
    }
}"
else
    metadata_content="{
    \"KPackageStructure\": \"Plasma/Wallpaper\",
    \"KPlugin\": {
        \"Authors\": [
            {
                \"Name\": \"$author_name\"
            }
        ],
        \"Id\": \"$folder_name\",
        \"Name\": \"$wp_display_name\"
    }
}"
fi

echo "$metadata_content" | $CMD_PREFIX tee "$full_target_path/metadata.json" > /dev/null

echo -e "\nDone! The “${wp_display_name}” wallpaper scheme now available. \nYou may need to wait a while, re-login, or reboot for it to appear in Desktop & Wallpaper Settings [Ctrl][Shift][D]."
