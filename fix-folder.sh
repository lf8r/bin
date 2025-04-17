function fixFolder {
  file=$1
  mod_date=$(stat -f "%Sm" "$file")
  xattr -drs com.apple.metadata:kMDItemResumableCopy $file
  SetFile -d "$mod_date" "$file"
}
