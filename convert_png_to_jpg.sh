#!/usr/bin/env bash

convert_png_to_jpg() {
    local walls_dir="walls"
    
    # Check if the walls directory exists
    if [ ! -d "$walls_dir" ]; then
        echo "Error: $walls_dir directory does not exist."
        return 1
    fi
    
    # Check if ImageMagick is installed
    if ! command -v convert &> /dev/null; then
        echo "Error: ImageMagick is not installed. Please install it first."
        return 1
    fi
    
    # Find all PNG files
    echo "Finding PNG files in $walls_dir..."
    mapfile -t png_files < <(find "$walls_dir" -type f -name "*.png")
    
    # Check if any PNG files were found
    if [ ${#png_files[@]} -eq 0 ]; then
        echo "No PNG files found in $walls_dir."
        return 0
    fi
    
    # Convert PNG files to JPG
    echo "Converting ${#png_files[@]} PNG files to JPG..."
    count=0
    
    for png_file in "${png_files[@]}"; do
        # Generate JPG filename
        jpg_file="${png_file%.png}.jpg"
        
        # Convert PNG to JPG with quality 95
        if convert "$png_file" -quality 95 "$jpg_file"; then
            echo "Converted: $png_file → $jpg_file"
            count=$((count + 1))
        else
            echo "Failed to convert: $png_file"
        fi
    done
    
    echo "Done! Successfully converted $count out of ${#png_files[@]} PNG files to JPG format."
}

# Run the function
convert_png_to_jpg