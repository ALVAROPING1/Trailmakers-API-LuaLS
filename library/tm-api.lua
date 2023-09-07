---@meta
-- Original document by Ridicolas
-- Updated to include new functions and fully work with LuaLS by ALVAROPING1
-- Further updated by Vajdani
-- Improved formatting, fixed types, added missing descriptions to parameters, and converted into an addon to remove disabled lua modules by ALVAROPING1

---Global function executed on each mod update cycle. Should be redefined to use it
function update() end

---Modding API Module
tm = {}

--------------------- OS ---------------------

--#region

---Everything to do with files and general mod systems
tm.os = {}

---Read all text of a file in the mods static data directory. Files in the static data directory can only be read and NOT written to
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218562600/File+Handling)
---@param path string Relative file path
---@return string # Content of the file
---@nodiscard
function tm.os.ReadAllText_Static(path) end

---Read all text of a file in the mods dynamic data directory. Files in the dynamic data directory can be both read and written to. The dynamic data directory will NOT be uploaded to the steam workshop when you upload your mod. When a mod is run through the steam workshop, the dynamic data, unlike static data, is not located in the steam workshop directory but is located in the steam user data directory instead
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218562600/File+Handling)
---@param path string Relative file path
---@return string # Content of the file
---@nodiscard
function tm.os.ReadAllText_Dynamic(path) end

---Create or overwrite a file in the mods dynamic data directory. Files in the dynamic data directory can be both read and written to. The dynamic data directory will NOT be uploaded to the steam workshop when you upload your mod. When a mod is run through the steam workshop, the dynamic data, unlike static data, is not located in the steam workshop directory but is located in the steam user data directory instead
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218562600/File+Handling)
---@param path string Relative file path
---@param stringToWrite string Data to write in the file
---@return nil
function tm.os.WriteAllText_Dynamic(path, stringToWrite) end

---Emit a log message
---@param message string | number | boolean | nil | ModVector3 | ModQuaternion | ModGameObject | ModTransform | ModStructure | ModBlock | CallbackData Message to log. API types are logged using their `.ToString()` method
---@return nil
function tm.os.Log(message) end

---Get time game has been playing in seconds. Doesn't update within a single mod update cycle
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267786/Game+Loop+Ticks)
---@return number
---@nodiscard
function tm.os.GetTime() end

---Get the time since last update
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267786/Game+Loop+Ticks)
---@return number
---@nodiscard
function tm.os.GetModDeltaTime() end

---Determines how often the mod gets updated. `1/60` means 60 times per second. Can't update faster than the game (maximum is 60 times per second)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267786/Game+Loop+Ticks)
---@param targetDeltaTime number
---@return nil
function tm.os.SetModTargetDeltaTime(targetDeltaTime) end

---Returns the target delta time for the mod
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267786/Game+Loop+Ticks)
---@return number
---@nodiscard
function tm.os.GetModTargetDeltaTime() end

--#endregion

--------------------- Physics ---------------------

--#region

---Name referencing a mesh loaded with `tm.physics.AddMesh()`
---@alias MeshName string

---Name referencing a texture loaded with `tm.physics.AddTexture()`
---@alias TextureName string

---Everything that can effect physics, like gravity, spawning objects, and importing meshes
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218169403/Physics)
tm.physics = {}

---Set the physics timescale relative to the default speed (acts as a multiplier of the normal time speed)
---@param speed number
---@return nil
function tm.physics.SetTimeScale(speed) end

---Get the physics timescale relative to the default speed (acts as a multiplier of the normal time speed)
---@return number
---@nodiscard
function tm.physics.GetTimeScale() end

---Set the physics gravity in the down direction. Units are `m/s²`, default is `14 m/s²`
---@param strength number
---@return nil
function tm.physics.SetGravity(strength) end

---Set the physics gravity as per the provided vector. Units are `m/s²`, default is `(0, -14, 0) m/s²`
---@param gravity ModVector3
---@return nil
function tm.physics.SetGravity(gravity) end

