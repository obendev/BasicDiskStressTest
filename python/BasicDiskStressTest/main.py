from pathlib import Path
import secrets
import hashlib

# Define the size of the file
file_size = 1 * (1024**3)  # 1 GB

# Define the path of the file
home_dir = Path.home()
file_path = home_dir / "dummyfile"
copy_path = home_dir / "dummyfile_copy"

# Define the buffer size
buffer_size = 1 * (1024**2)  # 1 MB

# Create a buffer to hold the random data
buffer = bytearray(buffer_size)

# Write random data to the file and calculate the hash
original_hash = hashlib.sha256()

with open(file_path, "wb") as f:
    for _ in range(file_size // buffer_size):
        # Fill the buffer with random data
        buffer = secrets.token_bytes(buffer_size)
        # Write the buffer to the file
        f.write(buffer)
        # Update the hash
        original_hash.update(buffer)

# Copy the file and calculate the hash
copy_hash = hashlib.sha256()

with open(file_path, "rb") as src, open(copy_path, "wb") as dst:
    while chunk := src.read(buffer_size):
        dst.write(chunk)
        copy_hash.update(chunk)

# Verify the operation
if original_hash.hexdigest() == copy_hash.hexdigest():
    print("Success: The file was copied correctly.")
else:
    print("Error: The copied file does not match the original file.")
