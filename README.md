# Automated Scripts Repository with COPILOT

This repository serves as a personal storage space for automation scripts developed with the assistance of GPT (Generative Pre-trained Transformer). These scripts are designed to facilitate everyday tasks in software development and automate other processes.

---

## Table of Contents

1. [Installing Bash Scripts to `/usr/local/bin`](#installing-bash-scripts-to-usrlocalbin)
2. [Git Helper Script](#git-helper-script)
3. [Cron Job Setup](#cron-job-setup)

---

## Installing Bash Scripts to `/usr/local/bin`

To make your Bash script globally accessible, follow these steps:

1. **Grant Execution Permissions to the Script:**

    ```bash
    sudo chmod +x ~/script.sh
    ```

2. **Create a Symbolic Link:**

    ```bash
    cd /usr/local/bin
    ln -s ~/script.sh myscript
    ```

3. **Run the Script from Anywhere:**

    ```bash
    myscript
    ```

**Note:** Moving files to system directories like `/usr/local/bin` may require administrative privileges (`sudo`). Ensure that your script has the necessary permissions and adheres to security best practices.

---

## Git Helper Script

`git_helper.sh` is a CLI tool designed to simplify Git operations such as adding files, committing changes, and pushing to a remote branch. It provides a clean interface with several options to streamline your Git workflow.

### Features

- **Add all or specific files** for staging.
- **Custom or default commit message**.
- **Push to the current or specified branch**.
- **Easy-to-use command-line options**.

### Requirements

- Git must be installed on your system.
- Make the script executable:

  ```bash
  chmod +x git_helper.sh
  ```

### Installation

1. **Clone the script to your desired directory.**
2. **Ensure it has executable permissions:**

   ```bash
   chmod +x git_helper.sh
   ```

3. **Optionally, move the script to a directory in your `$PATH` to make it available globally:**

   ```bash
   mv git_helper.sh /usr/local/bin/git_helper
   ```

### Usage

Run the script with one or more of the following options:

```bash
./git_helper.sh [-a] [-f <files>] [-m <message>] [-b <branch>] [-h]
```

#### Options

| Option        | Description                                                                                     |
|---------------|-------------------------------------------------------------------------------------------------|
| `-a`          | Adds **all files** to staging (`git add .`).                                                     |
| `-f <files>`  | Adds **specific files** (e.g., `-f file1 -f file2`). You can specify multiple files with `-f`.    |
| `-m <message>`| Adds a **custom commit message**. If not specified, a default message will be used.              |
| `-b <branch>` | Specifies the **branch** to push to. If not specified, the current branch will be used.          |
| `-h`          | Displays the help message with usage information.                                                |

#### Examples

1. **Add all files and push with a custom commit message**

    ```bash
    ./git_helper.sh -a -m "Added new feature"
    ```

2. **Add specific files and push with a custom commit message**

    ```bash
    ./git_helper.sh -f file1.txt -f file2.txt -m "Updated specific files"
    ```

3. **Add all files and push with the default commit message**

    ```bash
    ./git_helper.sh -a
    ```

    This will use the default commit message:

    ```
    Auto-commit: Updates made on <current date and time>
    ```

4. **Push to a specific branch**

    ```bash
    ./git_helper.sh -a -m "Bug fixes" -b feature-branch
    ```

### Error Handling

- If no files are specified and the `-a` option is not used, the script will display an error and show the help message.
- If no commit message is provided, the script will automatically use a default message.

### Contribution

Feel free to fork this repository and contribute by submitting pull requests. For major changes, please open an issue first to discuss what you would like to change.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## Cron Job Setup

To automate a script execution at a specific time, set up a cron job. For example, to run a script every day at midnight, follow these steps:

1. **Open the cron editor:**

    ```bash
    crontab -e
    ```

2. **Add the following line to schedule the script:**

    ```bash
    0 0 * * * /path/to/organize_downloads.sh
    ```

   Replace `/path/to/organize_downloads.sh` with the full path to your script.

3. **Save and exit the editor.**

The cron job is now set up to run the script every day at midnight.

---