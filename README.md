# Automated Scripts Repository with GPT

This nguwawor repository serves as a personal storage space for automation scripts developed assisted by GPT (Generative Pre-trained Transformer).These scripts are designed to facilitate everyday tasks in software development and automate other processes.

## Installing Bash Scripts to `/usr/local/bin`

To make your Bash script globally accessible, you can make a spft soft link in the `/usr/local/bin` directory. Follow these steps:

1. **Grant Execution Permissions to the Script:**
   Ensure the script has execution permissions to be run.

    ```bash
    sudo chmod +x ~/script.sh
    ```

2. **Make a soft link (Symbolic Link):**
   Creates a separate file that acts like a pointer to the original file's location.
   You can use it as a shortcut.

   ```bash
   cd /usr/local/bin
   ```
   
   ```bash
   ln -s ~/script.sh myscript
   ```

3. **Run the Script from Anywhere:**
   ```bash
   myscript
   ```


With these steps, you've made your Bash script globally accessible by making a symbolic link to the 
`/usr/local/bin` directory, and you can run it from any location without specifying the full path.

---

Keep in mind that moving files to system directories like `/usr/local/bin` may require administrative privileges (`sudo`). Always exercise caution and ensure that your script has the necessary permissions and adheres to security best practices.
