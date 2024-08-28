#! /bin/zsh

mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}
fileName=${1%.*}

[ -z "$1" ] && exit

dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
# if [[ $dim = x ]]; then
#   dim=$(stty size < /dev/tty | awk '{print $2 "x" $1}')
# elif ! [[ $KITTY_WINDOW_ID ]] && (( FZF_PREVIEW_TOP + FZF_PREVIEW_LINES == $(stty size < /dev/tty | awk '{print $1}') )); then
#   dim=${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))
# fi

# cells_width=$(echo $dim | cut -d x -f 1)
# cells_height=$(echo $dim | cut -d x -f 2)

if [[ -d "$1" ]]; then
   lsd --color=always -l --total-size --blocks=name,size "$1"
elif [[ "$category" = image ]]; then
    kitty icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place=${dim}@0x0 --align=center "$1" | sed '$d'
    # viu -h 30 -w 30 "$1"
    # exiftool "$1"
elif [[ "$category" = text ]]; then
    bat --color=always "$1" | head -n 50
elif [[ "$category" = application && "$kind" = pdf ]]; then
    # if [[ ! -f "/tmp/$fileName.png" ]]; then
    #     pdftoppm -f 1 -l 1 -q "$1" >> "/tmp/$filename.png"
    # fi
    # kitty icat --clear --transfer-mode=memory --unicode-placeholde --stdin=no --place=${dim}@0x0 --align=center "/tmp/$filename.png" | sed '$d'
    file "$1"
else
    file "$1"
fi
