# Automated Scripts Repository with GPT

This repository serves as a storage space for automation scripts developed using GPT (Generative Pre-trained Transformer). These scripts are designed to facilitate everyday tasks in software development and automate other processes.

## Installing Bash Scripts to `/usr/local/bin`

To make your Bash script globally accessible, you can move it to the `/usr/local/bin` directory. Follow these steps:

1. **Move Scripts to `/usr/local/bin`:**
   Move or copy your Bash script(s) to the `/usr/local/bin` directory. You may need administrative privileges for this operation.

    ```bash
    sudo cp path/to/your/script.sh /usr/local/bin/
    ```

2. **Grant Execution Permissions to the Script:**
   Ensure the script has execution permissions to be run.

    ```bash
    sudo chmod +x /usr/local/bin/script.sh
    ```

3. **Run the Script from Anywhere:**
   Now, you can run your Bash script from anywhere in the system without specifying the full path.

    ```bash
    script.sh
    ```
4. Optional
   ```bash
   cd /usr/local/bin
   ```
   
   ```bash
   ln -s script.sh myscript
   ```
   
   ```bash
   myscript
   ```


With these steps, you've made your Bash script globally accessible by moving it to the `/usr/local/bin` directory, and you can run it from any location without specifying the full path.

---

Keep in mind that moving files to system directories like `/usr/local/bin` may require administrative privileges (`sudo`). Always exercise caution and ensure that your script has the necessary permissions and adheres to security best practices.
