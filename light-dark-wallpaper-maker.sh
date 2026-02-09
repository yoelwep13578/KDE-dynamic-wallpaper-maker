#!/bin/bash

# Remove all " from typed path
clean_path() {
    echo "$1" | sed "s/^[“'\"«]//;s/[”'\"»]$//"
}

# Centered text
#center() {
#    local cols="$(tput cols)"
#    printf "%*s\\n" $(( (${#1} + cols) / 2 )) "$1"
#}

center() {
    local cols="$(tput cols)"
    printf "%$(((cols - ${#1}) / 2 ))s%s\n" "" "$1"
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

center " ╱                                                     ╲ "
center "╳   Light/Dark Dynamic Wallpaper Maker for KDE Plasma   ╳"
center " ╲                                                     ╱ "
echo ""
center "Make custom dynamic night/light wallpaper with your own images"
echo ""

# 1. Input LIGHT Image Path
while :; do
    echo -e "\e[7m STEP 1 \e[27m Enter your own image path for 𖤓 Light Mode \n\n\e[34m\e[7m \e[3mi\e[23m HINT \e[0m\e[27m You can drag-n-drop the image file to this terminal and its path will writen automatically."

    echo -e "\e[2m"
    center "┌─ ── ── ── ── ── ── ── ── ── ── ── ── ── ─┐"
    center "│                                          │"
    center "│   Drop your image here (this terminal)   │"
    center "│        or type image path manually       │"
    center "│                                          │"
    center "└─ ── ── ── ── ── ── ── ── ── ── ── ── ── ─┘"
    echo -e "\e[22m"

    read -ep $'\e[1mLight Mode Image Path\e[22m \e[5m-->\e[25m ' raw_light_path
    light_path=$(clean_path "$raw_light_path")
    if [ -f "$light_path" ]; then
        light_res=$(get_resolution "$light_path")
        light_ext="${light_path##*.}"
        label=""
        ! has_imagemagick && label=" [Fallback because ImageMagick not installed]"
        echo -e "\e[32mFile detected:\e[0m $(basename "$light_path") [$light_res$label]"
        break
    else
        echo -e "\e[31mFile not found.\e[0m Make sure the path is correct. \nIf the file is in your home directory, write it completely as /home/yourname/... rather than ~/...\n"
    fi
done

echo -e "\n\n"

# 2. Input DARK Image Path
while :; do
    echo -e "\e[7m STEP 2 \e[27m Enter your own image path for ☾ Dark Mode \n\n\e[34m\e[7m \e[3mi\e[23m HINT \e[0m\e[27m You can drag-n-drop the image file to this terminal and its path will writen automatically. \n"

    echo -e "\e[2m"
    center "┌─ ── ── ── ── ── ── ── ── ── ── ── ── ── ─┐"
    center "│                                          │"
    center "│   Drop your image here (this terminal)   │"
    center "│        or type image path manually       │"
    center "│                                          │"
    center "└─ ── ── ── ── ── ── ── ── ── ── ── ── ── ─┘"
    echo -e "\e[22m"

    read -ep $'\e[1mDark Mode Image Path\e[22m \e[5m-->\e[25m ' raw_dark_path
    dark_path=$(clean_path "$raw_dark_path")
    if [ -f "$dark_path" ]; then
        dark_res=$(get_resolution "$dark_path")
        dark_ext="${dark_path##*.}"
        label=""
        ! has_imagemagick && label=" [[Fallback because ImageMagick not installed]"
        echo -e "\e[32mFile detected:\e[0m $(basename "$dark_path") [$dark_res$label]"
        break
    else
        echo -e "\e[31mFile not found.\e[0m Make sure the path is correct. \nIf the file is in your home directory, write it completely as /home/yourname/... rather than ~/...\n"
    fi
done

echo -e "\n---\n"

# 3. Folder and name settings
while :; do
    echo -e "\e[7m STEP 3 \e[27m Enter the folder name you want \nA new folder will be created to store 𖤓 Light Mode and ☾ Dark Mode image.\n"

    center "┌─────────────────────────────────────────┐"
    center "│  ... / 🗁  Your-Wallpaper-Folder-Name    │"
    center "└─────────────────────────────────────────┘"

    echo -e "\nThis name should not contain spaces."
    read -ep $'\e[1mWallpaper Folder Name:\e[22m ' folder_name
    if [ -n "$folder_name" ]; then break; fi
    echo -e "\e[31mFolder name cannot be empty.\e[0m \n"
done

echo -e "\n\n"

while :; do
    echo -e "\e[7m STEP 4 \e[27m Enter the name (scheme) of the wallpaper you want \nThis name will be displayed in the wallpaper settings list.\n"

    echo "    ┌─────────────────────────┐    "
    echo "    │                      ☯︎  │    "
    echo "    │                         │    "
    echo "    │                         │    "
    echo "    │                         │    "
    echo "    │                         │    "
    echo "    └─────────────────────────┘    "
    echo -e "        Your Wallpaper Name        \n"

    read -ep $'\e[1mWallpaper (Scheme) Name:\e[22m ' wp_display_name
    if [ -n "$wp_display_name" ]; then break; fi
    echo -e "\e[31mWallpaper name cannot be empty.\e[0m \n"
    echo ""
done

echo -e "\n\n"

author_name=""
while :; do
    echo -e "\e[7m STEP 5 \e[27m Enter the author’s name (optional) \nThe author’s name will be displayed in the wallpaper settings, exactly below the wallpaper name.\n"

    echo "            WITH AUTHOR                       WITHOUT AUTHOR          "
    echo "    ┌─────────────────────────┐        ┌─────────────────────────┐    "
    echo "    │                      ☯︎  │        │                      ☯︎  │    "
    echo "    │                         │        │                         │    "
    echo "    │                         │        │                         │    "
    echo "    │                         │        │                         │    "
    echo "    │                         │        │                         │    "
    echo "    └─────────────────────────┘        └─────────────────────────┘    "
    echo "        Your Wallpaper Name                Your Wallpaper Name        "
    echo -e "           \e[2mAuthor’s Name\e[22m                                              \n"
    echo -e "\e[33m[1]\e[0m Leave it empty (No Author)"
    echo -e "\e[33m[2]\e[0m Use my username ($(whoami))"
    echo -e "\e[33m[3]\e[0m Use my full username ($(getent passwd $USER | cut -d: -f5 | cut -d, -f1))"
    echo -e "\e[33m[4]\e[0m Custom (Best choice for crediting the original author of the image you own)\n"

    read -ep $'\e[1mEnter your choice (Default 1)\e[22m \e[5m-->\e[25m ' auth_choice

    case $auth_choice in
        ""|1) author_name=""; break ;;
        2) author_name=$(whoami); break ;;
        3) author_name=$(getent passwd $USER | cut -d: -f5 | cut -d, -f1); break ;;
        4)
            read -ep $'\e[7m CUSTOM MODE \e[27m Enter author’s name: ' custom_author
            author_name="$custom_author"; break ;;
        *) echo -e "\e[33mPlease select correctly (1, 2, 3, or 4).\e[0m \n" ;;
    esac