---Get the physics gravity. Units are `m/s²`, default is `(0, 14, 0) m/s²`
---@return ModVector3
---@nodiscard
function tm.physics.GetGravity() end

---Spawn a spawnable at the position, e.g. PFB_Barrel
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267704/ModGameObject#Example---Spawning-a-built-in-object)
---@param position ModVector3 Position of the object
---@param name Spawnable Name of the object. Can only be a default asset name (from the list returned by `tm.physics.SpawnableNames()`). See `Spawnable` type alias
---@return ModGameObject object Game object spawned
function tm.physics.SpawnObject(position, name) end

---Despawn all spawned objects from this mod
---@return nil
function tm.physics.ClearAllSpawns() end

---Get a list of all possible spawnable names
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267747/Spawnables)
---@return string[]
---@nodiscard
function tm.physics.SpawnableNames() end

---Add a mesh to all clients, note this will have to be sent to the client when they join
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219283457/Custom+Assets)
---@param filename string The name of the mesh in the mod files (Must use the `.obj` format)
---@param resourceName MeshName The name that the mesh will use. See `MeshName` type alias
---@return nil
function tm.physics.AddMesh(filename, resourceName) end

---Add a texture to all clients, note this will have to be sent to the client when they join
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219283457/Custom+Assets)
---@param filename string The name of the texture in the mod files (Must use the `.png` or `.jpg` format)
---@param resourceName TextureName The name that the texture will use. See `TextureName` type alias
---@return nil
function tm.physics.AddTexture(filename, resourceName) end

---Spawn a custom physics object
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219283457/Custom+Assets)
---@param position ModVector3 The position to spawn the object at
---@param meshName MeshName The name of the mesh that the object will use. See `MeshName` type alias
---@param textureName TextureName The name of the texture that the object will use. See `TextureName` type alias
---@param isKinematic boolean Whether the object will be affected by physics or not
---@param mass number The mass of the object. Units are `5kg`
---@return ModGameObject # Game object spawned
function tm.physics.SpawnCustomObjectRigidbody(position, meshName, textureName, isKinematic, mass) end

---Spawn a custom object
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219283457/Custom+Assets)
---@param position ModVector3 The position to spawn the object at
---@param meshName MeshName The name of the mesh that the object will use. See `MeshName` type alias
---@param textureName TextureName The name of the texture that the object will use. See `TextureName` type alias
---@return ModGameObject # Game object spawned
function tm.physics.SpawnCustomObject(position, meshName, textureName) end

---Spawn a custom object with concave collision support
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219283457/Custom+Assets)
---@param position ModVector3 The position to spawn the object at
---@param meshName MeshName The name of the mesh that the object will use. See `MeshName` type alias
---@param textureName TextureName The name of the texture that the object will use. See `TextureName` type alias
---@return ModGameObject # Game object spawned
function tm.physics.SpawnCustomObjectConcave(position, meshName, textureName) end

---Spawn a box trigger that will detect overlap but will not interact with physics
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267704/ModGameObject#Example---Spawning-a-trigger)
---@param position ModVector3 The position to spawn the Box Trigger at
---@param size ModVector3 The Box Trigger' size
---@return ModGameObject # Game object spawned
function tm.physics.SpawnBoxTrigger(position, size) end

---Sets the build complexity value. Default value is `700` and values above it can make the game unstable
---@param value integer
---@return nil
function tm.physics.SetBuildComplexity(value) end

---Registers a function to the collision enter callback of a game object
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218169403/Physics#Collision-Callbacks)
---@param targetObject ModGameObject Object for which the callback will be registered
---@param functionName string Name of the function to register. Must be in the global scope. This function will be executed with the `PlayerID` of the player who triggered it as its only parameter
---@return nil
function tm.physics.RegisterFunctionToCollisionEnterCallback(targetObject, functionName) end

