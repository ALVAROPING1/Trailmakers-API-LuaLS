---@meta

---Global function executed on each mod update cycle. Should be redefined to use it
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Game_Loop_and_Tick)
function update() end

---Types which can be implicitly converted to a string for logging/displaying on the UI. API types are converted using their `.ToString()` method. If `nil`, the empty string is used
---@alias PrintableValue (string | number | boolean | ModVector3 | ModQuaternion | ModGameObject | ModTransform | ModStructure | ModBlock | ModRaycastHit | ModColor | UICallbackData)?

---Trailmakers Modding API
tm = {}

--------------------- OS ---------------------

--#region

---OS-level functionality. Everything to do with files and general mod systems
---@class ModApiTmOs
tm.os = {}

---Higher-level function to load and run chunk of code from specified filename. Equivalent to the native 'dofile' function in Lua. The file must be directly inside the `data_static folder`, subfolders aren't supported
---@param filename string Name of the file without the `.lua` extension
---@return any # Whatever the file returned when executed as a module
function tm.os.DoFile(filename) end

---Read all text of a file in the mods static data directory. Files in the static data directory can only be read and NOT written to
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Files)
---@param path string Relative file path
---@return string # Content of the file
---@nodiscard
function tm.os.ReadAllText_Static(path) end

---Read all text of a file in the mods dynamic data directory. Files in the dynamic data directory can be both read and written to. The dynamic data directory will NOT be uploaded to the steam workshop when you upload your mod. When a mod is run through the steam workshop, the dynamic data, unlike static data, is not located in the steam workshop directory but is located in the steam user data directory instead
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Files)
---@param path string Relative file path
---@return string # Content of the file
---@nodiscard
function tm.os.ReadAllText_Dynamic(path) end

---Create or overwrite a file in the mods dynamic data directory. Files in the dynamic data directory can be both read and written to. The dynamic data directory will NOT be uploaded to the steam workshop when you upload your mod. When a mod is run through the steam workshop, the dynamic data, unlike static data, is not located in the steam workshop directory, but is located in the steam user data directory instead
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Files)
---@param path string Relative file path
---@param stringToWrite string Data to write in the file
---@return nil
function tm.os.WriteAllText_Dynamic(path, stringToWrite) end

---Emit a log message
---@param message PrintableValue Message to log. See `PrintableValue` type alias
---@return nil
function tm.os.Log(message) end

---Get time game has been playing in seconds. Equivalent to `UnityEngine.Time.time`. Doesn't update within a single mod update cycle
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Game_Loop_and_Tick)
---@return number
---@nodiscard
function tm.os.GetTime() end

---Get time game has been playing in seconds. Updates within a single mod update cycle
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Game_Loop_and_Tick)
---@return number
---@nodiscard
function tm.os.GetRealtimeSinceStartup() end

---Get the time since last update
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Game_Loop_and_Tick)
---@return number
---@nodiscard
function tm.os.GetModDeltaTime() end

---Determines how often the mod gets updated. `1/60` means 60 times per second. Can't update faster than the game (maximum is 60 times per second)
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Game_Loop_and_Tick)
---@param targetDeltaTime number
---@return nil
function tm.os.SetModTargetDeltaTime(targetDeltaTime) end

---Returns the target delta time for the mod
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Game_Loop_and_Tick)
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

---Everything that can effect physics, like gravity, spawning objects, and importing meshes. Environment, Physics, Time, Assets and Objects
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218169403/Physics)
---@class ModApiPhysics
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
---
---[DEPRECATED USE `.SetGravityMultiplier()` INSTEAD]
---@deprecated
---@param strength number
---@return nil
function tm.physics.SetGravity(strength) end

---Set the gravity multiplier. Has no effect in zero G locations. For example, setting the multiplier to 2 doubles gravity
---@param multiplier number
---@return nil
function tm.physics.SetGravityMultiplier(multiplier) end

---Set the physics gravity as per the provided vector. Units are `m/s²`, default is `(0, -14, 0) m/s²`
---
---[DEPRECATED FUNCTIONALITY MIGHT NOT WORK AS INTENDED]
---@deprecated
---@param gravity ModVector3
---@return nil
function tm.physics.SetGravity(gravity) end

---Get the physics gravity. Units are `m/s²`, default is `(0, 14, 0) m/s²`
---
---[DEPRECATED FUNCTIONALITY MIGHT NOT WORK AS INTENDED]
---@deprecated
---@return ModVector3
---@nodiscard
function tm.physics.GetGravity() end

---Get the gravity multiplier
---@return number
---@nodiscard
function tm.physics.GetGravityMultiplier() end

---Spawn a spawnable at the position, e.g. PFB_Barrel
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModGameObject#Example_-_Spawning_a_built-in_object)
---@param position ModVector3 Position of the object
---@param name Spawnable Name of the object. Can only be a default asset name (from the list returned by `tm.physics.SpawnableNames()`). See `Spawnable` type alias
---@return ModGameObject object Game object spawned
function tm.physics.SpawnObject(position, name) end

---Despawn all spawned objects from this mod
---@return nil
function tm.physics.ClearAllSpawns() end

---Despawn a spawnable e.g. PFB_Barrel. Same as `gameObject.Despawn()`
---@param gameObject ModGameObject
---@return nil
function tm.physics.DespawnObject(gameObject) end

---Get a list of all possible spawnable names
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267747/Spawnables)
---@return string[]
---@nodiscard
function tm.physics.SpawnableNames() end

---Removes the physics timescale
---@return nil
function tm.physics.RemoveTimeScale() end

---Add a mesh to all clients, note this mesh will have to be sent to the client when they join (handled automatically)
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Custom_Assets)
---@param filename string The name of the mesh in the mod files (Must use the `.obj` format)
---@param resourceName MeshName The name that the mesh will use. See `MeshName` type alias
---@return nil
function tm.physics.AddMesh(filename, resourceName) end

---Add a texture to all clients, note this texture will have to be sent to the client when they join (handled automatically)
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Custom_Assets)
---@param filename string The name of the texture in the mod files (Must use the `.png` or `.jpg` format)
---@param resourceName TextureName The name that the texture will use. See `TextureName` type alias
---@return nil
function tm.physics.AddTexture(filename, resourceName) end

