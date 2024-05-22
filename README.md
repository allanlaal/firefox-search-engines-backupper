
# firefox-search-engines-backupper
Backups ALL of your Firefox and Firefox ESR profiles search engines automatically.

## SOLVES:
Firefox LOVES to delete all custom search engines.

## Installation and Usage

### Clone the Repository

#### Linux and Mac
Open a terminal and run the following commands:
```bash
git clone https://github.com/yourusername/firefox-search-engines-backupper.git
cd firefox-search-engines-backupper
chmod +x firefox-search-engines-backupper.bash
```

#### Windows
1. Install Git for Windows from [here](https://gitforwindows.org/).
2. Open "Git Bash" from the Start menu.
3. In the Git Bash window, run the following commands:
    ```bash
    git clone https://github.com/yourusername/firefox-search-engines-backupper.git
    cd firefox-search-engines-backupper
    chmod +x firefox-search-engines-backupper.bash
    ```

### Run the Script

#### Linux and Mac
```bash
./firefox-search-engines-backupper.bash
```

#### Windows
1. Open "Git Bash" from the Start menu.
2. Navigate to the script directory and run the script:
    ```bash
    cd /path/to/firefox-search-engines-backupper
    ./firefox-search-engines-backupper.bash
    ```

### Automation

#### Linux
Add this to your cron to run nightly:
1. Open the crontab editor:
    ```bash
    crontab -e
    ```
2. Add the following line to run the script at 2 AM every day:
    ```bash
    0 2 * * * /path/to/firefox-search-engines-backupper/firefox-search-engines-backupper.bash
    ```

#### Windows
To schedule a task in Windows to run the script nightly:
1. Open Task Scheduler and create a new task.
2. In the "General" tab, name your task.
3. In the "Triggers" tab, create a new trigger to start daily at a specific time.
4. In the "Actions" tab, create a new action:
    - Action: Start a program
    - Program/script: `C:\path\to\bash.exe`
    - Add arguments: `-c "/path/to/firefox-search-engines-backupper/firefox-search-engines-backupper.bash"`
5. Save the task.

#### Mac
To add a cron job on macOS:
1. Open the Terminal.
2. Edit the crontab file:
    ```bash
    crontab -e
    ```
3. Add the following line to run the script at 2 AM every day:
    ```bash
    0 2 * * * /path/to/firefox-search-engines-backupper/firefox-search-engines-backupper.bash
    ```

Make sure to replace `/path/to/` with the actual path to the script on your system.



## Recommendations:
 
  * https://addons.mozilla.org/en-US/firefox/addon/add-custom-search-engine/