---Registers a function to the collision exit callback of a game object
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218169403/Physics#Collision-Callbacks)
---@param targetObject ModGameObject Object for which the callback will be registered
---@param functionName string Name of the function to register. Must be in the global scope. This function will be executed with the `PlayerID` of the player who triggered it as its only parameter
---@return nil
function tm.physics.RegisterFunctionToCollisionExitCallback(targetObject, functionName) end

---Returns a bool if raycast hit something. Hit argument gets overwritten with raycast data
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218169403/Physics#Raycast)
---@param origin ModVector3 Origin of the raycast
---@param direction ModVector3 Direction of the raycast in euler angles
---@param hitPositionOut ModVector3 Reference to the vector in which the hit position will be stored (only modified if the raycast hit an object)
---@param maxDistance number? Max distance from the origin to check for hits. If nil, the distance is infinite
---@return boolean # Whether an object has been hit
function tm.physics.Raycast(origin, direction, hitPositionOut, maxDistance) end

---Returns the internal name for the current map
---@return string # The map name
---@nodiscard
function tm.physics.GetMapName() end

---Returns the wind velocity at a position
---@param position ModVector3
---@return ModVector3
---@nodiscard
function tm.physics.GetWindVelocityAtPosition(position) end

--#endregion

--------------------- Players ---------------------

--#region

---ID of a player. Goes from 0 to 7, and the ID 0 is guaranteed to be the host
---@alias PlayerID integer

---Object representing a player in the game
---@class ModPlayer
---@field playerId PlayerID See `PlayerID` type alias

---Everything to do with players actions and info
tm.players = {}

---@class OnPlayerEvent
local OnPlayerEvent = {}

---Add function to event
---@param Function fun(player: ModPlayer): any
---@return nil
function OnPlayerEvent.add(Function) end

---Remove function from event. The same function object must have been registered with `OnPlayerEvent.add()` first
---@param Function fun(player: ModPlayer): any
---@return nil
function OnPlayerEvent.remove(Function) end

---Event triggered when a player joins the server
---@type OnPlayerEvent
tm.players.OnPlayerJoined = {}
---Alias for `tm.players.OnPlayerJoined`
tm.players.onPlayerJoined = tm.players.OnPlayerJoined

---Event triggered when a player leaves the server
---@type OnPlayerEvent
tm.players.OnPlayerLeft = {}
---Alias for `tm.players.OnPlayerLeft`
tm.players.onPlayerLeft = tm.players.OnPlayerLeft

---Get all players currently connected to the server
---@return ModPlayer[]
---@nodiscard
function tm.players.CurrentPlayers() end

---Forcefully disconnect a given player
---@param playerId PlayerID See `PlayerID` type alias
---@return nil
function tm.players.Kick(playerId) end

---Get the Transform of a player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModTransform
---@nodiscard
function tm.players.GetPlayerTransform(playerId) end

---Get the GameObject of a player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModGameObject
---@nodiscard
function tm.players.GetPlayerGameObject(playerId) end

---Returns whether the player is seated or not
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.IsPlayerInSeat(playerId) end

---Sets whether the specified player can fly or not
---@param playerId PlayerID See `PlayerID` type alias
---@param enabled boolean
---@return nil
function tm.players.SetJetpackEnabled(playerId, enabled) end

---Get all structure(s) owned by that player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModStructure[]
---@nodiscard
function tm.players.GetPlayerStructures(playerId) end

---Get the structure(s) currently in build mode for a player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModStructure[]
---@nodiscard
function tm.players.GetPlayerStructuresInBuild(playerId) end

---Get the last select block in the builder for that player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModBlock
---@nodiscard
function tm.players.GetPlayerSelectBlockInBuild(playerId) end

---Get the player's name
---@param playerId PlayerID See `PlayerID` type alias
---@return string
---@nodiscard
function tm.players.GetPlayerName(playerId) end

---Returns true if the player is in build mode
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.GetPlayerIsInBuildMode(playerId) end

--#endregion

--------------------- PlayerUI ---------------------

--#region

