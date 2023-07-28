# Trailmakers API definitions

Unofficial Trailmakers modding API addon for Lua_LS. Setups the Lua_LS environment for development of Trailmakers mods, including autocompletion/documentation for the API, Lua version and disabled modules

## Installation

1. Clone the repository or download it as a `.zip` and unzip it. Place it inside a folder for Lua_LS addons (e.g. `~/documents/LuaAddons/`)
2. Add the file path of the addons folder to the `workspace.userThirdParty` Lua_LS setting
  - VSCode
    1. Open command palette (`ctrl+shift+p`) from the mods folder
    2. Select `Preferences: Open workspace Settings`
    3. Search for `lua.workspace.userThirdParty`
    4. Click "Add Item", enter the path of the addons folder, and click "Ok"
  - Other editors: set the value of the Lua_LS setting `Lua.workspace.userThirdParty` to the path of the addons folder
3. After opening a mod file, you should be prompted to enable the addon. Select "Apply and modify settings"
