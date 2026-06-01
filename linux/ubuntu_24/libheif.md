# odpowiada za zdjęcia w formacie *.HEIC
# domyślna biblioteka nie obsługuje plików wygenerowanych przez najnowsze IPhone

```
sudo add-apt-repository ppa:strukturag/libheif
sudo apt install libheif1 heif-gdk-pixbuf heif-thumbnailer
```


# konwersja HEIC -> JPG

```
for file in *.HEIC *.heic; do
    [ -e "$file" ] || continue
    echo "$file"
    heif-convert "$file" "${file%.*}.jpg"
done
```