done

echo -e "\n\n"

# 4. Image resolution
label_res=""
! has_imagemagick && label_res=" [fallback]"
echo -e "\e[7m STEP 6 \e[27m Enter the image resolution for the file name \nor just press \e[7m\e[33m[Enter]\e[0m\e[27m to use \e[33m$light_res$label_res\e[0m \n\nYou can write the resolution like: \n    1920x1080 \n    1920:1080 \n    1920/1080 \n    1920 1080\n"
read -ep $'\e[1mImage resolution for file name:\e[22m ' final_res

if [ -z "$final_res" ]; then
    final_res=$light_res
fi

# Normalize resolution for input and displayed in confirmation dialog
clean_res=$(echo "$final_res" | sed 's/[:/×* ]/x/g')
display_res=$(echo "$clean_res" | sed 's/x/×/g')

echo -e "\n---\n"

# 5. Path to save (local/user-only, system-wide, or custom)
while :; do
    echo -e "\e[7m STEP 7 \e[27m Select save location:"
    echo -e "\e[33m[1]\e[0m User-only (~/.local/share/wallpapers/)"
    echo -e "\e[33m[2]\e[0m System-wide (/usr/share/wallpapers/) - sudo will prompted after confirm"
    echo -e "\e[33m[3]\e[0m Custom (Just for testing or sharing purpose)"
    echo -e "\n\e[33m\e[7m \e[3mi\e[23m NOTE \e[0m\e[27m Saving in User-only is great for easy deletion if you get bored.\nSaving in System-wide is recommended for keeping and leaving it as is, like the default KDE wallpaper placed.\n"
    read -ep $'\e[1mSelect (1, 2, or 3)\e[22m \e[5m-->\e[25m ' loc_choice

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
        read -ep $'\e[7m CUSTOM MODE \e[27m Insert custom path: ' custom_path
        target_base=$(clean_path "$custom_path")
        if [ -d "$target_base" ]; then break; else echo -e "\e[31mFolder/directory not found.\e[0m \n\e[7m\e[31m CAUSE 1 \e[0m\e[27m Home-related directory. If the targeted folder in your home directory, write it completely as /home/yourname/... rather than ~/... \n\e[7m\e[31m CAUSE 2 \e[0m\e[27m Actually not exist. You should mkdir it first.\n"; fi
        ;;
    *) echo -e "\e[33mPlease select correctly (1, 2, or 3).\e[0m\n" ;;
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
    echo -e "Proceed & execute? \n    \e[33m[y]\e[0m Yes. Continue. \n    \e[33m[n]\e[0m No. Exit anyway. \n    \e[33m[c]\e[0m Cancel & start from begining."
    read -ep $'\e[1mYour choice (y, n, or c)\e[22m \e[5m-->\e[25m ' confirm

    case $confirm in
    [yY]*) break ;;
    [nN]*)
        echo "Program terminated."
        exit 0
        ;;
    [cC]*) exec "$0" ;;
    *)
        echo -e "\e[33mPlease select y, n, or c.\e[0m\n"
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

echo -e "\n\e[7m\e[32m COMPLETED \e[0m\e[27m \e[32mDone!\e[0m The “${wp_display_name}” wallpaper scheme now available. \nYou may need to wait a while, re-login, or reboot for it to appear in Desktop & Wallpaper Settings [Ctrl][Shift][D]."
