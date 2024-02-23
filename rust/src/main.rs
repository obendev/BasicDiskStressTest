use rand::RngCore;
use sha2::{Digest, Sha256};
use std::fs::File;
use std::io::{BufReader, BufWriter, Read, Write};

const KB: usize = 1024;
const MB: usize = KB * 1024;
const GB: usize = MB * 1024;

// Define the size of the file
const FILE_SIZE: usize = 1 * GB; // 1 GB

// Define the buffer size
const BUFFER_SIZE: usize = 1 * MB; // 1 MB

fn main() -> std::io::Result<()> {
    // Define the path of the file
    let home_dir = dirs::home_dir().unwrap();
    let file_path = home_dir.join("dummyfile");
    let copy_path = home_dir.join("dummyfile_copy");

    // Create a buffer to hold the random data
    let mut buffer = vec![0u8; BUFFER_SIZE];

    // Write random data to the file and calculate the hash
    let mut original_hash = Sha256::new();
    {
        let mut f = BufWriter::new(File::create(&file_path)?);
        for _ in 0..(FILE_SIZE / BUFFER_SIZE) {
            // Fill the buffer with random data
            rand::thread_rng().fill_bytes(&mut buffer);
            // Write the buffer to the file
            f.write_all(&buffer)?;
            // Update the hash
            original_hash.update(&buffer);
        }
    }

    // Copy the file and calculate the hash
    let mut copy_hash = Sha256::new();
    {
        let mut src = BufReader::new(File::open(&file_path)?);
        let mut dst = BufWriter::new(File::create(&copy_path)?);
        while let Ok(n) = src.read(&mut buffer) {
            if n == 0 {
                break;
            }
            dst.write_all(&buffer[..n])?;
            copy_hash.update(&buffer[..n]);
        }
    }

    // Verify the operation
    if original_hash.finalize() == copy_hash.finalize() {
        println!("Success: The file was copied correctly.");
    } else {
        println!("Error: The copied file does not match the original file.");
    }

    Ok(())
}
