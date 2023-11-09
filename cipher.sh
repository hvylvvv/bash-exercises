#!/bin/bash

while getopts "s:i:o:" opt; do
  case "$opt" in
    s)
      shift_value="$OPTARG"
      ;;
    i)
      input_file="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
      exit 1
      ;;
  esac
done

# Check if required arguments are provided
if [ -z "$shift_value" ] || [ -z "$input_file" ] || [ -z "$output_file" ]; then
  echo "Missing required arguments."
  echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
  exit 1
fi

# Function to perform the Caesar cipher
caesar_cipher() {
  local text="$1"
  local shift="$2"
  local result=""

  for ((i=0; i<${#text}; i++)); do
    char="${text:$i:1}"
    if [[ "$char" =~ [a-zA-Z] ]]; then
      ascii_val=$(printf '%d' "'$char")
      if [[ "$char" == [a-z] ]]; then
        char_code=$((97 + (ascii_val - 97 + shift) % 26))
      else
        char_code=$((65 + (ascii_val - 65 + shift) % 26))
      fi
      char_code=$(printf '%03o' "$char_code")
      char=$(printf "%s\\$char_code")

    fi
    result="${result}${char}"
  done

  echo "$result"
}

# Read input from the input file and apply the Caesar cipher
if [ -r "$input_file" ]; then
  input_text=$(<"$input_file")
  encrypted_text=$(caesar_cipher "$input_text" "$shift_value")

  # Write the result to the output file
  echo "$encrypted_text" > "$output_file"
  echo "Caesar cipher applied and saved to $output_file."
else
  echo "Error: Input file '$input_file' not found or not readable."
  exit 1
fi
