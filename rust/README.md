# Rust Disk Stress Test

This is a Rust script for basic disk stress testing. It writes a file with random data to the disk and then copies it, stressing both write and read operations.

## Usage

Modify the following constants in `src/main.rs` as needed:

- `FILE_SIZE`: This defines the size of the file to be created. By default, it is set to 1GB.
- `BUFFER_SIZE`: This defines the size of the buffer used to write data to the file. By default, it is set to 1MB.

The paths of the original file and its copy are set to the current user's home directory by default. You can modify these paths by changing the `file_path` and `copy_path` variables.