---For adding UI to your mod
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267719/PlayerUI)
tm.playerUI = {}

---ID of an UI element
---@alias UIElementID string | number | boolean

---Add a button to the client's mod UI
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267719/PlayerUI#How-to-work-with-buttons)
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param defaultValue string Text of the button
---@param callback fun(UICallbackData) Function to execute when the button is pressed
---@param data any Arbitrary data passed to the callback function
---@return nil
function tm.playerUI.AddUIButton(playerId, id, defaultValue, callback, data) end

---Add a text field to the client's mod UI
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267719/PlayerUI#How-to-work-with-text-fields)
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param defaultValue string Default text
---@param callback fun(UICallbackData) Function to execute when the button is pressed
---@param data any Arbitrary data passed to the callback function
---@return nil
function tm.playerUI.AddUIText(playerId, id, defaultValue, callback, data) end

---Add a label to the client's mod UI
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267719/PlayerUI#How-to-display-values)
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param defaultValue string Text of the label
---@return nil
function tm.playerUI.AddUILabel(playerId, id, defaultValue) end

---Set the value of a client's UI element
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param value string New value of the UI element (text shown on the UI element)
---@return nil
function tm.playerUI.SetUIValue(playerId, id, value) end

---Remove all UI elements for a player
---@param playerId PlayerID Player for which the UI element will be cleared. See `PlayerID` type alias
---@return nil
function tm.playerUI.ClearUI(playerId) end

--#endregion

--------------------- Audio ---------------------

--#region

---Lets you play audio and effect audio
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219185167/Audio)
tm.audio = {}

---Play audio at a position. This is more cost friendly but you can not stop or move the sound
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219185167/Audio#Example---Play-an-explosion-sound-at-players-position-every-second)
---@param audioName AudioName Name of the audio to play. See `AudioName` type alias
---@param position ModVector3 Position of the audio
---@param keepObjectDuration number Duration of the audio
---@return nil
function tm.audio.PlayAudioAtPosition(audioName, position, keepObjectDuration) end

---Play audio on a GameObject
---@param audioName AudioName Name of the audio to play. See `AudioName` type alias
---@param modGameObject ModGameObject GameObject on which the audio should be played
---@return nil
function tm.audio.PlayAudioAtGameobject(audioName, modGameObject) end

---Stop all audio on a GameObject
---@param modGameObject ModGameObject
---@return nil
function tm.audio.StopAllAudioAtGameobject(modGameObject) end

---Get a list of all playable audio names
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219185167/Audio#List-of-Audio-Event-names)
---@return string[]
---@nodiscard
function tm.audio.GetAudioNames() end

--#endregion

--------------------- Input ---------------------

--#region

---Keys that can have callbacks registered
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267762/Input#List-of-key-names)
---@alias InputKey "`" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0" | "-" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "[" | "]" | ";" | "'" | "\\" | "," | "." | "/" | "backspace" | "tab" | "enter" | "left shift" | "right shift" | "left control" | "left alt" | "space" | "right alt" | "right control" | "insert" | "home" | "page up" | "delete" | "end" | "page down" | "up" | "down" | "left" | "right" | "numlock" | "[/]" | "[*]" | "[-]" | "[+]" | "[enter]" | "[,]" | "[1]" | "[2]" | "[3]" | "[4]" | "[5]" | "[6]" | "[7]" | "[8]" | "[9]" | "[0]"

---Lets you trigger functions on key press/release by players
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267762/Input)
tm.input = {}

---Registers a function to the callback of when the given player presses the given key
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267762/Input)
---@param playerId PlayerID Player for which the function will be registered. See `PlayerID` type alias
---@param functionName string Name of the function to register. Must be in the global scope. This function will be executed with the `PlayerID` of the player who triggered it as its only parameter
---@param keyName InputKey Name of the key to use. See `InputKey` type alias
---@return nil
function tm.input.RegisterFunctionToKeyDownCallback(playerId, functionName, keyName) end

