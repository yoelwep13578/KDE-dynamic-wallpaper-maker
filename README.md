# KDE-dynamic-wallpaper-maker

An `.sh` terminal-based script to create light/dark wallpaper list in KDE Plasma.

<picture>
  <!-- Light mode image -->
  <source srcset="https://github.com/user-attachments/assets/4611cc1e-eb95-47f0-b7c5-e8e2ce4825bf" media="(prefers-color-scheme: light)" />

  <!-- Dark mode image -->
  <source srcset="https://github.com/user-attachments/assets/9131a7bb-4c41-4532-9b29-5232eef69d98" media="(prefers-color-scheme: dark)" />

  <!-- Fallback (if prefers-color-scheme isn't supported) -->
  <img src="https://github.com/user-attachments/assets/4611cc1e-eb95-47f0-b7c5-e8e2ce4825bf" />
</picture>

> Maybe, someone has already created a better tool than this one. I'll keeping my script in this repository so it won't get lost, while also publishing this script so it can help others who need it.

## Example Usage

https://github.com/user-attachments/assets/56cc2b39-d7d7-436c-b67e-ba3c86914fda

> Video from [Szhatie](https://github.com/Szhatie) ↓↓↓

https://github.com/user-attachments/assets/070900aa-71f7-43b1-99fc-82741d1ffbaf


## Common Requirements

Some of these software will be used by this script. The list below is not mandatory to install.

- `ImageMagick` to read/get image resolution
- `curl` or `wget` to obtain this script. This will be used to run the script directly without cloning/saving it


## How to Use

1. Run this script (without bothering to clone repo) by copying this command and running it in terminal

   Copy & run this for using `curl`
   ```sh
   bash <(curl -sL https://raw.githubusercontent.com/yoelwep13578/KDE-dynamic-wallpaper-maker/refs/heads/main/light-dark-wallpaper-maker.sh)
   ```

   Copy & run this for using `wget`
   ```sh
   bash <(wget -qO- https://raw.githubusercontent.com/yoelwep13578/KDE-dynamic-wallpaper-maker/refs/heads/main/light-dark-wallpaper-maker.sh)
   ```

2. Press `[Enter]` and follow the instructions


## How it Started & How it Works

This idea originated from a guide shared by u/MissBrae01 in [Plasma 6.5's Day/Night Wallpapers - How to?](https://www.reddit.com/r/kde/comments/1ohsvov/comment/nlqwax8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) (Reddit). From there, I created this script to simplify the process. This script will generate a file structure like this.

```
/WALLPAPER_FOLDER_NAME
    contents
        images
            IMAGE_RESOLUTION.png
        images_dark
            IMAGE_RESOLUTION.png
    metadata.json
```

And `metadata.json` will writen like this.

**With Author**
```json
 {
    "KPlugin": {
        "Authors": [
            {
                "Name": "AUTHOR_NAME"
            }
        ],
        "Id": "WALLPAPER_FOLDER_NAME",
        "Name": "WALLPAPER_NAME"
    }
} 
```

**Without Author**
```json
 {
    "KPlugin": {
        "Id": "WALLPAPER_FOLDER_NAME",
        "Name": "WALLPAPER_NAME"
    }
} 
```

You will be asked to fill information, such as:

1. Path of the image file you want to use for Light Mode (just drag and drop it into the terminal)

2. Path of the image file you want to use for Dark Mode (just drag and drop it into the terminal)

3. Name of wallpaper folder you want <br>
   Filling `WALLPAPER_FOLDER_NAME`

4. Name of wallpaper you want to display on Desktop & Wallpaper Settings <br>
   Filling `WALLPAPER_NAME`

5. Author's name (optional) <br>
   Filling `AUTHOR_NAME`

6. Image resolution to be used as file name (just press `[Enter]` because autodetect is available based on selected image) <br>
   Filling `IMAGE_RESOLUTION`

7. Then save it to a location of your choice, between:
   - Local Share/User Only `~/.local/share/wallpapers`
   - System Wide `/usr/share/wallpapers`
   - Any location you want, whether for testing or intending to create a collection and share it publicly

## Credits

- DenysMb (Denys Madureira), GitHub
- u/MissBrae01, Reddit