---Spawn a custom physics object
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Custom_Assets)
---@param position ModVector3 The position to spawn the object at
---@param meshName MeshName The name of the mesh that the object will use. See `MeshName` type alias
---@param textureName TextureName The name of the texture that the object will use. See `TextureName` type alias
---@param isKinematic boolean Whether the object will be affected by physics or not
---@param mass number The mass of the object. Units are `5kg`
---@return ModGameObject # Game object spawned
function tm.physics.SpawnCustomObjectRigidbody(position, meshName, textureName, isKinematic, mass) end

---Spawn a custom object
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Custom_Assets)
---@param position ModVector3 The position to spawn the object at
---@param meshName MeshName The name of the mesh that the object will use. See `MeshName` type alias
---@param textureName TextureName The name of the texture that the object will use. See `TextureName` type alias
---@return ModGameObject # Game object spawned
function tm.physics.SpawnCustomObject(position, meshName, textureName) end

---Spawn a custom object with concave collision support
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:Custom_Assets)
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
---@param ignoreTriggers boolean? Whether to ignore trigger objects
---@return boolean # Whether an object has been hit
function tm.physics.Raycast(origin, direction, hitPositionOut, maxDistance, ignoreTriggers) end

---Casts a ray with the specific settings and returns a `ModRaycastHit`
---@param origin ModVector3 Origin of the raycast
---@param direction ModVector3 Direction of the raycast in euler angles
---@param maxDistance number Max distance from the origin to check for hits
---@param ignoreTriggers boolean? Whether to ignore trigger objects
---@return ModRaycastHit
---@nodiscard
function tm.physics.RaycastData(origin, direction, maxDistance, ignoreTriggers) end

---Returns the internal name for the current map
---@return string
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

---ID of a team. Goes from 0 to 7, with the value selected through the session settings UI being `TeamID + 1`
---@alias TeamID integer

---ID referencing a structure spawned with `tm.players.SpawnStructure()`
---@alias StructureID string

---ID referencing a spawn point location created with `tm.players.SetSpawnPoint()`
---@alias SpawnLocationID string

---Object representing a player in the game
---@class Player
---@field playerId PlayerID See `PlayerID` type alias
local Player = {}

---Always returns `Trailmakers.Mods.Api.ModApiPlayers+Player`
---@return string
---@nodiscard
function Player.ToString() end

---Always returns `Trailmakers.Mods.Api.ModApiPlayers+Player`
---@return string
---@nodiscard
function Player.toString() end

---Everything to do with players actions and info
---@class ModApiPlayers
tm.players = {}

---@class OnPlayerEvent
local OnPlayerEvent = {}

---Add function to event
---@param Function fun(player: Player): any
---@return nil
function OnPlayerEvent.add(Function) end

---Remove function from event. The same function object must have been registered with `OnPlayerEvent.add()` first
---@param Function fun(player: Player): any
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
---@return Player[]
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

---Returns true if the player is in a seat
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.IsPlayerInSeat(playerId) end

---Kills a player
---@param playerId PlayerID See `PlayerID` type alias
---@return nil
function tm.players.KillPlayer(playerId) end

---Checks if player can be killed
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.CanKillPlayer(playerId) end

---Sets the invincibility status of a player
---@param playerId PlayerID See `PlayerID` type alias
---@param enabled boolean
---@return nil
function tm.players.SetPlayerIsInvincible(playerId, enabled) end

---Enables and disables the jetpack
---@param playerId PlayerID See `PlayerID` type alias
---@param enabled boolean
---@return nil
function tm.players.SetJetpackEnabled(playerId, enabled) end

---Get all structure(s) owned by that player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModStructure[]
---@nodiscard
function tm.players.GetPlayerStructures(playerId) end

---Get structure by ID. Can only get structures spawned through `tm.players.SpawnStructure()`
---@param structureId StructureID See `StructureID` type alias
---@return ModStructure[]
---@nodiscard
function tm.players.GetSpawnedStructureById(structureId) end

---Get the structure(s) currently in build mode for a player
---@param playerId PlayerID See `PlayerID` type alias
---@return ModStructure[]
---@nodiscard
function tm.players.GetPlayerStructuresInBuild(playerId) end

---Get the last selected block in the builder for that player. Returns `nil` if the player hasn't selected a block in the current session
---
---Dragging blocks doesn't count as selecting them. When multiple blocks are selected, only the first selected block is returned
---@param playerId PlayerID See `PlayerID` type alias
---@return ModBlock?
---@nodiscard
function tm.players.GetPlayerSelectBlockInBuild(playerId) end

---Get the player's name
---@param playerId PlayerID See `PlayerID` type alias
---@return string
---@nodiscard
function tm.players.GetPlayerName(playerId) end

---Get the player's team index
---@param playerId PlayerID See `PlayerID` type alias
---@return TeamID # See `TeamID` type alias
---@nodiscard
function tm.players.GetPlayerTeam(playerId) end

---Set the player's team index
---@param playerId PlayerID See `PlayerID` type alias
---@param teamID TeamID See `TeamID` type alias
---@return nil
function tm.players.SetPlayerTeam(playerId, teamID) end

---Returns the highest team index allowed (always returns `7`)
---@return TeamID # See `TeamID` type alias
---@nodiscard
function tm.players.GetMaxTeamIndex() end

---Returns true if the player is in build mode
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.GetPlayerIsInBuildMode(playerId) end

---Add a camera. THERE CAN ONLY BE 1 CAMERA PER PLAYER!
---@param playerId PlayerID See `PlayerID` type alias
---@param position ModVector3
---@param rotation ModVector3
---@return nil
function tm.players.AddCamera(playerId, position, rotation) end

---Remove a camera. THERE CAN ONLY BE 1 CAMERA PER PLAYER!
---@param playerId PlayerID See `PlayerID` type alias
---@return nil
function tm.players.RemoveCamera(playerId) end

---Set camera position
---@param playerId PlayerID See `PlayerID` type alias
---@param position ModVector3
---@return nil
function tm.players.SetCameraPosition(playerId, position) end

---Set camera rotation
---@param playerId PlayerID See `PlayerID` type alias
---@param rotation ModVector3 Direction vector the camera will point in
---@return nil
function tm.players.SetCameraRotation(playerId, rotation) end

---Activate a camera with fade-in
---@param playerId PlayerID See `PlayerID` type alias
---@param fadeInDuration number
---@return nil
function tm.players.ActivateCamera(playerId, fadeInDuration) end

