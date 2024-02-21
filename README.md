# BasicDiskStressTest

This repository contains a simple PowerShell script for basic disk stress testing. The script writes a large file with random data to the disk and then copies it, stressing both write and read operations.

## Usage

Modify the following variables as needed:
   - `$fileSize`: This defines the size of the file to be created in bytes. By default, it is set to 1GB.
   - `$filePath` and `$copyPath`: These define the paths of the original file and its copy, respectively. By default, they are set to create the files in the current user's home directory.
   - `$bufferSize`: This defines the size of the buffer used to write data to the file in bytes. By default, it is set to 1024 bytes.
