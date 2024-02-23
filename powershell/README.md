# PowerShell Disk Stress Test

This is a PowerShell script for basic disk stress testing. It writes a file with random data to the disk and then copies it, stressing both write and read operations.

## Usage

Modify the following variables in `BasicDiskStressTest.ps1` as needed:

- `$fileSize`: This defines the size of the file to be created. By default, it is set to 1GB.
- `$bufferSize`: This defines the size of the buffer used to write data to the file. By default, it is set to 1KB.

The paths of the original file and its copy are set to the current user's home directory by default. You can modify these paths by changing the `$filePath` and `$copyPath` variables.
