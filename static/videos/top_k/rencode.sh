#!/bin/bash

# Directory containing videos
INPUT_DIR="."
# Temporary suffix for safe overwrite
TMP_SUFFIX="_reencoded"

for file in "$INPUT_DIR"/*; do
    [[ -f "$file" ]] || continue

    filename=$(basename -- "$file")
    name="${filename%.*}"

    output="${INPUT_DIR}/${name}${TMP_SUFFIX}.mp4"

    echo "Re-encoding: $file -> $output"

    # Re-encode video with high quality
    ffmpeg -i "$file" \
        -c:v libx264 -crf 18 -preset veryslow \
        -c:a aac -b:a 320k \
        "$output" -y

    # # Replace original with the reencoded file
    mv -f "$output" "${INPUT_DIR}/${name}.mp4"
done

echo "✅ All videos re-encoded into MP4."

