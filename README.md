# Trailmakers API definitions

Unofficial Trailmakers modding API addon for LuaLS. Setups the LuaLS environment for development of Trailmakers mods

## Features

- Autocompletion, definitions and documentation of the modding API functions and types, as well as Moonsharp's additions that are enabled in game
- Sets the language server to the correct Lua version used in the game
- Removes definitions of functions and modules from the standard library that are disabled in game

## Installation

1. Install [lua-language-server](https://github.com/LuaLS/lua-language-server#install)
2. Clone this repository or download it as a `.zip` and unzip it. Place it inside a folder for LuaLS addons (e.g. `~/documents/LuaAddons/`)
3. Add the file path of the addons folder to the `workspace.userThirdParty` LuaLS setting
   - VSCode
     1. Open command palette (`ctrl+shift+p`) from your mods folder
     2. Select `Preferences: Open workspace Settings`
     3. Search for `lua.workspace.userThirdParty`
     4. Click "Add Item", enter the path of the addons folder, and click "Ok"
   - Other editors: set the value of the LuaLS setting `Lua.workspace.userThirdParty` to an array with the path of the addons folder. You might want to set this only in the workspace settings of your mods folder
4. After opening a lua file in the mods folder, you should be prompted to enable the addon. Select "Apply and modify settings". If you aren't prompted to enable the addon, verify that the LuaLS setting `workspace.checkThirdParty` is set to `true`
   - If the addon isn't enabled, add the path to the `library` folder within your local copy of this repository to the `Lua.workspace.library` LuaLS setting. You also need to copy all the settings within the `settings` key of `config.json` file
5. To remove duplicate documentation, remove the official documentation library file (`trailmakers_docs.lua`) from the mods folder

## Updating

If you cloned the repository when downloading it, you can simply do a pull. If you downloaded it as a `.zip`, you need to redownload it and replace your local copy with the new version
