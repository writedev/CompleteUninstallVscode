## 🚀 Complete Uninstall VSCode

This PowerShell script will help you **completely uninstall Visual Studio Code** from your system, including all extensions and user settings. It also offers the option to **save your settings** and **reinstall VSCode** automatically if you want to start fresh! 🎉

### Features ✨

- Uninstall VSCode silently and cleanly 🧹
- Remove all VSCode extensions and user data 🗑️
- Optionally save your VSCode settings to your Downloads folder 💾
- Optionally reinstall the latest stable version of VSCode automatically 🔄

### How to use 🛠️

Run the following command in PowerShell to execute the uninstall script directly from GitHub:

```powershell
Invoke-Expression (Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/writedev/CompleteUninstallVscode/refs/heads/main/script.ps1')
```

---

> [!WARNING]
>
> - Make sure to run PowerShell with appropriate permissions.
> - Your settings backup will be saved as `settings.json` in your Downloads folder.
> - The script targets Windows OS and the default VSCode installation paths.

### What the script does 📝

1. Prompts you to start the uninstall process.
2. Asks if you want to save your VSCode settings before uninstalling.
3. Detects your VSCode installation path or lets you specify it.
4. Uninstalls VSCode silently.
5. Removes VSCode user data folders (`AppData\Code` and `.vscode` in your user profile).
6. Saves your settings file to your Downloads folder if you chose to.
7. Optionally downloads and installs the latest VSCode version if you want to reinstall.

---

Happy coding! 💻✨
