# Automated Scripts Repository with COPILOT

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


# Doc

# Git Helper Script

`git_helper.sh` is a CLI tool designed to simplify Git operations like adding files, committing changes, and pushing to a remote branch. It provides a clean interface with several options to streamline your Git workflow.

## Features

- **Add all or specific files** for staging.
- **Custom or default commit message**.
- **Push to the current or specified branch**.
- **Easy-to-use command-line options**.

## Requirements

- Ensure that Git is installed on your system.
- Make the script executable:

  ```bash
  chmod +x git_helper.sh
  ```

## Installation

1. Clone the script to your desired directory.
2. Ensure it has executable permissions:

   ```bash
   chmod +x git_helper.sh
   ```

3. Optionally, move the script to a directory in your `$PATH` to make it available globally:

   ```bash
   mv git_helper.sh /usr/local/bin/git_helper
   ```

## Usage

Run the script with one or more of the following options:

```bash
./git_helper.sh [-a] [-f <files>] [-m <message>] [-b <branch>] [-h]
```

### Options

| Option        | Description                                                                                     |
|---------------|-------------------------------------------------------------------------------------------------|
| `-a`          | Adds **all files** to staging (`git add .`).                                                     |
| `-f <files>`  | Adds **specific files** (e.g., `-f file1 -f file2`). You can specify multiple files with `-f`.    |
| `-m <message>`| Adds a **custom commit message**. If not specified, a default message will be used.              |
| `-b <branch>` | Specifies the **branch** to push to. If not specified, the current branch will be used.          |
| `-h`          | Displays the help message with usage information.                                                |

### Example Commands

#### 1. Add all files and push with a custom commit message

```bash
./git_helper.sh -a -m "Added new feature"
```

#### 2. Add specific files and push with a custom commit message

```bash
./git_helper.sh -f file1.txt -f file2.txt -m "Updated specific files"
```

#### 3. Add all files and push with the default commit message

```bash
./git_helper.sh -a
```

This will use the default commit message:

```
Auto-commit: Updates made on <current date and time>
```

#### 4. Push to a specific branch

```bash
./git_helper.sh -a -m "Bug fixes" -b feature-branch
```

## Error Handling

- If no files are specified, and the `-a` option is not used, the script will display an error and show the help message.
- If no commit message is provided, the script will automatically use a default message.

## Contribution

Feel free to fork this repository and contribute by submitting pull requests. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

This `README.md` covers installation, usage, examples, and a brief feature list. You can modify it as per any changes you make to the script!

Set Up a Cron Job to Automate the Process at Midnight

Open the cron editor by running the following command in your terminal:

bash

crontab -e

Add the following line to the file, which will run the organize_downloads.sh script every day at midnight (00:00):

bash

0 0 ** * /path/to/organize_downloads.sh

Replace /path/to/organize_downloads.sh with the full path to your script.

Save and exit the editor. The cron job is now set up to run the script every day at midnight.
# Doc

# Git Helper Script

`git_helper.sh` is a CLI tool designed to simplify Git operations like adding files, committing changes, and pushing to a remote branch. It provides a clean interface with several options to streamline your Git workflow.

## Features

- **Add all or specific files** for staging.
- **Custom or default commit message**.
- **Push to the current or specified branch**.
- **Easy-to-use command-line options**.

## Requirements

- Ensure that Git is installed on your system.
- Make the script executable:

  ```bash
  chmod +x git_helper.sh
  ```

## Installation

1. Clone the script to your desired directory.
2. Ensure it has executable permissions:

   ```bash
   chmod +x git_helper.sh
   ```

3. Optionally, move the script to a directory in your `$PATH` to make it available globally:

   ```bash
   mv git_helper.sh /usr/local/bin/git_helper
   ```

## Usage

Run the script with one or more of the following options:

```bash
./git_helper.sh [-a] [-f <files>] [-m <message>] [-b <branch>] [-h]
```

### Options

| Option        | Description                                                                                     |
|---------------|-------------------------------------------------------------------------------------------------|
| `-a`          | Adds **all files** to staging (`git add .`).                                                     |
| `-f <files>`  | Adds **specific files** (e.g., `-f file1 -f file2`). You can specify multiple files with `-f`.    |
| `-m <message>`| Adds a **custom commit message**. If not specified, a default message will be used.              |
| `-b <branch>` | Specifies the **branch** to push to. If not specified, the current branch will be used.          |
| `-h`          | Displays the help message with usage information.                                                |

### Example Commands

#### 1. Add all files and push with a custom commit message

```bash
./git_helper.sh -a -m "Added new feature"
```

#### 2. Add specific files and push with a custom commit message

```bash
./git_helper.sh -f file1.txt -f file2.txt -m "Updated specific files"
```

#### 3. Add all files and push with the default commit message

```bash
./git_helper.sh -a
```

This will use the default commit message:

```
Auto-commit: Updates made on <current date and time>
```

#### 4. Push to a specific branch

```bash
./git_helper.sh -a -m "Bug fixes" -b feature-branch
```

## Error Handling

- If no files are specified, and the `-a` option is not used, the script will display an error and show the help message.
- If no commit message is provided, the script will automatically use a default message.

## Contribution

Feel free to fork this repository and contribute by submitting pull requests. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

This `README.md` covers installation, usage, examples, and a brief feature list. You can modify it as per any changes you make to the script!

Set Up a Cron Job to Automate the Process at Midnight

Open the cron editor by running the following command in your terminal:

bash

crontab -e

Add the following line to the file, which will run the organize_downloads.sh script every day at midnight (00:00):

bash

0 0 ** * /path/to/organize_downloads.sh

Replace /path/to/organize_downloads.sh with the full path to your script.

Save and exit the editor. The cron job is now set up to run the script every day at midnight.
