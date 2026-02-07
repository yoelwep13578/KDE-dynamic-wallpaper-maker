# KDE-dynamic-wallpaper-maker

An `.sh` terminal-based script to create light/dark wallpaper list in KDE Plasma.

![KDE Dynamic Wallpaper Maker](https://github.com/user-attachments/assets/dd470717-f058-4eb6-9eb8-ed7e7c938eda)

> It seems that someone has already created a better tool than this one. I'm keeping it in this repository so it won't get lost, while also publishing this script so it can help others who need it.

## Example Usage

> This video was recorded with 1366x768 monitor at 75% scale. I'm really sorry for this horrible video quality.

https://github.com/user-attachments/assets/b6c71238-7470-49c5-ada0-bed1c06294eb


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

3. Press `[Enter]` and follow the instructions

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