---Deactivate a camera with fade-out
---@param playerId PlayerID See `PlayerID` type alias
---@param fadeOutDuration number
---@return nil
function tm.players.DeactivateCamera(playerId, fadeOutDuration) end

---Spawn a structure for a player with given blueprint, position and rotation
---@param playerId PlayerID Player to which the blueprint will belong. See `PlayerID` type alias
---@param blueprint TextureName Name of the blueprint to spawn. See `TextureName` type alias
---@param structureId StructureID ID that will be used to reference the structure. See `StructureID` type alias
---@param position ModVector3 Position of the spawned structure
---@param rotation ModVector3 Rotation of the spawned structure
---@return nil
function tm.players.SpawnStructure(playerId, blueprint, structureId, position, rotation) end

---Despawn a structure
---@param structureId StructureID See `StructureID` type alias
---@return nil
function tm.players.DespawnStructure(structureId) end

---Places the player in the seat of a structure
---@param playerId PlayerID See `PlayerID` type alias
---@param structureId StructureID See `StructureID` type alias
---@return nil
function tm.players.PlacePlayerInSeat(playerId, structureId) end

---Set if the builder for a player should be enabled
---@param playerId PlayerID See `PlayerID` type alias
---@param isEnabled boolean
---@return nil
function tm.players.SetBuilderEnabled(playerId, isEnabled) end

---Set if repairing for a player should be enabled. Also enables/disables transform
---@param playerId PlayerID See `PlayerID` type alias
---@param isEnabled boolean
---@return nil
function tm.players.SetRepairEnabled(playerId, isEnabled) end

---Checks if building is enabled for a player
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.GetBuilderEnabled(playerId) end

---Checks if repairing is enabled for a player
---@param playerId PlayerID See `PlayerID` type alias
---@return boolean
---@nodiscard
function tm.players.GetRepairEnabled(playerId) end

---Returns the block the player is seated in
---@param playerId PlayerID See `PlayerID` type alias
---@return ModBlock
---@nodiscard
function tm.players.GetPlayerSeatBlock(playerId) end

---Sets the spawn location the player should use when respawning. Will be overwritten if another spawn location is set, eg checkpoints on the map
---@param playerId PlayerID See `PlayerID` type alias
---@param spawnLocationId SpawnLocationID See `SpawnLocationID` type alias
---@return nil
function tm.players.SetPlayerSpawnLocation(playerId, spawnLocationId) end

---Sets the position and rotation of the spawn point for a player ID at a given spawn location. Each spawn location is a group of spawn points, one for each player ID. spawnLocationId = id of the spawn location. playerId = player ID for which the spawn point will be used when respawning at the location
---@param playerIndex PlayerID See `PlayerID` type alias
---@param spawnLocationId SpawnLocationID See `SpawnLocationID` type alias
---@param position ModVector3
---@param rotation ModVector3
---@return nil
function tm.players.SetSpawnPoint(playerIndex, spawnLocationId, position, rotation) end

---Teleports a player to the selected spawn point location. To teleport all players use `tm.players.TeleportAllPlayersToSpawnPoint()`. Set `keepStructure` to true and it will try to keep their structure after teleporting (will be repaired)
---@param playerId PlayerID See `PlayerID` type alias
---@param spawnLocationId SpawnLocationID See `SpawnLocationID` type alias
---@param keepStructure boolean Whether it should try to keep the players' structure after teleporting (will be repaired)
---@return nil
function tm.players.TeleportPlayerToSpawnPoint(playerId, spawnLocationId, keepStructure) end

---Teleports ALL players to the selected spawn point location. Use this to move up to 8 players to their spawn position. Set `keepStructure` to true and it will try to their structure after teleporting (will be repaired)
---@param spawnLocationId SpawnLocationID See `SpawnLocationID` type alias
---@param keepStructure boolean Whether it should try to keep the players' structure after teleporting (will be repaired)
---@return nil
function tm.players.TeleportAllPlayersToSpawnPoint(spawnLocationId, keepStructure) end

--#endregion

--------------------- PlayerUI ---------------------

--#region

---For adding UI to your mod
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:PlayerUI)
---@class ModApiPlayerUI
tm.playerUI = {}

---ID of an UI element
---@alias UIElementID string | number | boolean

---ID of a subtle message, only exists for the players for which the subtle message was created and is different for each one
---@alias SubtleMessageID string

---Add a button to the client's mod UI
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:PlayerUI#How_to_work_with_buttons)
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param defaultValue PrintableValue Text of the button. See `PrintableValue` type alias
---@param callback fun(UICallbackData) Function to execute when the button is pressed
---@param data any Arbitrary data passed to the callback function
---@return nil
function tm.playerUI.AddUIButton(playerId, id, defaultValue, callback, data) end

---Add a text field to the client's mod UI
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:PlayerUI#How_to_work_with_text_fields)
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param defaultValue PrintableValue Default text of the field. See `PrintableValue` type alias
---@param callback fun(UICallbackData) Function to execute when the text is changed
---@param data any Arbitrary data passed to the callback function
---@return nil
function tm.playerUI.AddUIText(playerId, id, defaultValue, callback, data) end

---Add a label to the client's mod UI
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:PlayerUI#How_to_display_values)
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@param defaultValue PrintableValue Text of the label. See `PrintableValue` type alias
---@return nil
function tm.playerUI.AddUILabel(playerId, id, defaultValue) end

---Remove an UI element
---@param playerId PlayerID ID of the player for which the UI element will be removed. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias
---@return nil
function tm.playerUI.RemoveUI(playerId, id) end

---Set the value of a client's UI element
---@param playerId PlayerID Player for which the UI element will be created. See `PlayerID` type alias
---@param id UIElementID See `UIElementID` type alias. If `nil`, the element will become the same as creating the element from scratch with a `nil` default value
---@param value PrintableValue New value of the UI element (text shown on the UI element). See `PrintableValue` type alias
---@return nil
function tm.playerUI.SetUIValue(playerId, id, value) end

---Remove all UI elements for a player
---@param playerId PlayerID Player for which the UI element will be cleared. See `PlayerID` type alias
---@return nil
function tm.playerUI.ClearUI(playerId) end