---Registers a function to the callback of when the given player releases  the given key
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267762/Input)
---@param playerId PlayerID Player for which the function will be registered. See `PlayerID` type alias
---@param functionName string Name of the function to register. Must be in the global scope. This function will be executed with the `PlayerID` of the player who triggered it as its only parameter
---@param keyName InputKey Name of the key to use. See `InputKey` type alias
---@return nil
function tm.input.RegisterFunctionToKeyUpCallback(playerId, functionName, keyName) end

--#endregion

--------------------- Vector3 ---------------------

--#region

---For all things vectors, vector3 can store 3 numbers
tm.vector3 = {}

---3D Vector object, can store 3 numbers
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3)
---@class ModVector3
---@operator mul(number) : ModVector3 Vector-scalar multiplication
---@operator div(number) : ModVector3 Vector-scalar division
---@operator add(ModVector3) : ModVector3 Vector addition
---@operator sub(ModVector3) : ModVector3 Vector subtraction
---@operator unm(ModVector3) : ModVector3 Vector negation
---@field x number X value of the vector
---@field y number Y value of the vector
---@field z number Z value of the vector
---@field Equals fun(otherVector: ModVector3): boolean Returns true if both vectors are the same, false if not (can be done with the normal `==` operator)
---@field GetHashCode fun(): integer Returns the hash code of the vector
---@field Dot fun(otherVector: ModVector3): number Returns the dot product of two vector3
---@field Cross fun(otherVector: ModVector3): ModVector3 Returns the cross product of two vector3
---@field Magnitude fun(): number Returns the magnitude/length
---@field ToString fun(): string Returns a formatted string of a vector in the form `(x, y, z)`
---@field toString fun(): string Returns a formatted string of a vector in the form `(x, y, z)`

---Creates a vector3 with specified values
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@param x number
---@param y number
---@param z number
---@return ModVector3
---@nodiscard
function tm.vector3.Create(x, y, z) end

---Creates a vector3 with values defaulted to zero
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Create() end

