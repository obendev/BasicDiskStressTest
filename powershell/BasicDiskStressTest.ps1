# Define the size of the file in bytes
$fileSize = 1GB
# Define the path of the file
$filePath = "$HOME\dummyfile"
$copyPath = "$HOME\dummyfile_copy"

# Define the buffer size in bytes (B)
$bufferSize = 1024

# Create a FileStream to write the data
try {
    $fileStream = New-Object System.IO.FileStream($filePath, [System.IO.FileMode]::Create)
}
catch {
    Write-Output "Error: Could not create FileStream. Please check the file path and permissions."
    return
}

# Create a buffer to hold the random data
$buffer = New-Object byte[] $bufferSize

# Create a Random object
$random = New-Object Random  # Reuse this Random object

# Try to use RandomNumberGenerator, RNGCryptoServiceProvider, or Random
try {
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    Write-Output "Using RandomNumberGenerator"
}
catch {
    try {
        $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
        Write-Output "Using RNGCryptoServiceProvider"
    }
    catch {
        $rng = $random
        Write-Output "Using Random"
    }
}

# Calculate the number of iterations required to reach the desired file size
$iterations = $fileSize / $buffer.Length

# Write random data to the file
for ($i = 0; $i -lt $iterations; $i++) {
    # Fill the buffer with random data
    $rng.GetBytes($buffer)

    # Write the buffer to the file
    $fileStream.Write($buffer, 0, $buffer.Length)
}

# Close the FileStream
$fileStream.Close()

# Copy the file
Copy-Item -Path $filePath -Destination $copyPath

# Verify the operations
if ((Test-Path -Path $filePath) -and (Test-Path -Path $copyPath)) {
    # Calculate the hash of the original and copied files
    $originalHash = Get-FileHash -Path $filePath -Algorithm SHA256
    $copyHash = Get-FileHash -Path $copyPath -Algorithm SHA256

    if ($originalHash.Hash -eq $copyHash.Hash) {
        Write-Output "Success: The file was copied correctly."
    }
    else {
        Write-Output "Error: The copied file does not match the original file."
    }
}
else {
    Write-Output "Error: The file or its copy does not exist."
}