---Adds a subtle message for a specific player
---@param playerId PlayerID ID of the player for which the message will be displayed. See `PlayerID` type alias
---@param header PrintableValue Title of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@param message PrintableValue Content of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@param duration number? Duration of the message in seconds. If `nil`, uses a default duration
---@param spriteAssetName TextureName? Icon of the message. See `TextureName` type alias
---@return SubtleMessageID
function tm.playerUI.AddSubtleMessageForPlayer(playerId, header, message, duration, spriteAssetName) end

---Adds a subtle message for ALL players
---@param header PrintableValue Title of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@param message PrintableValue Content of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@param duration number? Duration of the message in seconds. If `nil`, uses a default duration
---@param spriteAssetName TextureName? Icon of the message. See `TextureName` type alias
---@return SubtleMessageID
function tm.playerUI.AddSubtleMessageForAllPlayers(header, message, duration, spriteAssetName) end

---Removes a subtle message for a player
---@param playerId PlayerID See `PlayerID` type alias
---@param id SubtleMessageID
---@return nil
function tm.playerUI.RemoveSubtleMessageForPlayer(playerId, id) end

---Removes a subtle message for ALL players
---@param id SubtleMessageID
---@return nil
function tm.playerUI.RemoveSubtleMessageForAll(id) end

---Update the header of a subtle message for a player
---@param playerId PlayerID See `PlayerID` type alias
---@param id SubtleMessageID
---@param newHeader PrintableValue New title of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@return nil
function tm.playerUI.SubtleMessageUpdateHeaderForPlayer(playerId, id, newHeader) end

---Update the header of a subtle message for all players
---@param id SubtleMessageID
---@param newHeader PrintableValue New title of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@return nil
function tm.playerUI.SubtleMessageUpdateHeaderForAll(id, newHeader) end

---Update the message of a subtle message
---@param playerId PlayerID See `PlayerID` type alias
---@param id SubtleMessageID
---@param newMessage PrintableValue New content of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@return nil
function tm.playerUI.SubtleMessageUpdateMessageForPlayer(playerId, id, newMessage) end

---Update the message of a subtle message for ALL players
---@param id SubtleMessageID
---@param newMessage PrintableValue New content of the message. Only the first 32 characters will be displayed. See `PrintableValue` type alias
---@return nil
function tm.playerUI.SubtleMessageUpdateMessageForAll(id, newMessage) end

---Registers a function callback to get the world position of the cursor when left mouse button is clicked
---@param playerId PlayerID See `PlayerID` type alias
---@param callback fun(UICallbackData) Function to execute when the button is pressed. Data is inside `UICallbackData.value` as a `string` with the form `"(x, y, z)"`
---@return nil
function tm.playerUI.RegisterMouseDownPositionCallback(playerId, callback) end

---Deregisters a function callback to get the world position of the cursor when left mouse button is clicked
---@param playerId PlayerID See `PlayerID` type alias
---@param callback fun(UICallbackData) Function to remove. The same function object must have been registered with `tm.playerUI.RegisterMouseDownPositionCallback()` first
---@return nil
function tm.playerUI.DeregisterMouseDownPositionCallback(playerId, callback) end

---Show cursor world position in the UI. The value updates automatically
---@return nil
function tm.playerUI.ShowCursorWorldPosition() end

---Hide cursor world position in the UI
---@return nil
function tm.playerUI.HideCursorWorldPosition() end

--#endregion

--------------------- Audio ---------------------

--#region

---Lets you play audio and effect audio
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/219185167/Audio)
---@class ModApiAudio
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

---Returns a list of all playable audio names
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
---Note: letters are case insensitive
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267762/Input#List-of-key-names)
---@alias InputKey "`" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0" | "-" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "[" | "]" | ";" | "'" | "\\" | "," | "." | "/" | "backspace" | "tab" | "enter" | "left shift" | "right shift" | "left control" | "left alt" | "space" | "right alt" | "right control" | "insert" | "home" | "page up" | "delete" | "end" | "page down" | "up" | "down" | "left" | "right" | "numlock" | "[/]" | "[*]" | "[-]" | "[+]" | "[enter]" | "[,]" | "[1]" | "[2]" | "[3]" | "[4]" | "[5]" | "[6]" | "[7]" | "[8]" | "[9]" | "[0]"

---Lets you trigger functions on key press/release by players
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218267762/Input)
---@class ModApiInput
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

---Contains the vector `(0, 0, 0)`
---@type ModVector3
tm.vector3 = { x = 0, y = 0, z = 0 }

---A 3-axis vector (position, rotation, scale, etc.), can store 3 numbers
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
local ModVector3 = {}

---Creates a vector3 from a string. String should be formatted as "(x, y, z)". Example input: "(4.5, 6, 10.8)"
---@param input string
---@return ModVector3
function ModVector3.Create(input) end

---Creates a vector3 with specified values
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@param x number
---@param y number
---@param z number
---@return ModVector3
---@nodiscard
function ModVector3.Create(x, y, z) end

---Creates a vector3 with values defaulted to zero
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Create() end