---Creates a vector3 pointing right (1, 0, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Right() end

---Creates a vector3 pointing left (-1, 0, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Left() end

---Creates a vector3 pointing up (0, 1, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Up() end

---Creates a vector3 pointing down (0, -1, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Down() end

---Creates a vector3 pointing forward (0, 0, 1)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Forward() end

---Creates a vector3 pointing back (0, 0, -1)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function tm.vector3.Back() end

---Flips all the signs (can be done with the normal `-` operator)
---@param vector3 ModVector3
---@return ModVector3
---@nodiscard
function tm.vector3.op_UnaryNegation(vector3) end

---Adds first and second together (can be done with the normal `+` operator)
---@param first ModVector3
---@param second ModVector3
---@return ModVector3
---@nodiscard
function tm.vector3.op_Addition(first, second) end

---Subtracts first and second together (can be done with the normal `-` operator)
---@param first ModVector3
---@param second ModVector3
---@return ModVector3
---@nodiscard
function tm.vector3.op_Subtraction(first, second) end

---Multiplies the vector by the scalar (can be done with the normal `*` operator)
---@param vector3 ModVector3
---@param scalar number
---@return ModVector3
---@nodiscard
function tm.vector3.op_Multiply(vector3, scalar) end

---Divides the vector by the divisor (can be done with the normal `/` operator)
---@param vector3 ModVector3
---@param divisor number
---@return ModVector3
---@nodiscard
function tm.vector3.op_Division(vector3, divisor) end

---Returns true if both vectors are the same, false if not (can be done with the normal `==` operator)
---@param first ModVector3
---@param second ModVector3
---@return boolean
---@nodiscard
function tm.vector3.op_Equality(first, second) end

---Returns true if both vectors are not the same, false if not (can be done with the normal `~=` operator)
---@param first ModVector3
---@param second ModVector3
---@return boolean
---@nodiscard
function tm.vector3.op_Inequality(first, second) end

--#endregion

--------------------- Quaternion ---------------------

--#region

---Quaternions are for rotations, they get rid of gimbal lock that a vector3 rotation runs into. Quaternions can store 4 numbers
tm.quaternion = {}

---Quaternion object. Quaternions are for rotations, they get rid of gimbal lock that a vector3 rotation runs into. Quaternions can store 4 numbers
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218628133/ModQuaternion)
---@class ModQuaternion
---@field x number X value of the quaternion
---@field y number Y value of the quaternion
---@field z number Z value of the quaternion
---@field w number W value of the quaternion
---@field GetEuler fun(): ModVector3 Returns a vector3 representing the euler angles of the quaternion
---@field Multiply fun(otherQuaternion: ModQuaternion): ModQuaternion Multiplies two quaternions and returns the result
---@field ToString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModQuaternion`
---@field toString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModQuaternion`

---Creates a quaternion by manually defining its components
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218628133/ModQuaternion#Creating-Quaternions)
---@param x number
---@param y number
---@param z number
---@param w number
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(x, y, z, w) end

---Creates a quaternion using euler angle components
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218628133/ModQuaternion#Creating-Quaternions)
---@param x number
---@param y number
---@param z number
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(x, y, z) end

---Creates a quaternion using a euler angle vector3
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218628133/ModQuaternion#Creating-Quaternions)
---@param eulerAngle ModVector3
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(eulerAngle) end

---Creates a quaternion using an angle and an axis to rotate around
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218628133/ModQuaternion#Creating-Quaternions)
---@param angle number
---@param axis ModVector3
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(angle, axis) end

---Returns the resulting quaternion from a slerp between two quaternions
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218628133/ModQuaternion#Working-with-ModQuaternion)
---@param firstQuaternion ModQuaternion
---@param secondQuaternion ModQuaternion
---@param t number Position in the interpolation (0=firstQuaternion, 1=secondQuaternion)
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Slerp(firstQuaternion, secondQuaternion, t) end

--#endregion

--------------------- Callback Data ---------------------

--#region

---These are all the things you can get from the argument that UI elements pass in the function you specify
---@class CallbackData
---@field playerId PlayerID Gives you the player that interacted with the element. See `PlayerID` type alias
---@field id UIElementID Gives you the ID of the interacted element. See `UIElementID` type alias
---@field type string Gives you the type of the interacted element
---@field value string Gives you the value of the interacted element. Value is the text shown on the UI element
---@field data any Gives you the data of the interacted element. You pass in this data when registering the UI element's callback
---@field ToString fun(): string Always returns `Trailmakers.Mods.Api.ModApiPlayerUI+UICallbackData`
---@field toString fun(): string Always returns `Trailmakers.Mods.Api.ModApiPlayerUI+UICallbackData`

--#endregion

--------------------- Documentation ---------------------

--#region

---Gives the unformatted documentation
---@return string
---@nodiscard
function tm.GetDocs() end

--#endregion

--------------------- ModGameObject ---------------------

--#region

---Object representing a 3D object in the game world
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267704/ModGameObject)
---@class ModGameObject
---@field Despawn fun(): nil Despawns the object. This can not be done on players
---@field GetTransform fun(): ModTransform Returns the GameObject's Transform
---@field SetIsVisible fun(isVisible: boolean): nil Sets visibility of the GameObject
---@field GetIsVisible fun(): boolean Gets the visibility of the GameObject
---@field GetIsRigidbody fun(): boolean Returns true if the GameObject or any of its children are rigidbodies
---@field SetIsStatic fun(isStatic: boolean): nil Sets the GameObject's and its children's rigidbodies to be static or not
---@field GetIsStatic fun(): boolean Returns true if the GameObject and all of its children are static
---@field SetIsTrigger fun(isTrigger: boolean): nil Determines whether the GameObject lets other GameObjects pass through its colliders or not
---@field Exists fun(): boolean Returns true if the GameObject exists
---@field ToString fun(): string Always returns `PFB_ModGameObject [Server] (ModGameObject_Server)`
---@field toString fun(): string Always returns `PFB_ModGameObject [Server] (ModGameObject_Server)`

--#endregion

--------------------- ModTransform ---------------------

--#region

---Object representing the transform of a `ModGameObject`. Handles its position, rotation and scale
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218431584/ModTransform)
---@class ModTransform
---@field SetPosition (fun(position: ModVector3): nil) | (fun(x: number, y: number, z: number): nil) Sets the position of the Transform
---@field GetPosition fun(): ModVector3 Gets the position of the Transform
---@field SetRotation (fun(rotation: ModVector3): nil) | (fun(x: number, y: number, z: number): nil) | (fun(rotation: ModQuaternion): nil) Sets the rotation of the Transform
---@field GetRotation fun(): ModVector3 Gets the rotation of the Transform
---@field GetRotationQuaternion fun(): ModQuaternion Gets the rotation quaternion of the Transform
---@field SetScale (fun(scaleVector: ModVector3): nil) | (fun(x: number, y: number, z: number): nil) | (fun(scale: number): nil) Sets the scale of the Transform. Setting a non-uniform scale may, among other things, break the objects physics
---@field GetScale fun(): ModVector3 Gets the scale of the Transform
---@field TransformPoint fun(point: ModVector3): ModVector3 Returns the point's position in world space (Adds the current pos with input vector)
---@field TransformDirection fun(direction: ModVector3): ModVector3 Returns the direction's world space direction
---@field ToString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModTransform`
---@field toString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModTransform`

--#endregion

--------------------- ModBlock ---------------------

--#region

---Object representing a block of a creation in the game
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218562585/ModBlock)
---@class ModBlock
---@field SetColor fun(r: number, g: number, b: number): nil [In buildmode only] Set the block's primary color
---@field SetSecondaryColor fun(r: number, g: number, b: number): nil [In buildmode only] Set the block's secondary color
---@field SetMass fun(mass: number): nil [In buildmode only] Set the block's mass. Units are `5kg`
---@field GetMass fun(): number Get the block's mass. Units are `5kg`
---@field SetBuoyancy fun(buoyancy: number): nil [In buildmode only] Set the block's buoyancy
---@field GetBuoyancy fun(): number Get the block's buoyancy
---@field SetHealth fun(hp: number): nil Set the block's health
---@field GetStartHealth fun(): number Get the block's start health
---@field GetCurrentHealth fun(): number Get the block's current health
---@field GetName fun(): string Get the name of the block's type
---@field SetDragAll fun(f: number, b: number, u: number, d: number, l: number, r: number): nil Set the drag value in all directions, front, back, up, down, left, right
---@field AddForce fun(x: number, y: number, z: number): nil Add a force to the given block as an impulse. Units are `5kg * m/s²`
---@field AddTorque fun(x: number, y: number, z: number): nil Add a torque to the given block as an impulse
---@field SetEnginePower fun(power: number): nil Sets Engine power (only works on engine blocks)
---@field GetEnginePower fun(): number Gets Engine power (only works on engine blocks)
---@field SetJetPower fun(power: number): nil Sets Jet power (only works on jet blocks)
---@field GetJetPower fun(): number Gets jet power (only works on jet blocks)
---@field Exists fun(): boolean Returns true if the block exists. Keep in mind that when you repair your structure, your destroyed blocks will be replaced with different ones, making the old ones useless
---@field ToString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModBlock`
---@field toString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModBlock`

--#endregion

--------------------- ModStructure ---------------------

--#region

---Object representing a creation in the game
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218103875/ModStructure)
---@class ModStructure
---@field Destroy fun(): nil Destroy the structure
---@field GetBlocks fun(): ModBlock[] Gets all blocks in the structure
---@field AddForce fun(x: number, y: number, z: number): nil Add a force to the given structure as an impulse. Units are `5kg * m/s²`
---@field ToString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModStructure`
---@field toString fun(): string Always returns `Trailmakers.Mods.Api.Proxies.ModStructure`

--#endregion