---Creates a vector3 pointing right (1, 0, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Right() end

---Creates a vector3 pointing left (-1, 0, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Left() end

---Creates a vector3 pointing up (0, 1, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Up() end

---Creates a vector3 pointing down (0, -1, 0)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Down() end

---Creates a vector3 pointing forward (0, 0, 1)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Forward() end

---Creates a vector3 pointing back (0, 0, -1)
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218595371/ModVector3#Creating-ModVector3)
---@return ModVector3
---@nodiscard
function ModVector3.Back() end

---Flips all the signs (can be done with the normal `-` operator)
---@param vector3 ModVector3
---@return ModVector3
---@nodiscard
function ModVector3.op_UnaryNegation(vector3) end

---Adds first and second together (can be done with the normal `+` operator)
---@param first ModVector3
---@param second ModVector3
---@return ModVector3
---@nodiscard
function ModVector3.op_Addition(first, second) end

---Subtracts first and second together (can be done with the normal `-` operator)
---@param first ModVector3
---@param second ModVector3
---@return ModVector3
---@nodiscard
function ModVector3.op_Subtraction(first, second) end

---Multiplies the vector by the scalar (can be done with the normal `*` operator)
---@param vector3 ModVector3
---@param scalar number
---@return ModVector3
---@nodiscard
function ModVector3.op_Multiply(vector3, scalar) end

---Divides the vector by the divisor (can be done with the normal `/` operator)
---@param vector3 ModVector3
---@param divisor number
---@return ModVector3
---@nodiscard
function ModVector3.op_Division(vector3, divisor) end

---Returns true if both vectors are the same, false if not (can be done with the normal `==` operator)
---@param first ModVector3
---@param second ModVector3
---@return boolean
---@nodiscard
function ModVector3.op_Equality(first, second) end

---Returns true if both vectors are the same, false if not (can be done with the normal `==` operator)
---@param otherVector ModVector3
---@return boolean
---@nodiscard
function ModVector3.Equals(otherVector) end

---Returns true if both vectors are not the same, false if not (can be done with the normal `~=` operator)
---@param first ModVector3
---@param second ModVector3
---@return boolean
---@nodiscard
function ModVector3.op_Inequality(first, second) end

---Returns the hash code of the vector
---@return integer
---@nodiscard
function ModVector3.GetHashCode() end

---Returns a formatted string of a vector in the form `(x, y, z)`
---@return string
---@nodiscard
function ModVector3.ToString() end

---Returns a formatted string of a vector in the form `(x, y, z)`
---@return string
---@nodiscard
function ModVector3.toString() end

---Returns the dot product of two vector3
---@param otherVector ModVector3
---@return number
---@nodiscard
function ModVector3.Dot(otherVector) end

---Returns the cross product of two vector3
---@param otherVector ModVector3
---@return ModVector3
---@nodiscard
function ModVector3.Cross(otherVector) end

---Returns the magnitude/length
---@return number
---@nodiscard
function ModVector3.Magnitude() end

---Calculate a position between the points specified by current and target, moving no farther than the distance specified by maxDistanceDelta
---@param vector ModVector3
---@param otherVector ModVector3
---@param maxDistanceDelta number
---@return ModVector3
---@nodiscard
function ModVector3.MoveTowards(vector, otherVector, maxDistanceDelta) end

---Calculates the angle in degrees between the vector from and another vector
---@param vector ModVector3
---@param otherVector ModVector3
---@return number
---@nodiscard
function ModVector3.Angle(vector, otherVector) end

---Returns the distance between the ModVector and another vector
---@param vector ModVector3
---@param otherVector ModVector3
---@return number
---@nodiscard
function ModVector3.Distance(vector, otherVector) end

---Linearly interpolates between two vectors
---@param vector ModVector3
---@param otherVector ModVector3
---@param t number Position in the interpolation (0=vector, 1=otherVector)
---@return ModVector3
---@nodiscard
function ModVector3.Lerp(vector, otherVector, t) end

--#endregion

--------------------- Quaternion ---------------------

--#region

---Contains the quaternion `(0, 0, 0, 0)`
---@type ModQuaternion
tm.quaternion = { x = 0, y = 0, z = 0, w = 0 }

---Quaternion object. Quaternions are for rotations, they get rid of gimbal lock that a vector3 rotation runs into. Quaternions can store 4 numbers
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModQuaternion)
---@class ModQuaternion
---@field x number X value of the quaternion (i coefficient)
---@field y number Y value of the quaternion (j coefficient)
---@field z number Z value of the quaternion (k coefficient)
---@field w number W value of the quaternion (real part)
local ModQuaternion = {}

---Always returns `Trailmakers.Mods.Api.Proxies.ModQuaternion`
---@return string
---@nodiscard
function ModQuaternion.ToString() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModQuaternion`
---@return string
---@nodiscard
function ModQuaternion.toString() end

---Creates a quaternion by manually defining its components
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModQuaternion#Creating_Quaternions)
---@param x number
---@param y number
---@param z number
---@param w number
---@return ModQuaternion
---@nodiscard
function ModQuaternion.Create(x, y, z, w) end

---Creates a quaternion using euler angle components
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModQuaternion#Creating_Quaternions)
---@param x number
---@param y number
---@param z number
---@return ModQuaternion
---@nodiscard
function ModQuaternion.Create(x, y, z) end

---Creates a quaternion using a euler angle vector3
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModQuaternion#Creating_Quaternions)
---@param eulerAngle ModVector3
---@return ModQuaternion
---@nodiscard
function ModQuaternion.Create(eulerAngle) end

---Creates a quaternion using an angle and an axis to rotate around
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModQuaternion#Creating_Quaternions)
---@param angle number
---@param axis ModVector3
---@return ModQuaternion
---@nodiscard
function ModQuaternion.Create(angle, axis) end

---Returns a vector3 representing the euler angles of the quaternion
---@return ModVector3
---@nodiscard
function ModQuaternion.GetEuler() end

---Multiplies two quaternions and returns the result
---@param otherQuaternion ModQuaternion
---@return ModQuaternion
---@nodiscard
function ModQuaternion.Multiply(otherQuaternion) end

---Returns the resulting quaternion from a slerp between two quaternions
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModQuaternion#Working_with_ModQuaternion)
---@param firstQuaternion ModQuaternion
---@param secondQuaternion ModQuaternion
---@param t number Position in the interpolation (0=firstQuaternion, 1=secondQuaternion)
---@return ModQuaternion
---@nodiscard
function ModQuaternion.Slerp(firstQuaternion, secondQuaternion, t) end

--#endregion

--------------------- Callback Data ---------------------

--#region

---Callback data for when user is interacting with UI elements
---@class UICallbackData
---@field playerId PlayerID Gives you the player that interacted with the element. See `PlayerID` type alias
---@field id UIElementID Gives you the ID of the interacted element. See `UIElementID` type alias
---@field type string Gives you the type of the interacted element
---@field value string Gives you the value of the interacted element (text shown for text fields, and a string representation of a vector that can be parsed with `tm.vector3.Create()` for mouse position callbacks)
---@field data any Gives you the data of the interacted element. You pass in this data when registering the UI element's callback
local UICallbackData = {}

---Always returns `Trailmakers.Mods.Api.ModApiPlayerUI+UICallbackData`
---@return string
---@nodiscard
function UICallbackData.ToString() end

---Always returns `Trailmakers.Mods.Api.ModApiPlayerUI+UICallbackData`
---@return string
---@nodiscard
function UICallbackData.toString() end

--#endregion

--------------------- World ---------------------

--#region

---Represents the current world
---@class ModApiWorld
tm.world = {}

---Set time of day (0-100). No effect if time is paused
---@param percentage number
---@return nil
function tm.world.SetTimeOfDay(percentage) end

---Get time of day (0-100)
---@return number
---@nodiscard
function tm.world.GetTimeOfDay() end

---Set if time of day should be paused or not
---@param isPaused boolean
---@return nil
function tm.world.SetPausedTimeOfDay(isPaused) end

---Set the cycle duration (seconds how fast a day goes by) for time of day
---@param duration number
---@return nil
function tm.world.SetCycleDurationTimeOfDay(duration) end

---Returns if the time of day is currently paused
---@return boolean
---@nodiscard
function tm.world.IsTimeOfDayPaused() end

--#endregion

--------------------- Documentation ---------------------

--#region

---Generates official Trailmakers Mods API Lua Docs
---@return string
---@nodiscard
function tm.GetDocs() end

--#endregion

--------------------- ModGameObject ---------------------

--#region

---GameObjects in the game environment
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModGameObject)
---@class ModGameObject
local ModGameObject = {}

---Despawns the object. This can not be done on players
---@return nil
function ModGameObject.Despawn() end

---Returns the GameObject's Transform
---@return ModTransform
---@nodiscard
function ModGameObject.GetTransform() end

---Sets visibility of the GameObject
---@param isVisible boolean
---@return nil
function ModGameObject.SetIsVisible(isVisible) end

---Gets the visibility of the GameObject
---@return boolean
---@nodiscard
function ModGameObject.GetIsVisible() end

---Returns true if the GameObject or any of its children are rigidbodies
---@return boolean
---@nodiscard
function ModGameObject.GetIsRigidbody() end

---Sets the GameObject's and its children's rigidbodies to be static or not
---@param isStatic boolean
---@return nil
function ModGameObject.SetIsStatic(isStatic) end

---Returns true if the GameObject, and all of its children, are static
---@return boolean
---@nodiscard
function ModGameObject.GetIsStatic() end

---Determines whether the GameObject lets other GameObjects pass through its colliders or not
---@param isTrigger boolean
---@return nil
function ModGameObject.SetIsTrigger(isTrigger) end

---Returns true if the GameObject exists
---@return boolean
---@nodiscard
function ModGameObject.Exists() end

---Always returns `PFB_ModGameObject [Server] (ModGameObject_Server)`
---@return string
---@nodiscard
function ModGameObject.ToString() end

---Always returns `PFB_ModGameObject [Server] (ModGameObject_Server)`
---@return string
---@nodiscard
function ModGameObject.toString() end

---Sets the texture on the GameObject (Custom meshes only)
---@param textureName TextureName See `TextureName` type alias
---@return nil
function ModGameObject.SetTexture(textureName) end

---Add a force to the GameObject as an impulse
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddForceImpulse(x, y, z) end

---Add a force to the GameObject as a force
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddForce(x, y, z) end

---Add a force to the GameObject as an Acceleration
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddForceAcceleration(x, y, z) end

---Add a force to the GameObject as a VelocityChange
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddForceVelocityChange(x, y, z) end

---Add a torque to the GameObject as an impulse
---
---[View documents](See https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddTorqueImpulse(x, y, z) end

---Add a torque to the GameObject as a force
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddTorqueForce(x, y, z) end

---Add a torque to the GameObject as an Acceleration
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddTorqueAcceleration(x, y, z) end

---Add a torque to the GameObject as a VelocityChange
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModGameObject.AddTorqueVelocityChange(x, y, z) end

--#endregion

--------------------- ModTransform ---------------------

--#region

---Represents a Transform (position, rotation, scale) of a GameObject
---
---[View documents](https://trailmakers.wiki.gg/wiki/Modding:ModTransform)
---@class ModTransform
local ModTransform = {}

---Sets the position of the Transform (world space)
---@param position ModVector3
---@return nil
function ModTransform.SetPosition(position) end

---Sets the position of the Transform (world space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetPosition(x, y, z) end

---Gets the position of the Transform (world space)
---@return ModVector3
---@nodiscard
function ModTransform.GetPosition() end

---Sets the rotation of the Transform (world space)
---@param rotation ModVector3
---@return nil
function ModTransform.SetRotation(rotation) end

---Sets the rotation of the Transform (world space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetRotation(x, y, z) end

---Gets the rotation of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModTransform.GetRotation() end

---Sets the rotation of the Transform using a quaternion (world space)
---@param rotation ModQuaternion
---@return nil
function ModTransform.SetRotation(rotation) end

---Gets the rotation quaternions of the Transform (world space)
---@return ModQuaternion
---@nodiscard
function ModTransform.GetRotationQuaternion() end

---Sets the scale of the Transform (local space). Setting a non-uniform scale may, among other things, break the objects' physics
---@param scale ModVector3
---@return nil
function ModTransform.SetScale(scale) end

---Sets the scale of the Transform (local space). Setting a non-uniform scale may, among other things, break the objects' physics
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetScale(x, y, z) end

---Sets the scale of the Transform (local space)
---@param scale number
---@return nil
function ModTransform.SetScale(scale) end

---Gets the scale of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModTransform.GetScale() end

---Returns the point's local position (world space). Adds the current pos with input vector
---@param point ModVector3
---@return ModVector3
---@nodiscard
function ModTransform.TransformPoint(point) end

---Returns the direction's world space direction
---@param direction ModVector3
---@return ModVector3
---@nodiscard
function ModTransform.TransformDirection(direction) end

---Always returns `Trailmakers.Mods.Api.Proxies.ModTransform`
---@return string
---@nodiscard
function ModTransform.ToString() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModTransform`
---@return string
---@nodiscard
function ModTransform.toString() end

---Returns a normalized vector Forward (world space)
---@return ModVector3
---@nodiscard
function ModTransform.Forward() end

---Returns a normalized vector Back (world space)
---@return ModVector3
---@nodiscard
function ModTransform.Back() end

---Returns a normalized vector Left (world space)
---@return ModVector3
---@nodiscard
function ModTransform.Left() end

---Returns a normalized vector Right (world space)
---@return ModVector3
---@nodiscard
function ModTransform.Right() end

---Gets the position of the Transform (world space)
---@return ModVector3
---@nodiscard
function ModTransform.GetPositionWorld() end

---Gets the euler angles rotation of the Transform (world space)
---@return ModVector3
---@nodiscard
function ModTransform.GetEulerAnglesWorld() end

---Gets the quaternion rotation of the Transform (world space)
---@return ModQuaternion
---@nodiscard
function ModTransform.GetRotationWorld() end

---Sets the position of the Transform (world space)
---@param position ModVector3
---@return nil
function ModTransform.SetPositionWorld(position) end

---Sets the position of the Transform (world space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetPositionWorld(x, y, z) end

---Sets the euler angles rotation of the Transform (world space)
---@param eulerAngles ModVector3
---@return nil
function ModTransform.SetEulerAnglesWorld(eulerAngles) end

---Sets the euler angles rotation of the Transform (world space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetEulerAnglesWorld(x, y, z) end

---Sets the quaternion rotation of the Transform (world space)
---@param rotation ModQuaternion
---@return nil
function ModTransform.SetRotationWorld(rotation) end

---Sets the quaternion rotation of the Transform (world space)
---@param x number
---@param y number
---@param z number
---@param w number
---@return nil
function ModTransform.SetRotationWorld(x, y, z, w) end

---Gets the position of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModTransform.GetPositionLocal() end

---Gets the euler angles rotation of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModTransform.GetEulerAnglesLocal() end

---Gets the quaternion rotation of the Transform (local space)
---@return ModQuaternion
---@nodiscard
function ModTransform.GetRotationLocal() end

---Gets the scale of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModTransform.GetScaleLocal() end

---Sets the position of the Transform (local space)
---@param position ModVector3
---@return nil
function ModTransform.SetPositionLocal(position) end

---Sets the position of the Transform (local space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetPositionLocal(x, y, z) end

---Sets the euler angles rotation of the Transform (local space)
---@param eulerAngles ModVector3
---@return nil
function ModTransform.SetEulerAnglesLocal(eulerAngles) end

---Sets the euler angles rotation of the Transform (local space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetEulerAnglesLocal(x, y, z) end

---Sets the quaternion rotation of the Transform (local space)
---@param rotation ModQuaternion
---@return nil
function ModTransform.SetRotationLocal(rotation) end

---Sets the quaternion rotation of the Transform (local space)
---@param x number
---@param y number
---@param z number
---@param w number
---@return nil
function ModTransform.SetRotationLocal(x, y, z, w) end

---Sets the scale of the Transform (local space)
---@param scale ModVector3
---@return nil
function ModTransform.SetScaleLocal(scale) end

---Sets the scale of the Transform (local space)
---@param x number
---@param y number
---@param z number
---@return nil
function ModTransform.SetScaleLocal(x, y, z) end

--#endregion

--------------------- ModBlock ---------------------

--#region

---Represents a block in a structure
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218562585/ModBlock)
---@class ModBlock
local ModBlock = {}

---Gets the position of the transform (world space)
---@return ModVector3
---@nodiscard
function ModBlock.GetPosition() end

---Gets the rotation of the transform (local space)
---@return ModVector3
---@nodiscard
function ModBlock.GetRotation() end

---Gets the scale of the transform (local space)
---@return ModVector3
---@nodiscard
function ModBlock.GetScale() end

---Returns the point's position in world space (Adds the current pos with input vector)
---@param point ModVector3
---@return ModVector3
---@nodiscard
function ModBlock.TransformPoint(point) end

---Returns the direction's world space direction
---@param direction ModVector3
---@return ModVector3
---@nodiscard
function ModBlock.TransformDirection(direction) end

---Returns a normalized vector Forward in world space
---@return ModVector3
---@nodiscard
function ModBlock.Forward() end

---Returns a normalized vector Back in world space
---@return ModVector3
---@nodiscard
function ModBlock.Back() end

---Returns a normalized vector Left in world space
---@return ModVector3
---@nodiscard
function ModBlock.Left() end

---Returns a normalized vector Right in world space
---@return ModVector3
---@nodiscard
function ModBlock.Right() end

---[In buildmode only] Set the block's primary color
---
---[DEPRECATED USE `.SetPrimaryColor()` INSTEAD]
---@deprecated
---@param r number
---@param g number
---@param b number
---@return nil
function ModBlock.SetColor(r, g, b) end

---[In buildmode only] Set the block's primary color
---@param r number
---@param g number
---@param b number
---@return nil
function ModBlock.SetPrimaryColor(r, g, b) end

---[In buildmode only] Set the block's secondary color
---@param r number
---@param g number
---@param b number
---@return nil
function ModBlock.SetSecondaryColor(r, g, b) end

---[In buildmode only] Set the block's mass. Units are `5kg`
---@param mass number
---@return nil
function ModBlock.SetMass(mass) end

---Get the block's mass. Units are `5kg`
---@return number
---@nodiscard
function ModBlock.GetMass() end

---Get the block's primary color
---@return ModColor
---@nodiscard
function ModBlock.GetPrimaryColor() end

---Get the block's secondary color
---@return ModColor
---@nodiscard
function ModBlock.GetSecondaryColor() end

---[In buildmode only] Set the block's buoyancy
---@param buoyancy number
---@return nil
function ModBlock.SetBuoyancy(buoyancy) end

---Get the block's buoyancy
---@return number
---@nodiscard
function ModBlock.GetBuoyancy() end

---Set the block's health
---@param hp number
---@return nil
function ModBlock.SetHealth(hp) end

---Get the block's start health
---@return number
---@nodiscard
function ModBlock.GetStartHealth() end

---Get the block's current health
---@return number
---@nodiscard
function ModBlock.GetCurrentHealth() end

---Get the name of the block's type
---@return string
---@nodiscard
function ModBlock.GetName() end

---Set the drag value in all directions, front, back, up, down, left, right
---@param f number
---@param b number
---@param u number
---@param d number
---@param l number
---@param r number
---@return nil
function ModBlock.SetDragAll(f, b, u, d, l, r) end

---Add a force to the given block as an impulse. Units are `5kg * m/s²`
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModBlock.AddForce(x, y, z) end

---Add a torque to the given block as an impulse
---
---[View documents](See https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModBlock.AddTorque(x, y, z) end

---Sets engine power (only works on engine blocks)
---@param power number
---@return nil
function ModBlock.SetEnginePower(power) end

---Gets engine power (only works on engine blocks)
---@return number
---@nodiscard
function ModBlock.GetEnginePower() end

---Sets jet power (only works on jet blocks)
---@param power number
---@return nil
function ModBlock.SetJetPower(power) end

---Gets jet power (only works on jet blocks)
---@return number
---@nodiscard
function ModBlock.GetJetPower() end

---Sets propeller power (only works on propeller blocks)
---@param power number
---@return nil
function ModBlock.SetPropellerPower(power) end

---Gets propeller power (only works on propeller blocks)
---@return number
---@nodiscard
function ModBlock.GetPropellerPower() end

---Sets gyro power (only works on gyro blocks)
---@param power number
---@return nil
function ModBlock.SetGyroPower(power) end

---Gets gyro power (only works on gyro blocks)
---@return number
---@nodiscard
function ModBlock.GetGyroPower() end

---Whether a block is an Engine block or not
---@return boolean
---@nodiscard
function ModBlock.IsEngineBlock() end

---Whether a block is an Jet block or not
---@return boolean
---@nodiscard
function ModBlock.IsJetBlock() end

---Whether a block is an Propeller block or not
---@return boolean
---@nodiscard
function ModBlock.IsPropellerBlock() end

---Whether a block is a seat block or not
---@return boolean
---@nodiscard
function ModBlock.IsPlayerSeatBlock() end

---Whether a block is a gyro block or not
---@return boolean
---@nodiscard
function ModBlock.IsGyroBlock() end

---Returns true if the block exists. Keep in mind that when you repair your structure, your destroyed blocks will be replaced with different ones, making the old ones useless
---@return boolean
---@nodiscard
function ModBlock.Exists() end

---Returns the structure a block belongs to
---@return ModStructure
---@nodiscard
function ModBlock.GetStructure() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModBlock`
---@return string
---@nodiscard
function ModBlock.ToString() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModBlock`
---@return string
---@nodiscard
function ModBlock.toString() end

--#endregion

--------------------- ModStructure ---------------------

--#region

---Object representing a creation in the game
---
---[View documents](https://flashbulb.atlassian.net/wiki/spaces/TMMOD/pages/218103875/ModStructure)
---@class ModStructure
local ModStructure = {}

---Gets the position of the Transform (world space)
---@return ModVector3
---@nodiscard
function ModStructure.GetPosition() end

---Gets the rotation of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModStructure.GetRotation() end

---Gets the scale of the Transform (local space)
---@return ModVector3
---@nodiscard
function ModStructure.GetScale() end

---Returns the point's position in world space (Adds the current pos with input vector)
---@param point ModVector3
---@return ModVector3
---@nodiscard
function ModStructure.TransformPoint(point) end

---Returns the direction's world space direction
---@param direction ModVector3
---@return ModVector3
---@nodiscard
function ModStructure.TransformDirection(direction) end

---Returns a normalized vector Forward in world space
---@return ModVector3
---@nodiscard
function ModStructure.Forward() end

---Returns a normalized vector Back in world space
---@return ModVector3
---@nodiscard
function ModStructure.Back() end

---Returns a normalized vector Left in world space
---@return ModVector3
---@nodiscard
function ModStructure.Left() end

---Returns a normalized vector Right in world space
---@return ModVector3
---@nodiscard
function ModStructure.Right() end

---Destroy the structure
---@return nil
function ModStructure.Destroy() end

---Gets all blocks in structure
---@return ModBlock[]
---@nodiscard
function ModStructure.GetBlocks() end

---Add a force to the given structure as an impulse. Units are `5kg * m/s²`
---
---[View documents](https://docs.unity3d.com/ScriptReference/ForceMode.html)
---@param x number
---@param y number
---@param z number
---@return nil
function ModStructure.AddForce(x, y, z) end

---Always returns `Trailmakers.Mods.Api.Proxies.ModStructure`
---@return string
---@nodiscard
function ModStructure.ToString() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModStructure`
---@return string
---@nodiscard
function ModStructure.toString() end

---Gets the velocity of the player inside of the structure
---@return ModVector3
---@nodiscard
function ModStructure.GetVelocity() end

---Gets the speed of the player inside of the structure. Units are `m/s`
---@return number
---@nodiscard
function ModStructure.GetSpeed() end

---Get player index who owns this structure. Returns `-1` if player is gone
---@return PlayerID | -1 # See `PlayerID` type alias
---@nodiscard
function ModStructure.GetOwnedByPlayerId() end

---Returns the number of power cores of the structure
---@return number
---@nodiscard
function ModStructure.GetPowerCores() end

---Despawn the structure. Similar to `ModStructure.Destroy()` but the creation is removed instantly without playing the destruction animation
---@return nil
function ModStructure.Dispose() end

--#endregion

--------------------- RayCastHit ---------------------

--#region

---Object containing the information of a raycast hit
---@class ModRaycastHit
local ModRaycastHit = {}

---Returns if the raycast hit something
---@return boolean
---@nodiscard
function ModRaycastHit.DidHit() end

---Returns the hit normal
---@return ModVector3
---@nodiscard
function ModRaycastHit.GetHitNormal() end

---Returns the hit position
---@return ModVector3
---@nodiscard
function ModRaycastHit.GetHitPosition() end

---Returns the distance to the hit
---@return number
---@nodiscard
function ModRaycastHit.GetHitDistance() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModRaycastHit`
---@return string
---@nodiscard
function ModRaycastHit.ToString() end

---Always returns `Trailmakers.Mods.Api.Proxies.ModRaycastHit`
---@return string
---@nodiscard
function ModRaycastHit.toString() end

--#endregion

--------------------- Color ---------------------

--#region

---Represents a color
---@class ModColor
local ModColor = {}

---Returns a formatted string of a color in the form `RGBA(r, g, b, a)`
---@return string
---@nodiscard
function ModColor.ToString() end

---Returns a formatted string of a color in the form `RGBA(r, g, b, a)`
---@return string
---@nodiscard
function ModColor.toString() end

---Returns the red channel value of the color
---@return number
---@nodiscard
function ModColor.R() end

---Returns the green channel value of the color
---@return number
---@nodiscard
function ModColor.G() end

---Returns the blue channel value of the color
---@return number
---@nodiscard
function ModColor.B() end

--#endregion
