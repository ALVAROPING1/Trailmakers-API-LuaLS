---@meta
-- Original document by Ridicolas
-- Updated to include new functions and fully work with LuaLS by ALVAROPING1
-- Further updated by Vajdani
-- Improved formatting, fixed types, added missing descriptions to parameters, and converted into an addon to remove disabled lua modules by ALVAROPING1

--- Modding API Module
tm = {}

--------------------- OS ---------------------

--#region

--- Everything to do with files and general mod systems
tm.os = {}

--- Read all text of a file in the mods static data directory. Files in the static data directory can only be read and NOT written to
---@param path string Relative file path
---@return string Content Content of the file
---@nodiscard
function tm.os.ReadAllText_Static(path) end

--- Read all text of a file in the mods dynamic data directory. Files in the dynamic data directory can be both read and written to. The dynamic data directory will NOT be uploaded to the steam workshop when you upload your mod. When a mod is run through the steam workshop, the dynamic data, unlike static data, is not located in the steam workshop directory but is located in the steam user data directory instead
---@param path string Relative file path
---@return string Content Content of the file
---@nodiscard
function tm.os.ReadAllText_Dynamic(path) end

--- Create or overwrite a file in the mods dynamic data directory. Files in the dynamic data directory can be both read and written to. The dynamic data directory will NOT be uploaded to the steam workshop when you upload your mod. When a mod is run through the steam workshop, the dynamic data, unlike static data, is not located in the steam workshop directory but is located in the steam user data directory instead
---@param path string Relative file path
---@param stringToWrite string Data to write in the file
---@return nil
function tm.os.WriteAllText_Dynamic(path, stringToWrite) end

--- Emit a log message
---@param message string | number | boolean | nil | ModVector3 Message to log
---@return nil
function tm.os.Log(message) end

--- Get time game has been playing in seconds. Doesn't update within a single mod update cycle
---@return number
---@nodiscard
function tm.os.GetTime() end

--- Get the time since last update
---@return number
---@nodiscard
function tm.os.GetModDeltaTime() end

--- Determines how often the mod gets updated. `1/60` means 60 times per second. Can't update faster than the game (maximum is 60 times per second)
---@param targetDeltaTime number
---@return nil
function tm.os.SetModTargetDeltaTime(targetDeltaTime) end

--- Returns the target delta time for the mod
---@return number
---@nodiscard
function tm.os.GetModTargetDeltaTime() end

--#endregion

--------------------- Physics ---------------------

--#region

--- Everything that can effect physics, like gravity, spawning objects, and importing meshes
tm.physics = {}

--- Set the physics timescale relative to the default speed (acts as a multiplier of the normal time speed)
---@param speed number
---@return nil
function tm.physics.SetTimeScale(speed) end

--- Get the physics timescale relative to the default speed (acts as a multiplier of the normal time speed)
---@return number
---@nodiscard
function tm.physics.GetTimeScale() end

--- Set the physics gravity in the down direction. Units are `m/s²`, default is `14 m/s²`
---@param strength number
---@return nil
function tm.physics.SetGravity(strength) end

--- Set the physics gravity as per the provided vector. Units are `m/s²`, default is `(0, -14, 0) m/s²`
---@param gravity ModVector3
---@return nil
function tm.physics.SetGravity(gravity) end

--- Get the physics gravity. Units are `m/s²`, default is `(0, 14, 0) m/s²`
---@return ModVector3
---@nodiscard
function tm.physics.GetGravity() end

---@alias Spawnable "PFB_SpikyCanyon_1" | "PFB_PlateCanyon_01" | "PFB_CharredBush" | "PFB_CharredStump" | "PFB_CharredTree" | "PFB_CharredTree2" | "PFB_GoldNugget_Small" | "PFB_NuggetThief" | "PFB_Runner" | "PFB_Runner-Monkey" | "PFB_Whale" | "PFB_PoisonCloud_Explosion" | "PFB_KungfuFlaglol" | "PFB_Cliff_Bottom_Desert" | "PFB_Cliff_Bottom_Desert_Grass" | "PFB_Cliff_Bottom_Mud" | "PFB_Cliff_Bottom_Mud_Grass" | "PFB_Cliff_Med_Desert" | "PFB_Cliff_Med_Desert_Grass" | "PFB_Cliff_Med_Mud" | "PFB_Cliff_Med_Mud_Grass" | "PFB_Cliff_Top_Desert" | "PFB_Cliff_Top_Desert_Grass" | "PFB_Cliff_Top_Desert_Trees" | "PFB_Cliff_Top_Mud" | "PFB_Cliff_Top_Mud_Grass" | "PFB_Cliff_Top_Mud_Trees" | "PFB_Rock_Detail_Bush" | "PFB_Rock_Detail_Med_Desert_00" | "PFB_Rock_Detail_Med_Desert_00_Grass" | "PFB_Rock_Detail_Med_Desert_01" | "PFB_Rock_Detail_Med_Desert_01_Grass" | "PFB_Rock_Detail_Med_Mud_00" | "PFB_Rock_Detail_Med_Mud_00_Grass" | "PFB_Rock_Detail_Med_Mud_01" | "PFB_Rock_Detail_Med_Mud_01_Grass" | "PFB_Rock_Detail_Med_Mud_01Test" | "PFB_Rock_Detail_Top_Desert" | "PFB_Rock_Detail_Top_Mud" | "PFB_Rock_Detail_Top_Mud1" | "PFB_Rock_Desert_Arc" | "PFB_Rock_Desert_Med" | "PFB_Rock_Desert_VerySmall" | "PFB_Rock_Mud_Large" | "PFB_Palm1" | "PFB_Palm2" | "PFB_PalmFern_Big" | "PFB_PalmFern_Medium" | "PFB_BulkyPineTree_FBX" | "PFB_SlenderPineTree-Final_FBX" | "PFB_Tall__Lush_FatPine_1" | "PFB_Tall__Pruny_SlenderPine_2" | "PFB_Tall__Pruny_SlenderPine_Impostor" | "PFB_Tall_SlenderPine_1" | "PFB_BlueBerryShrub_01" | "PFB_BlueBerryShrub_02_Noco" | "PFB_BasketBallHoop" | "PFB_SquareCannon" | "PFB_Catapult" | "PFB_CatapultStraight" | "PFB_Grinderv2" | "PFB_Hammer" | "PFB_Heightjump" | "PFB_Pusher" | "PFB_Pushersx5" | "PFB_Pushersx5_Below" | "PFB_Spinner" | "PFB_Tube3-NoHoles2" | "PFB_ArkCollected" | "PFB_BigWindMill" | "PFB_Container_Blue" | "PFB_Container_Blue_Dynamic" | "PFB_Container_Orange" | "PFB_Container_Orange_Dynamic" | "PFB_Container_Red" | "PFB_Container_Red_Dynamic" | "PFB_CoralReef1" | "PFB_CoralReef2" | "PFB_CoralReef3" | "PFB_ShipWreck" | "PFB_WavyBottomPlantGreenBubbleWeed" | "PFB_WavyBottomPlantGreenCactus" | "PFB_WavyBottomPlantGreenLadder" | "PFB_WavyBottomPlantGreenLeafy" | "PFB_WavyBottomPlantGreenRedGrass" | "PFB_WavyBottomPlantPurpleSquareEnd" | "PFB_WavyBottomPlantRedBubbleEnds" | "PFB_WavyBottomPlantRedShredded" | "PFB_TreasureBeacon" | "PFB_RacingCheckPoint" | "PFB_RacingCheckPoint_Halfcircle" | "PFB_PropWheelStack" | "PFB_RacePropTyre-Blue" | "PFB_RacePropTyre-Blue_LOWRES" | "PFB_RacePropTyre-Yellow" | "PFB_ChillbitchRoad" | "PFB_RingofFire" | "PFB_Scaffolding_Section" | "PFB_FlagTwin" | "PFB_Windmill3" | "PFB_ChaserAI" | "PFB_ChaserAIBall" | "PFB_ChaserAIDead" | "PFB_ExplosiveCrate" | "PFB_IronCrate" | "PFB_PowerCoreCrate" | "PFB_WoodCrate" | "PFB_WoodCrate_Not_Empty" | "PFB_Explosion_Large" | "PFB_Explosion_Medium" | "PFB_Explosion_Micro" | "PFB_Explosion_SeatDeath" | "PFB_Explosion_Small" | "PFB_Explosion_XL" | "PFB_Dispensable-BeachBall" | "PFB_Dispensable-ConcreteWall" | "PFB_Dispensable-Cone" | "PFB_Dispensable-MetalCrate" | "PFB_Dispensable-Mine" | "PFB_Dispensable-Present" | "PFB_Dispensable-Torpedo" | "PFB_DispensableBall" | "PFB_DispensableBoulder" | "PFB_DispensableCube" | "PFB_DispensableSnowball" | "PFB_DispensableSphere" | "PFB_Barrel" | "PFB_ExplosiveBarrel" | "PFB_MagneticCube" | "PFB_ChallengeLimitedBlockTag" | "PFB_ChallengeCheckpoint" | "PFB_ChallengeCheckpoint_HalfCircle" | "PFB_ChallengeCheckpoint_Round" | "PFB_ChallengeCheckPointEnd_Flat" | "PFB_ChallengeCheckpointEnd_Round" | "PFB_ChallengeCheckPointStart" | "PFB_ChallengeCheckpoint_Expedition2" | "PFB_ChallengeCheckpoint_Floating_Expedition2" | "PFB_ChallengeCheckpoint_Flying_Expedition2" | "PFB_ChallengeCheckPointEnd_Floating_Expedition2" | "PFB_ChallengeSignUpExpedition" | "PFB_ChallengeSignUpExpedition_Floating_Expedition2" | "PFB_KingOfTheHill_CrownPickup" | "PFB_Beacon" | "PFB_BlockHunt" | "PFB_EpicJumpSequence" | "PFB_GoldPickup" | "PFB_TimeOfDayTrigger" | "PFB_Waypoint" | "PFB_WindBoxTrigger" | "PFB_MovePuzzleBall" | "PFB_MovePuzzleBounds" | "PFB_MovePuzzleStart" | "PFB_MovePuzzleTarget" | "PFB_Cactus_Ball" | "PFB_Cactus_Bush" | "PFB_Cactus_Bush_Populate" | "PFB_Cactus_Mini" | "PFB_Cactus_Mushroom_Tree" | "PFB_Cactus_Small" | "PFB_Cactus_Star_Plant" | "PFB_Cactus_Tree" | "PFB_SmallRock_Spawner_01" | "PFB_Desert_Bush_Fir" | "PFB_Mine" | "PFB_Bushy" | "PFB_INS_Savannah_Bush_Small" | "PFB_INS_Savannah_Tree_Short" | "PFB_INS_Savannah_Tree_Short_brown" | "PFB_INS_Savannah_Tree_Short_Purple" | "PFB_INS_Savannah_Tree_Short_Yellow" | "PFB_INS_Savannah_Tree_Tall" | "PFB_INS_Savannah_Tree_Tall_Brown" | "PFB_INS_Savannah_Tree_Tall_Purple" | "PFB_INS_Savannah_Tree_Tall_Yellow" | "PFB_Pine_Bush" | "PFB_Pine_Bush_TEST" | "PFB_Savannah_Tree" | "PFB_SalvageItem_Ball" | "PFB_SalvageItem_Ball_L" | "PFB_SalvageItem_Ball_M" | "PFB_SalvageItem_Compound_3" | "PFB_SalvageItem_Compound_Variant_1" | "PFB_SalvageItem_Compound_Variant_2" | "PFB_SalvageItem_Explosive" | "PFB_SalvageItem_Explosive_M" | "PFB_SalvageItem_L Variant" | "PFB_SalvageItem_M Variant" | "PFB_SalvageItem_Small" | "PFB_SalvageItem_Timed" | "PFB_SalvageItem_XL Variant" | "PFB_TimeOfDay_Trailmakers" | "PFB_TimeOfDay_Trailmakers_Exploration" | "PFB_TimeOfDay_TrailmakersSpacey" | "PFB_TestCollisionTimeline" | "PFB_Whale" | "PFB_Tooth_Big_01" | "PFB_Tooth_Big_02" | "PFB_Tooth_Big_03" | "PFB_Tooth_Small_01" | "PFB_Tooth_Small_02" | "PFB_Tooth_Small_03" | "PFB_Mushroom_5m_01" | "PFB_Mushroom_5m_02" | "PFB_Mushroom_5m_03" | "PFB_Mushroom_30m_01" | "PFB_Mushroom_30m_02" | "PFB_Mushroom_30m_03" | "PFB_Mushroom_60m_01" | "PFB_Mushroom_60m_02" | "PFB_Mushroom_60m_03" | "PFB_IceHarbour_Pipe" | "PFB_IceHarbour_Pipe_and_BlueLights" | "PFB_IceHarbour_Pipe_and_YellowLights" | "PFB_IceHarbour_Pipe_Corner" | "PFB_IceHarbour_Pipe_Corner_and_BlueLights" | "PFB_IceHarbour_Pipe_Corner_and_YellowLights" | "PFB_IceHarbour_Pipe_GroundPiece" | "PFB_IceHarbour_Pipe_GroundPiece_and_BlueLights" | "PFB_IceHarbour_Pipe_GroundPiece_and_YellowLights" | "PFB_IceHarbour_Antenna_01" | "PFB_IceHarbour_Antenna_02" | "PFB_IceHarbour_Antenna_03" | "PFB_IceHarbour_Base" | "PFB_IceHarbour_Platform" | "PFB_IceHarbour_Platform_End_01" | "PFB_IceHarbour_Platform_End_02" | "PFB_IceHarbour_Platform_End_03" | "PFB_IceHarbour_Platform_End_04" | "PFB_IceHarbour_Platform_Pole" | "PFB_IceHarbour_Platform_Stairs_01" | "PFB_IceHarbour_Platform_Stairs_02" | "PFB_IceHarbour_Ramp_01" | "PFB_IceHarbour_Ramp_02" | "PFB_Iceberg_01" | "PFB_IceCaveLidLong" | "PFB_IceCaveLidRound" | "PFB_IceCliffFlat_02" | "PFB_IceCliffFlat_03" | "PFB_LongCaveICE" | "PFB_coralAnemoneA01" | "PFB_coralAnemoneA02" | "PFB_coralAnemoneB01" | "PFB_coralAnemoneB02" | "PFB_coralEggA01" | "PFB_coralEggA02" | "PFB_coralEggB01" | "PFB_coralEggB02" | "PFB_coralFormation01" | "PFB_coralFormation02" | "PFB_coralRockA01" | "PFB_coralRockA02" | "PFB_coralRockB01" | "PFB_coralRockB02" | "PFB_coralRockC01" | "PFB_coralRockC02" | "PFB_coralRockD01" | "PFB_coralRockD02" | "PFB_coralRockE01" | "PFB_coralRockE02" | "PFB_coralRockPlatform01" | "PFB_coralRockPlatform02" | "PFB_coralRockPlatform03" | "PFB_coralRockPlatform04" | "PFB_coralRockPlatform05" | "PFB_coralRockPlatform06" | "PFB_coralTuberA01" | "PFB_coralTuberA02" | "PFB_GiantPearl" | "PFB_VolcanoHarbour_Base" | "PFB_VolcanoHarbour_Chain_01" | "PFB_VolcanoHarbour_Chain_02" | "PFB_VolcanoHarbour_Mooring_01" | "PFB_VolcanoHarbour_Mooring_02" | "PFB_VolcanoHarbour_Rope" | "PFB_VolcanoHarbour_Tire" | "PFB_VolcanoHarbour_Tire_Dynamic" | "PFB_VolcanoHarbour_WoodPlank_01" | "PFB_VolcanoHarbour_WoodPlank_02" | "PFB_cliffs01_volcano" | "PFB_cliffs02_volcano" | "PFB_cliffs03_volcano" | "PFB_spikes01_volcano" | "PFB_StoneCliff_01" | "PFB_StoneCliff_04" | "PFB_StoneCliff_FlatTopAngle" | "PFB_StoneCliffFlat_01" | "PFB_StoneCliffFlat_02" | "PFB_StoneCliffFlat_03" | "PFB_SimpleStoneHighSeas" | "PFB_StoneWall_Large" | "PFB_AlgarveCliff_Tiki" | "PFB_AlgarveCliff_Tiki_2" | "PFB_AlgarveCliff_Tiki_3" | "PFB_Cliff_Bottom_Tiki" | "PFB_Rock_Med_Tiki" | "PFB_Rock_VerySmall_Tiki" | "PFB_SkullCliff" | "PFB_WoodPlank_01" | "PFB_WoodPlank_04" | "PFB_WoodPlank_Dark_01" | "PFB_WoodPlank_Dark_04" | "PFB_WoodPole_01" | "PFB_WoodPole_Dark_01" | "PFB_Bones_Flipper" | "PFB_Bones_GiantRibcage" | "PFB_Bones_Rib" | "PFB_Bones_Skeleton_01" | "PFB_Bones_Skeleton_02" | "PFB_Bones_Skeleton_01" | "PFB_Bones_Skeleton_02" | "PFB_Bones_Spine_01" | "PFB_Bones_Spine_02" | "PFB_vikingStatue_01" | "PFB_VikingHarbour_HelmetSkull" | "PFB_VikingHarbour_Shield_01" | "PFB_VikingHarbour_Shield_02" | "PFB_VikingHarbour_Shield_03" | "PFB_VikingHarbour_Shield_04" | "PFB_VikingHarbour_Gate" | "PFB_VikingHarbour" | "PFB_ShipWreck" | "PFB_HS_Clam" | "PFB_HS_ClamClosed" | "PFB_VolcanoHarbour_Silo_01_Blue" | "PFB_VolcanoHarbour_Silo_01_Green" | "PFB_VolcanoHarbour_Silo_01_Red" | "PFB_VolcanoHarbour_Silo_02_Blue" | "PFB_VolcanoHarbour_Silo_02_Green" | "PFB_VolcanoHarbour_Silo_02_Red" | "PFB_Lava" | "PFB_Lava_Underwater" | "PFB_WoodPole" | "PFB_WoodPole_Dark" | "PFB_GoldChest" | "PFB_SpaceShipHighseas" | "PFB_GiantSpaceCraftRuin" | "PFB_SpaceWreckage2" | "PFB_Carrier" | "PFB_BearingBeams" | "PFB_BearingBeamSingle" | "PFB_Modular90DegreeTurn" | "PFB_ModularBigSlope" | "PFB_ModularPillar" | "PFB_ModularSlopeUp-Angled" | "PFB_ModularSlopeUp" | "PFB_ModularSlopeUpEnd" | "PFB_ModularSmallSlope" | "PFB_ModularStraightRoad_Guards-2x" | "PFB_ModularStraightRoad_Guards" | "PFB_ModularStraightRoad_NoGuards-2x" | "PFB_ModularStraightRoad_NoGuards" | "PFB_ModularT-Cross" | "PFB_SmallBeamSingle" | "PFB_Modular_90DegreeWall" | "PFB_Modular_90DegreeWallMIRROR" | "PFB_Modular_BigWall" | "PFB_Modular_Entrance" | "PFB_Modular_PillarLight" | "PFB_Modular_Ramp" | "PFB_Modular_SmallWall" | "PFB_SpinnerArena" | "PFB_CrashedMayorPlane" | "PFB_CrashedPlaneWing" | "PFB_Palm_1" | "PFB_Palm_2" | "PFB_TropicalFlower_1" | "PFB_TropicalFlower_2" | "PFB_TropicalFlower_3" | "PFB_TropicalFlower_4" | "PFB_BoneRing" | "PFB_GiantBone_1" | "PFB_GiantBone_2" | "PFB_GiantBone_3" | "PFB_Pike_Cliff_Med" | "PFB_Pike_Cliff_1" | "PFB_Pike_Cliff_2" | "PFB_Pike_Cliff_3" | "PFB_Pike_Cliff_4" | "PFB_Pike_Cliff_5" | "PFB_Pike_Floating" | "PFB_Pike_Rock_1" | "PFB_Pike_Rock_2" | "PFB_Pike_Donut" | "PFB_Sky_Cliff_1" | "PFB_Sky_Cliff_2" | "PFB_Sky_Cliff_3" | "PFB_Sky_Cliff_4" | "PFB_Sky_Cliff_5" | "PFB_Sky_Float_1" | "PFB_Sky_Float_2" | "PFB_Sky_Float_3" | "PFB_Sky_Float_4" | "PFB_Sky_Float_5" | "PFB_Sky_Arc" | "PFB_Pipe_Corner_1" | "PFB_Pipe_Corner_2" | "PFB_Pipe_Corner_3" | "PFB_Pipe_Long" | "PFB_Pipe_Short" | "PFB_Pipe_Valve" | "PFB_Sheep" | "PFB_Red_EnergyShield" | "PFB_FlameThrowerEffect" | "PFB_TimelinePodLandingClimbIsland" Default asset names. Only these names can be used with `tm.physics.SpawnObject()`

--- Spawn a spawnable at the position, e.g. PFB_Barrel
---@param position ModVector3 Position of the object
---@param name Spawnable Name of the object. Can only be a default asset name (from the list returned by `tm.physics.SpawnableNames()`)
---@return ModGameObject object Game object spawned
function tm.physics.SpawnObject(position, name) end

--- Despawn all spawned objects from this mod
---@return nil
function tm.physics.ClearAllSpawns() end

--- Get a list of all possible spawnable names
---@return string[]
---@nodiscard
function tm.physics.SpawnableNames() end

--- Add a mesh to all clients, note this will have to be sent to the client when they join
---@param filename string The name of the mesh in the mod files (Must use the `.obj` format)
---@param resourceName string The name that the mesh will use
---@return nil
function tm.physics.AddMesh(filename, resourceName) end

--- Add a texture to all clients, note this will have to be sent to the client when they join
---@param filename string The name of the texture in the mod files (Must use the `.png` format)
---@param resourceName string The name that the texture will use
---@return nil
function tm.physics.AddTexture(filename, resourceName) end

--- Spawn a custom physics object (Mesh and texture must be created with `.AddMesh()` and `.AddTexture()` first)
---@param position ModVector3 The position to spawn the object at
---@param meshName string The name of the mesh that the object will use (Has to be added with `tm.physics.AddMesh()` first)
---@param textureName string The name of the texture that the object will use (Has to be added with `tm.physics.AddTexture()` first)
---@param isKinematic boolean Whether the object will be affected by physics or not
---@param mass number The mass of the object. Units are `5kg`
---@return ModGameObject object Game object spawned
function tm.physics.SpawnCustomObjectRigidbody(position, meshName, textureName, isKinematic, mass) end

--- Spawn a custom object (Mesh and texture must be created with `.AddMesh()` and `.AddTexture()` first)
---@param position ModVector3 The position to spawn the object at
---@param meshName string The name of the mesh that the object will use (Has to be added with `tm.physics.AddMesh()` first)
---@param textureName string The name of the texture that the object will use (Has to be added with `tm.physics.AddTexture()` first)
---@return ModGameObject object Game object spawned
function tm.physics.SpawnCustomObject(position, meshName, textureName) end

--- Spawn a custom object with concave collision support (Mesh and texture must be created with `.AddMesh()` and `.AddTexture()` first)
---@param position ModVector3 The position to spawn the object at
---@param meshName string The name of the mesh that the object will use (Has to be added with `tm.physics.AddMesh()` first)
---@param textureName string The name of the texture that the object will use (Has to be added with `tm.physics.AddTexture()` first)
---@return ModGameObject object Game object spawned
function tm.physics.SpawnCustomObjectConcave(position, meshName, textureName) end

--- Spawn a box trigger that will detect overlap but will not interact with physics
---@param position ModVector3 The position to spawn the Box Trigger at
---@param size ModVector3 The Box Trigger' size
---@return ModGameObject object Game object spawned
function tm.physics.SpawnBoxTrigger(position, size) end

--- Sets the build complexity value. Default value is `700` and values above it can make the game unstable
---@param value integer
---@return nil
function tm.physics.SetBuildComplexity(value) end

--- Registers a function to the collision enter callback of a game object
---@param targetObject ModGameObject Object for which the callback will be registered
---@param functionName string Name of the function to register. Must be in the global scope
---@return nil
function tm.physics.RegisterFunctionToCollisionEnterCallback(targetObject, functionName) end

--- Registers a function to the collision exit callback of a game object
---@param targetObject ModGameObject Object for which the callback will be registered
---@param functionName string Name of the function to register. Must be in the global scope
---@return nil
function tm.physics.RegisterFunctionToCollisionExitCallback(targetObject, functionName) end

--- Returns a bool if raycast hit something. Hit argument gets overwritten with raycast data
---@param origin ModVector3 Origin of the raycast
---@param direction ModVector3 Direction of the raycast in euler angles
---@param hitPositionOut ModVector3 Reference to the vector in which the hit position will be stored (only modified if the raycast hit an object)
---@param maxDistance number Max distance from the origin to check for hits
---@return boolean hit Whether an object has been hit
function tm.physics.Raycast(origin, direction, hitPositionOut, maxDistance) end

--- Returns the internal name for the current map
---@return string name The map name
---@nodiscard
function tm.physics.GetMapName() end

--- Returns the wind velocity at a position
---@param position ModVector3
---@return ModVector3
---@nodiscard
function tm.physics.GetWindVelocityAtPosition(position) end

--#endregion

--------------------- Players ---------------------

--#region

---@class ModPlayer Object representing a player in the game
---@field playerId integer ID of the player

--- Everything to do with players actions and info
tm.players = {}

--- Event triggered when a player joins the server. Functions are called with a `ModPlayer` object as argument whose only field is `playerId` (ID of the player who triggered the event)
tm.players.OnPlayerJoined = {}

--- Add function to event
---@param Function fun(player: ModPlayer): any
---@return nil
function tm.players.OnPlayerJoined.add(Function) end

--- Remove function from event
---@param Function fun(player: ModPlayer): any
---@return nil
function tm.players.OnPlayerJoined.remove(Function) end

--- Event triggered when a player leaves the server. Functions are called with a `ModPlayer` object as argument whose only field is `playerId` (ID of the player who triggered the event)
tm.players.OnPlayerLeft = {}

--- Add function to event
---@param Function fun(player: ModPlayer): any
---@return nil
function tm.players.OnPlayerLeft.add(Function) end

--- Remove function from event
---@param Function fun(player: ModPlayer): any
---@return nil
function tm.players.OnPlayerLeft.remove(Function) end

--- Get all players currently connected to the server
---@return ModPlayer[]
---@nodiscard
function tm.players.CurrentPlayers() end

--- Forcefully disconnect a given player
---@param playerId integer
---@return nil
function tm.players.Kick(playerId) end

--- Get the Transform of a player
---@param playerId integer
---@return ModTransform
---@nodiscard
function tm.players.GetPlayerTransform(playerId) end

--- Get the GameObject of a player
---@param playerId integer
---@return ModGameObject
---@nodiscard
function tm.players.GetPlayerGameObject(playerId) end

--- Returns whether the player is seated or not
---@param playerId integer
---@return boolean
---@nodiscard
function tm.players.IsPlayerInSeat(playerId) end

--- Sets whether the specified player can fly or not
---@param playerId integer
---@param enabled boolean
---@return nil
function tm.players.SetJetpackEnabled(playerId, enabled) end

--- Get all structure(s) owned by that player
---@param playerId integer
---@return ModStructure[]
---@nodiscard
function tm.players.GetPlayerStructures(playerId) end

--- Get the structure(s) currently in build mode for a player
---@param playerId integer
---@return ModStructure[]
---@nodiscard
function tm.players.GetPlayerStructuresInBuild(playerId) end

--- Get the last select block in the builder for that player
---@param playerId integer
---@return ModBlock
---@nodiscard
function tm.players.GetPlayerSelectBlockInBuild(playerId) end

--- Get the player's name
---@param playerId integer
---@return string
---@nodiscard
function tm.players.GetPlayerName(playerId) end

--- Returns true if the player is in build mode
---@param playerId integer
---@return boolean
---@nodiscard
function tm.players.GetPlayerIsInBuildMode(playerId) end

--#endregion

--------------------- PlayerUI ---------------------

--#region

--- For adding UI to your mod
tm.playerUI = {}

--- Add a button to the client's mod UI
---@param playerId integer ID of the player for which the UI element will be created
---@param id string | integer | number | boolean ID of the UI element
---@param defaultValue string Text of the button
---@param callback function Function to execute when the button is pressed (executed with a `CallbackData` object as parameter)
---@param data any Arbitrary data passed to the callback function
---@return nil
function tm.playerUI.AddUIButton(playerId, id, defaultValue, callback, data) end

--- Add a text field to the client's mod UI
---@param playerId integer ID of the player for which the UI element will be created
---@param id string | integer | number | boolean ID of the UI element
---@param defaultValue string Default text
---@param callback function Function to execute when the text is changed (executed with a `CallbackData` object as parameter)
---@param data any Arbitrary data passed to the callback function
---@return nil
function tm.playerUI.AddUIText(playerId, id, defaultValue, callback, data) end

--- Add a label to the client's mod UI
---@param playerId integer ID of the player for which the UI element will be created
---@param id string | integer | number | boolean ID of the UI element
---@param defaultValue string Text of the label
---@return nil
function tm.playerUI.AddUILabel(playerId, id, defaultValue) end

--- Set the value of a client's UI element
---@param playerId integer ID of the player for which the UI element will be modified
---@param id string | integer | number | boolean ID of the UI element
---@param value string New value of the UI element (text shown on the UI element)
---@return nil
function tm.playerUI.SetUIValue(playerId, id, value) end

--- Remove all UI elements for a player
---@param playerId integer ID of the player for which the UI will be cleared
---@return nil
function tm.playerUI.ClearUI(playerId) end

--#endregion

--------------------- Audio ---------------------

--#region

---@alias AudioName "Build_rotate_Logic" | "Global_DearColleagueSpeak" | "Build_JetEngine_rotate" | "Build_StraightPole_duplicate" | "CutScene_HighSeas_Stop" | "Build_StraightPole_attach" | "Cutscene_PodLanding_p4_doorOpen" | "Build_Wheel_duplicate" | "Build_ActiveBlockButton_rotate" | "Event_that_does_nothing" | "Build_Light_duplicate" | "Build_Wheel_rotate" | "Build_Wheel_attach" | "Build_BasicBlock1x2_duplicate" | "Build_HeliBlade_duplicate" | "Build_MiniEngine_rotate" | "LoadingScreen_planet_beginPodFlyBy" | "Build_ActiveBlockButton_SaveAs" | "Build_ModularWing_attach" | "Build_Suspension_rotate" | "Build_Light_rotate" | "Build_attach_generic" | "Build_smallHinge_attach" | "CutScene_HighSeas_Start" | "Global_Reset_RTPC" | "Build_Cannon_duplicate" | "Cutscene_VistaView_p1_begin" | "Build_V8Engine_rotate" | "LoadingScreen_planet_endPodFlyBy" | "Cutscene_EndIntroCinematic" | "Build_smallHinge_rotate" | "Build_BasicBlock2x4_duplicate" | "Build_BasicBlock1x2_rotate" | "Build_JetEngineMini_duplicate" | "Build_Welding_Start" | "Cutscene_WakeUp_p1_start" | "Cutscene_Exploration_Colleague" | "Cutscene_VistaView_p2_presentSign" | "Global_Player_Died_local" | "Cutscene_HighSeas_Intro_6" | "Cutscene_HighSeas_Intro_4" | "Cutscene_HighSeas_Intro_5" | "Cutscene_HighSeas_Intro_2" | "Cutscene_HighSeas_Intro_3" | "Cutscene_HighSeas_Intro_1" | "Cutscene_EpicJump_TMlogo_start" | "Global_Player_SpawnTeleport" | "Global_Exit_BuildMode" | "Build_V8Engine_duplicate" | "Test_PlayBeep" | "Global_Player_Died_remote" | "Build_Move_generic" | "Build_HeliBlade_attach" | "Cutscene_WakeUp_p3_getUp" | "Build_ShieldPlate1x2_duplicate" | "Build_ModularWing_duplicate" | "Build_BasicBlock2x4_attach" | "Global_Player_Spawnbegin" | "Build_ActiveBlockButton_tint" | "Cutscene_Aviation_Intro_Start" | "Cutscene_WakeUp_p2_handdown" | "Build_ShieldPlate1x2_rotate" | "Build_JetEngineMini_attach" | "Build_ButtonErase" | "Cutscene_PodLanding_p1_smoke" | "Build_Light_attach" | "Build_ModularWing_rotate" | "Global_ExplorationSpeakRecoveryDrones" | "Build_block_dissolve_stop" | "Cutscene_PodLanding_p2_legfoldout" | "Build_rotate_flag" | "Build_attach_Weapon" | "Cutscene_Aviation_Intro_Stop" | "Bulild_Welding_Stop" | "Build_ToneGenerator_Select" | "Global_Enter_BuildMode" | "Cutscene_WakeUp_p5_gunReady" | "Build_V8Engine_attach" | "Build_MiniEngine_duplicate" | "Build_StraightPole_rotate" | "Build_rotate_weapon" | "Build_EngineNinja_rotate" | "Cutscene_ExplorationEndStop" | "Build_ActiveBlockButton_configure" | "Build_DriverSeat_duplicate" | "Build_rotate_fire" | "Build_HeliBlade_rotate" | "Cutscene_PodLanding_p3_impact" | "Build_CookBook_AutomaticStep" | "Cutscene_ExplorationCutScene_Start" | "Build_FuelContainer_attach" | "Build_Cannon_attach" | "Global_ExplorationSpeakIntro" | "Test_3DBeep" | "Build_block_dissolve_start" | "Cutscene_WakeUp_p4_grabGun" | "Build_ChangeConfig_ToneGenerator" | "Build_LargeHinge_attach" | "Build_Lift_generic" | "Build_FuelContainer_duplicate" | "Cutscene_Aviation_FindEngineer_Stop" | "Build_JetEngine_duplicate" | "Build_JetEngine_attach" | "Build_Parrot_Select" | "Build_ChangeConfig_Parrot" | "MUSIC_testevent" | "Cutscene_ExplorationCutScene_Stop" | "Global_DearColleagueShorter" | "Build_PistonBlock_rotate" | "Build_DriverSeat_rotate" | "Build_MiniEngine_attach" | "Build_EngineNinja_duplicate" | "Build_EngineGeneric_duplicate" | "Build_EngineNinja_attach" | "Build_ActiveBlockButton_save" | "Build_smallHinge_duplicate" | "Global_CriticalSituationSpeak" | "Global_GameStart" | "Build_rotate_generic" | "CutScene_HighSeas_UI_Sound" | "Build_duplicate_generic" | "Cutscene_EpicJump_TMlogo_off" | "Build_FuelContainer_rotate" | "Build_EngineGeneric_rotate" | "Global_ExplorationSpeakSalvage" | "Build_BasicBlock2x4_rotate" | "Build_ShieldPlate1x2_attach" | "Build_Cannon_rotate" | "Build_JetEngineMini_rotate" | "Build_LargeHinge_rotate" | "Build_EngineGeneric_attach" | "CutScene_StartIntroCinematic" | "Build_PistonBlock_duplicate" | "Build_SpawnBlock_generic" | "Build_DriverSeat_attach" | "Build_attach_Fire" | "Core_Playing" | "Build_attach_Flag" | "Cutscene_Aviation_FindEngineer_Start" | "IntroSpeak_Exploration_2" | "IntroSpeak_Exploration_3" | "IntroSpeak_Exploration_1" | "IntroSpeak_Exploration_4" | "IntroSpeak_Exploration_5" | "Build_ButtonDuplicate_generic" | "Build_PistonBlock_attach" | "Cutscene_ExplorationEndStart" | "Build_Suspension_attach" | "Global_Repair" | "Build_CookBookr_StepCorrect" | "Build_attach_Logic" | "Build_ButtonCenter" | "Build_BasicBlock1x2_attach" | "OutOfCombatEvent" | "Ghostbusterline_Block_pickup_dissolve" | "CharFootstepsLand" | "CameraAboveWater" | "Ghostbusterline_subline_start" | "CharSwimAnimation_treadingWater" | "CharHelmetClose" | "Ghostbusterline_subline_stop" | "CameraUnderWater" | "CharFootstepsJump" | "Ghostbusterline_mainline_stop" | "Ghostbusterline_mainline_start" | "InCombatEvent" | "CharHelmetOpen" | "CharSwimAnimation_crawl" | "CustomizationMenu_HelmetVisorOpenClose_02" | "CharFootstep" | "MUS_CustumizationMenu_stopMusic" | "MUS_Tutorial_EpicJump_startMusic" | "MUS_TutorialStepComplete" | "MUS_TutorialNextStep" | "MUS_TutorialComplete" | "Global_UI_customizationMenu_enter" | "MUS_Tutorial_EpicJump_done" | "MUS_VistaToTutorial_Trigger" | "MUS_Tutorial_EpicJump_camSequence" | "Global_UI_customizationMenu_exit" | "STARTALLMUSIC" | "Global_UI_MainMenu_exit" | "Global_UI_inGamePauseMenu_exit" | "MUS_Tutorial_EpicJump_preroll" | "ExplorationCheckpoint_music_stop" | "Global_UI_inGamePauseMenu_enter" | "Global_UI_MainMenu_enter" | "MUS_stopAllMusic" | "ExplorationCheckpoint_music_start" | "MUS_Tutorial_begin" | "MUS_CustumizationMenu_startMusic" | "Global_FlashBulb_splash" | "Engine_JetGimbal_single_stop" | "Engine_JetTiny_Stop" | "Engine_Ninja_single_stop" | "Vanity_GhettoBlaster6_unPause" | "Engine_UnderWater_StructureStart" | "Engine_mini_StructureStop" | "Block_SpinningBlock_start" | "Vanity_GhettoBlaster10_Stop" | "Wheel_Basic_puncture_dual" | "Vanity_SeaShantyGramophone_Stop" | "vanity_GhettoBlaster9_pause" | "Vanity_GhettoBlaster4_Stop" | "Block_HeliRotator_destroy" | "Vanity_BubbleMachine_Stop" | "Block_Propeller_single_stop" | "SmallCanon_Bullet_Impact_Block" | "Block_Cannon_bullet_instantiate" | "Engine_Jet_StructureStart" | "vanity_GhettoBlaster10_pause" | "vanity_GhettoBlaster3_pause" | "vanity_GhettoBlaster1_pause" | "Engine_V8_dual_start" | "Explosion_poisonCloud" | "Structure_UnOccupied" | "Block_ModularWing_activeStop" | "Engine_Ninja_dual_stop" | "vanity_GhettoBlaster8_pause" | "Block_Propeller_StructureStop" | "Wheel_Gokart_surface_stop" | "Vanity_ToneBlock_Synth_Play" | "Engine_V8_StructureStop" | "Engine_mini_destroy" | "Block_BigPropeller_Stop" | "Vanity_ParrotBlock_Play" | "Explosion_small" | "Wheel_Basic_brakeStop" | "Vanity_Shipbell_Play" | "Vanity_GhettoBlaster1_Stop" | "Engine_Jet_StructureStop" | "StructureEdgeDie_few" | "vanity_GhettoBlaster6_pause" | "Engine_Jet_destroy" | "Engine_V8_single_stop" | "Wheel_Basic_puncture" | "Vanity_Horn1_stopV2" | "Engine_Ninja_multi_start" | "Engine_JetMini_single_start" | "Engine_UnderWater_multi_stop" | "vanity_GhettoBlaster2_pause" | "Engine_JetNinja_single_stop" | "StructureEdgeDie_one" | "Engine_mini_v2_StructureStop" | "Engine_Jet_Single_Loop_Start" | "vanity_GhettoBlaster7_pause" | "Block_Propeller_multi_start" | "Block_Cannon_fire" | "Block_PistonBlock_stop" | "Engine_JetGimbal_StructureStart" | "Engine_UnderWater_StructureStop" | "Vanity_SeaShantyGramophone_Unpause" | "Wheel_Basic_surfaceChange" | "Engine_mini_dual_start" | "Engine_Jet_dual_start" | "Engine_V8_destroy" | "Structure_Damage_Hitmarker_PlayerHit_BlockDamaged" | "Engine_JetNinja_Loop_stop" | "StructureDamage_many" | "Vanity_GhettoBlaster7_Stop" | "Block_Magnet_Hit" | "Wheel_Basic_Start" | "Engine_mini_v2_single_start" | "Vanity_GhettoBlaster1_Start" | "StructureEdgeDie_many" | "SmallCanon_Bullet_Impact_Stone" | "Block_PistonBlock_start" | "Block_HeliRotator_start" | "SmallCanon_Bullet_Impact_Dirt" | "Vanity_GhettoBlaster1_unPause" | "Block_Sail_Start" | "Block_Propeller_destroy" | "StructureDamage_one" | "Block_Propeller_multi_stop" | "Vanity_Horn1_startV2" | "Explosion_Underwater" | "Vanity_GhettoBlaster11_Stop" | "Vanity_ToneBlock_Synth_Stop" | "Engine_Ninja_dual_start" | "Engine_JetNinja_multi_start" | "Block_SmallHinge_stop" | "StructureDamage_few" | "Engine_BullDawg_StructureStart" | "Hoverblock_Stop" | "Engine_JetLarge_Stop" | "Vanity_GhettoBlaster6_Stop" | "Engine_Ninja_StructureStart" | "Engine_JetGimbal_multi_stop" | "Block_Suspension_SwitchGroupStop" | "Vanity_FireBlock_Stop" | "Engine_JetGimbal_Occupied" | "Vanity_GhettoBlaster10_Start" | "Vanity_MadScientist_Play" | "Engine_BullDawg_Boat_Stop" | "Block_Propeller_StructureStart" | "InputSeat_DriveBy" | "Engine_JetMini_multi_stop" | "Engine_JetTiny_Activate" | "Vanity_GhettoBlaster4_Start" | "Block_BigPropeller_StructureStop" | "Engine_Jet_single_start" | "Engine_Jet_Single_Loop_Stop" | "Block_SpinningBlock_destroy" | "Vanity_GhettoBlaster4_unPause" | "Engine_UnderWater_single_stop" | "OnStructureSpawn" | "Hoverblock_StructureStart" | "Vanity_GhettoBlaster9_unPause" | "Block_PoweredModularWing_activeStart" | "OnStructureEnterPlay" | "Block_LargeHinge_steer" | "Structure_Damage_Hitmarker_PlayerHit_BlockKilled" | "Vanity_GhettoBlaster5_unPause" | "OnStructureEnterBuild" | "STRC_Bullet_Wizzby_Generic" | "Block_WingFin_activeStop" | "Engine_V8_dual_stop" | "Wheel_Basic_LeaveGround" | "Engine_JetGimbal_UnOccupied" | "Block_Propeller_single_start" | "Engine_JetMini_single_Loop_start" | "Block_ModularWing_activeStart" | "Block_RotatingServo_start" | "Block_Cannon_bullet_destroy" | "Vanity_FireBlock_Play" | "Vanity_GhettoBlaster6_Start" | "Block_BigPropeller_StructureStart" | "vanity_GhettoBlaster11_pause" | "Vanity_Horn_Yelper_Start" | "Block_RotatingServo_destroy" | "Vanity_SeaShantyGramophone_pause" | "Engine_JetMini_multi_start" | "Vanity_BubbleMachine_Play" | "Vanity_GhettoBlaster11_unPause" | "Engine_Jet_Overheating_dual" | "Engine_Ninja_multi_stop" | "Engine_V8_single_start" | "InputSeat_SonicBoom_Client" | "Vanity_GhettoBlaster2_Start" | "Engine_mini_dual_stop" | "vanity_GhettoBlaster5_pause" | "Vanity_GhettoBlaster10_unPause" | "Engine_JetMini_StructureStart" | "Engine_Jet_dual_stop" | "Engine_mini_v2_StructureStart" | "Vanity_GhettoBlaster9_Stop" | "Block_Cannon_fire_multi" | "Engine_JetNinja_multi_stop" | "Engine_JetNinja_dual_start" | "SmallCanon_Bullet_Impact_Grass" | "Structure_Occupied" | "Transformation_Scrap" | "Block_WingFin_destroy" | "Block_WingFin_activeStart" | "Engine_Ninja_destroy" | "Block_BombRack_Fire" | "Engine_JetNinja_dual_stop" | "Vanity_Horn1_stop" | "Explosion_large" | "Wheel_Basic_surface_stop" | "Engine_JetGimbal_multi_start" | "Vanity_GhettoBlaster7_unPause" | "Vanity_GhettoBlaster9_Start" | "InputSeat_SonicBoom_Server" | "Collision_Bullet" | "Block_Magnet_Start" | "Vanity_GhettoBlaster8_Start" | "Explosion_generic" | "Vanity_GhettoBlaster7_Start" | "Block_ModularWing_destroy" | "Block_Suspension_SwitchGroupStart" | "Engine_mini_multi_stop" | "OnStructureDespawn" | "Block_RotatingServo_stop" | "Engine_mini_v2_single_stop" | "Engine_JetMini_StructureStop" | "Block_LargeHinge_stop" | "Vanity_SmokeMachine_Play" | "Vanity_Horn1_start" | "Explosion_CannonBullet" | "Vanity_GhettoBlaster8_Stop" | "Engine_JetTiny_Start" | "Block_PoweredModularWing_activeStop" | "Engine_JetNinja_single_start" | "Engine_JetMini_single_Loop_stop" | "Vanity_GhettoBlaster5_Stop" | "Hoverblock_Start" | "Block_SmallHinge_steer" | "Engine_mini_single_stop" | "Engine_V8_StructureStart" | "Wheel_Gokart_surfaceChange" | "Engine_JetGimbal_single_start" | "Engine_Jet_single_stop" | "Vanity_Horn2_start" | "Vanity_GhettoBlaster8_unPause" | "Engine_JetLarge_Start" | "SmallCanon_Bullet_Impact_Wood" | "Wheel_Basic_brakeStart" | "Block_SpinningBlock_stop" | "Hoverblock_StructureStop" | "Block_OldschoolCannon_Fire" | "Engine_Jet_Overheating_one" | "Engine_JetNinja_StructureStart" | "Engine_JetMini_single_stop" | "Vanity_GhettoBlaster3_Stop" | "Block_HeliRotator_stop" | "Block_OldSchoolCannon_MultiFire" | "Engine_UnderWater_single_start" | "Engine_JetNinja_StructureStop" | "Structure_Damage_Hitmarker_EnemyHit_BlockKilled" | "Global_Transformation" | "SmallCanon_Bullet_Impact_Mud" | "Engine_JetMini_destroy" | "Engine_JetNinja_Loop_start" | "Vanity_GhettoBlaster3_Start" | "Engine_mini_single_start" | "Block_BigPropeller_Start" | "Engine_JetMini_multi_Loop_Stop" | "Vanity_GhettoBlaster5_Start" | "Vanity_Horn_Yelper_Stop" | "Vanity_GhettoBlaster3_unPause" | "Engine_UnderWater_multi_start" | "Engine_JetMini_multi_Loop_start" | "Engine_JetGimbal_destroy" | "Block_Detach_Play" | "Vanity_Shipbell_Stop" | "Explosion_WaterSurface" | "Vanity_GhettoBlaster2_unPuase" | "STRC_Bullet_Wizzby_Cannon" | "Engine_BullDawg_Boat_Start" | "Block_Magnet_Stop" | "Wheel_Basic_destroy" | "Engine_mini_multi_start" | "Engine_JetNinja_destroy" | "Vanity_GhettoBlaster2_Stop" | "Block_PoweredModularWing_destroy" | "Vanity_SeaShantyGramophone_Start" | "Block_MiniGun_Start" | "Vanity_GhettoBlaster11_Start" | "Vanity_MadScientist_Stop" | "Engine_V8_multi_stop" | "Vanity_ParrotBlock_Stop" | "Vanity_Horn2_stop" | "Engine_Ninja_StructureStop" | "vanity_GhettoBlaster4_pause" | "Engine_mini_StructureStart" | "Block_CannonSmall_fire_multi" | "Engine_JetGimbal_StructureStop" | "Explosion_medium" | "Engine_Ninja_single_start" | "Block_Sail_Stop" | "Block_MiniGun_Stop" | "Engine_V8_multi_start" | "Block_CannonSmall_fire" | "Engine_UnderWater_destroy" | "Vanity_SmokeMachine_Stop" | "COLLISION_event" | "Engine_BullDawg_StructureStop" | "Structure_Damage_Hitmarker_EnemyHit_BlockDamaged" | "UI_Rally_RaceEnd_fail" | "UI_MultiPl_Countdown_begin" | "UI_Builder_Colorpicker" | "Build_UndoBuildOperation_fail" | "UI_Rally_Race12_Intro" | "UI_CookBook_stepComplete" | "UI_KingOfTheHill_ReignExpiring_progressEnd" | "UI_PlayMenu_startExpedition" | "UI_Reset_Unlock" | "UI_Rally_Medals" | "UI_builder_click" | "UI_Rally_BigMap_PointerExit" | "UI_builder_blockView_click" | "UI_PlayMenuHover" | "CustomizationMenu_POD_closeSequence_stop" | "UI_Race_finished_lost" | "UI_builder_bottomMenu_click" | "CustomizationMenu_Bg_Enter" | "UI_Pickup_Substance" | "UI_KingOfTheHill_NewMatchRequest" | "UI_Rally_EndRace_Medals" | "CustomizationMenu_HelmetVisorOpenClose" | "UI_Powercore_Unlock_Start" | "UI_KingOfTheHill_round_lost" | "UI_CookBook_completed" | "UI_Rally_Race10_Intro" | "UI_ChargedButton_Stop" | "UI_Rally_BigMap_Enter" | "SetUnlockingState_Block" | "UI_KingOfTheHill_round_won" | "PuzzleFeedback_BallAndGoal_activate" | "UI_KingOfTheHill_NewRoundRequest" | "UI_Block_Unlock_Start" | "UI_KingOfTheHill_CrownStealFromOther" | "PuzzleFeedback_MoveToTarget_deactivate" | "UI_Rally_BigMap_Exit" | "PuzzleFeedback_MoveToTarget_complete" | "UI_Rally_RaceEnd_bronze" | "UI_RaceExped_BoomAndCheer" | "UI_Race_leaveRace_progressEnd" | "UI_Rally_BlockUnlock" | "UI_Rally_EndRace_Qualified_Hit" | "UI_Unlock_Cancelled" | "CustomizationMenu_colorPicker_click" | "PuzzleFeedback_BallAndGoal_GoalScored" | "UI_KingOfTheHill_CrownStolenByOther" | "UI_builder_Cookbook_Auto_Begin" | "UI_Generic_swoosh" | "UI_KingOfTheHill_match_won" | "Builder_BlockNotAvalible" | "UI_RallyRestartButton_click" | "UI_PlayMenu_startLoad" | "UI_Race_ExitSignUpArea" | "UI_Blueprint_Unlock_Start" | "UI_Race_finished_won" | "UI_MultiPl_round_won" | "UI_MultiPl_CrownExpired" | "UI_ConfirmQuitToMainMenu" | "UI_LapCounter" | "UI_Race_Exit_startZone" | "UI_Rally_Race06_Intro" | "CustomizationMenu_submit_click" | "UI_KingOfTheHill_CrownAttached_localPlayer" | "UI_Builder_Cookbook_AutoStart" | "UI_General_BigMap_Exit" | "UI_MultiPl_KingUnassigned" | "UI_builder_falseClick" | "UI_Race_StartRace" | "UI_Race_CheckPoint" | "UI_Rally_RaceEnd_gold" | "UI_SpaceShip_Unlock_Stop" | "UI_Aviation_Zone_Reveal" | "UI_PlayMenuSwipe" | "UI_PlayMenuClick" | "UI_Xbox_DialMenu_Hover" | "UI_KingOfTheHill_match_lost" | "Build_NudgeBlock" | "UI_Rally_Race02_Intro" | "PuzzleFeedback_BallAndGoal_deactivate" | "UI_Race_Enter_startZone" | "UI_Xbox_DialMenu_Click" | "UI_CookBook_begin" | "UI_Builder_Spray" | "UI_Rally_LeaderboardUnlocked" | "UI_MultiPl_Countdown_end" | "UI_IntercomMsg_Typing" | "UI_IntercomMsg_Show" | "UI_Race_leaveRace_progressBegin" | "UI_Rally_Race04_Intro" | "UI_Xbox_DialMenu_Close" | "CustomizationMenu_POD_openAnimation" | "UI_Blueprint_Unlock_Stop" | "CustomizationMenu_submit_click_Menu" | "CustomizationMenu_genderPicker_click" | "UI_KingOfTheHill_CrownExpiring_progressBegin" | "UI_Race_EnterSignUpArea" | "UI_FinalLap" | "UI_Rally_Race08_Intro" | "UI_Generic_positiveFeedback" | "UI_builder_MouseOver" | "UI_Rally_Race09_Intro_firstTime" | "CustomizationMenu_Bg_Exit" | "UI_ChargedButton_Play" | "UI_CounterStop" | "UI_Pickup_BuildPower" | "UI_Rally_Race07_Intro" | "UI_MultiPl_NewKing" | "UI_Rally_BigMap_Unlock" | "UI_Race_LeftRace" | "UI_General_BigMap_Enter" | "UI_MultiPl_match_won" | "UI_Rally_EndRace_Animation_In_Begin" | "UI_Rally_Completion" | "UI_InGameMenu_QuitToMain_click" | "UI_Purchase_Block" | "UI_KingOfTheHill_CrownAttached_otherPlayer" | "UI_Race_Countdown_cancelled" | "UI_Aviation_EnterCombat" | "UI_Rally_EndRace_Animation_Out_End" | "UI_Rally_Race16_Intro" | "UI_Rally_Race05_Intro" | "PuzzleFeedback_Ball_dissolve" | "UI_CounterStart" | "UI_Builder_Spray_Clear" | "Build_UndoBuildOperation_succes" | "UI_CookBook_nextStep" | "UI_MultiPl_round_lost" | "UI_Race_Countdown_tick" | "UI_Generic_bum" | "UI_Rally_Race09_Intro" | "PuzzleFeedback_Ball_materialize" | "UI_Pickup_Block" | "UI_KingOfTheHill_CrownExpiring_progressEnd" | "UI_MultiPl_match_lost" | "UI_Pickup_Secret" | "UI_CookBook_celebrate" | "UI_KingOfTheHill_CrownPickup_progressBegin" | "UI_Rally_EndRace_FinalTime_Hit" | "UI_Rally_Race01_Intro" | "UI_Generic_click" | "UI_Rally_BigMap_PointerEnter" | "PuzzleFeedback_BallAndGoal_GoalKick" | "UI_KingOfTheHill_ReignExpiring_progressBegin" | "UI_SpaceShip_Unlock_Start" | "UI_Rally_RaceEnd_silver" | "UI_Generic_CloseDialog" | "UI_Block_Unlock_End" | "CustomizationMenu_POD_thrustersmoke" | "UI_Rally_Race01_Intro_firstTime" | "UI_Powercore_Unlock_End" | "Build_UndoBuildOperation_start" | "SetUnlockingState_Powercore" | "UI_Rally_Race11_Intro" | "UI_Rally_EndRace_Animation_In_End" | "UI_GifRecorderDone" | "UI_RaceExped_Cheer" | "CustomizationMenu_POD_closeSequence_start" | "UI_Rally_EndRace_Animation_Out_Begin" | "UI_KingOfTheHill_CrownPickup_progressEnd" | "UI_Xbox_DialMenu_Open" | "UI_Rally_EndRace_Blockunlock_Whoosh" | "UI_RaceExped_Boom" | "UI_GifRecorder" | "UI_Rally_Race03_Intro" | "UI_Rally_Race13_Intro" | "UI_Rally_Introduction_stop" | "PuzzleFeedback_MoveToTarget_activate" | "UI_Generic_OpenDialog" | "UI_MultiPl_Countdown_tick" | "CharacterCustomisationGarage" | "Spaceship_Engine_Stop" | "AI_LvlObj_DogfighterPlane_Stop" | "NPC_Animal_Chaser_attackWarning" | "Salvage_Hit" | "LvlObj_Fireplace" | "NPC_Animal_Seagull_Screech" | "Amb_Basicwind_stop" | "Amb_Forrest_Coockoo_Play" | "Amb_Forrest_Stop" | "Amb_Desert_Drone1_Stop" | "Amb_River_Start" | "AI_Env_PalmTree_WindLoop" | "Amb_BasicWind_RaceIsland_start" | "LvlObj_RingOfFire_start" | "NPC_Animal_Monkey_FS_Walk" | "Amb_Marsh_GrassHopper_Start" | "LvlObj_SoftPenalty_Bush_collision" | "Spaceship_Hum_Play" | "AMb_Marsh_Moorhen_Start" | "LvlObj_Pusher_Hit" | "NPC_Animal_Monkey_FS_Run" | "LvlObj_Pusher_Hit_Stop" | "Amb_Marsh_Crickets_Start" | "Birds_HarrisHawk_3D_Stop" | "LvlObj_City_Enter" | "Play_DX_Intercom_Spaceshipprogess_Block01" | "LvlObj_Landmine_exploded" | "Amb_Animals_Marsh_Start" | "LvlObj_SoftPenalty_bigtree_collision" | "Amb_Volcano_Inside_Start" | "Amb_BasicWind_KingOfTheHill_start" | "NPC_Animal_HighSeas_Whale_Stop" | "NPC_Animal_Whale_Big_Start" | "Play_Exploration_CheckPoint_Recover_Salvage" | "Amb_BasicWind_TestZone_stop" | "LvlObj_Rotator_Stop" | "Pirate_Hitmakers_Hit" | "Amb_Marsh_Base_Start" | "Amb_Tunnel_Start" | "NPC_Enemy_AirMine_Trigger_Start" | "Play_DX_Intercom_SpaceshipProgress_Powercore01" | "AI_Env_SateliteDish_Stop" | "ShipWreck_MetalCreaks_Start" | "AI_Birdoos_PT2_Play" | "LvlObj_Spinner_start" | "Amb_BasicFauna_start" | "NPC_Enemy_Pirate_Balloon_Fire_Stop" | "Amb_Forrest_JamieBird_Stop" | "LvlObj_FlagTwin_start" | "Amb_Forrest_Crickets_Stop" | "LvlObj_TeleportStation_disable" | "NPC_Animal_Vulture_steadyFlying" | "LvlObj_Pusher_Move" | "Play_Exploration_Checkpoint_Open_Start" | "Amb_BasicWind_TestZone_start" | "AMb_Marsh_Moorhen_Stop" | "HighSeas_TeleportStation_ActiveFirstTime" | "LvlObj_Catapult" | "Amb_Marsh_Frogs_Stop" | "Birds_GenericBirds_3D_Stop" | "AI_Amb_TheRuins_Trees_Birds" | "NPC_Animal_NuggetTheif_Wings" | "Amb_LavaInside_start" | "Amb_Animals_ExoticIsland_Stop" | "Amb_Volcano_Inside_Stop" | "GuidingWind_Start" | "Amb_Forrest_Basic_Ambience_Play" | "Amb_Forrest_Hawk1_Play" | "NPC_Animal_Runner_ReturnToNormal" | "LvlObj_SquareCannon" | "AI_Birdoos_Civilian_FallToDest" | "NPC_Enemy_Pirate_Balloon_Fire_Start" | "LvlObj_SoftPenalty_tireStack_collision" | "LvlObj_Pusher_BG_Stop" | "LvlObj_Pusher_Hit_Below" | "ShowHologram" | "Amb_Forrest_Smallbirds_Stop" | "LvlObj_Pusher_Move_Stop" | "NPC_Animal_PufferFish_Activate" | "Amb_Marsh_Owl_Stop" | "Play_Exploration_Checkpoint_LoopStop" | "LvlObj_Flag_Small_stop" | "Amb_ChristmasSong_stop" | "Amb_Rain_Stop" | "Play_DX_Intercom_SalvageRecovered01" | "NPC_Animal_SandScraper_Start" | "ACTIVATE_OCCLUSION" | "Amb_Forrest_Hawk2_Play" | "NPC_Enemy_FlakCannon_Fire_Kill" | "Amb_BirdsBasic_2D_Start" | "NPC_Enemy_Pirate_Balloon_Kill" | "Amb_Cave_Play" | "Amb_BasicWind_Exploration_stop" | "Amb_Desert_Forrest_Basic_Ambience_Stop" | "NPC_Animal_Whale_Medium_Stop" | "Amb_Animals_ExoticIsland_Stop_OnlyBirds" | "NPC_Animal_Seagull_WingFlap" | "Amb_Desert_Drone2_Start" | "AI_Birdoos_PT_Play" | "Amb_Forrest_FlyAway_Play" | "NPC_Animal_Whale_Movement" | "LakeSide_Stop" | "LvlObj_Grinder_start" | "Amb_BasicFauna_stop" | "NPC_Animal_Whale_Small_Stop" | "DeliveryStation_Loop_Play" | "LvlObj_BlockHunt_Beacon_callingSound" | "Amb_Volcano_Base_Start" | "Amb_BasicWind_RaceIsland_stop" | "Amb_Forrest_Eagle_Play" | "ShipWreck_MetalCreaks_Stop" | "LvlObj_BlockHunt_Beacon_reached" | "Birds_HarrisHawk_3D_Start" | "LvlObj_BlockHunt_begin" | "Amb_Forrest_Coockoo_Stop" | "Amb_Animals_ExoticIsland_Attenuation_Start" | "Amb_ForrestBirds_Start" | "Amb_Animals_ExoticIsland_Start" | "Amb_Lake_Stop" | "AI_LvlObj_DogfighterPlane_Shooting_Stop" | "NPC_Animal_Whale_Medium_Start" | "Amb_Lava_stop" | "Amb_CavePond_Start" | "AI_Env_SavannahTree_WindLoop" | "Amb_Marsh_GrassHopper_Stop" | "Amb_Rain_Start" | "AI_Birdoos_Civilian_WalkToSeat" | "Amb__BirdsBasic_2D_Stop" | "NPC_Enemy_AirMine_Release" | "LvlObj_SoftPenalty_Cactus_collision" | "Amb_Animals_Island_Start" | "Play_Exploration_Checkpoint_Open_Finish" | "Amb_Cave_Stop" | "Amb_Basicwind_start" | "LvlObj_Pusher_BG_Start" | "GuidingWind_Stop" | "NPC_Animal_Chaser_RollingIntoBall" | "Whirlpool_Start" | "NPC_Animal_Whale_Small_Start" | "LvlObj_Hammer" | "Birds_Coockoo3D_Stop" | "Amb_BasicWind_Exploration_start" | "Play_Exploration_CheckPoint_UnlockSeq" | "NPC_Animal_Seagull_Death" | "Amb_HowlingPeaks_Stop" | "LvlObj_TeleportStation_activate" | "LvlObj_TeleportStation_enable" | "Amb_Desert_Drone2_Stop" | "Amb_Marsh_Frogs_Start" | "Amb_Animals_MarshBirds_Start" | "Amb_River_Stop" | "NPC_Animal_Sheep_Emote_Start" | "LvlObj_LandmineExplosion_explosion" | "NPC_Animal_Chaser_idleLookingAround" | "LvlObj_TeleportStation_receiveBlock" | "NPC_Animal_Vulture_wingFlap_big" | "Birds_Coockoo3D_Start" | "NPC_Animal_NuggetTheif_Scared" | "Amb_Animals_Marsh_Stop" | "AI_Birdoos_Civilian_WalkingToPickup" | "LvlObj_WindZone_start" | "NPC_Animal_Chaser_footstep" | "LvlObj_RingOfFire_stop" | "NPC_Animal_Sheep_Emote_Stop" | "Birds_GenericBirds_3D_Start" | "Amb_Marsh_Crickets_Stop" | "Spaceship_Engine_Play" | "NPC_Animal_Whale_Big_Stop" | "Amb_Desert_Basic_Start" | "Play_DX_Intercom_MapInfo01" | "AI_Birdoos_Civilian_WalkToDest" | "Amb_Forrest_JamieBird_Play" | "Amb_ForrestBirds_Stop" | "AI_Birdoos_Civilian_Seated" | "Amb_Desert_Drone1_Start" | "LvlObj_Flag_Simple_start" | "Play_DX_Outro01" | "Spaceship_Hum_Stop" | "Amb_Forrest_Eagle_Stop" | "Amb_Lake_Start" | "Amb_Beach_Outdoor_start" | "Amb_Forrest_Smallbirds_Play" | "LvlObj_BlockHunt_complete" | "AMb_Forrest_Basic_Ambience_Stop" | "LvlObj_PowerCoreCrate_onPickup" | "LvlObj_City_Exit" | "Amb_Tunnel_Stop" | "NPC_Animal_Chaser_RollingOutOfBall" | "HighSeas_Wind_Start" | "Play_Exploration_Checkpoint_Loop" | "Amb_Animals_ExoticIsland_Attenuation_Stop" | "NPC_Enemy_FlakCannon_Fire_Start" | "NPC_Animal_Monkey_Idle" | "NPC_Animal_Chaser_idleEating_singleBite" | "AI_Amb_Coastline_Cloudwaves_Start" | "Amb_Beach_Indoor_start" | "LvlObj_HVAC_Start" | "Amb_Grass_Animals_Stop" | "Amb_Grass_Basic_Stop" | "Amb_CavePond_Stop" | "LvlObj_ConfettiCelebration" | "Amb_Marsh_Base_Stop" | "NPC_Enemy_FlakCannon_Fire_Stop" | "Amb_HowlingPeaks_Start" | "LvlObj_WoodCrate_explode" | "Amb_Waves_Start" | "Amb_Marsh_Owl_Start" | "Amb_Desert_Forrest_Basic_Ambience_Play" | "Amb_HeavyWinds_Stop" | "Amb_LavaInside_stop" | "Play_DX_Intercom_Blueprint_Available01" | "Amb_Beach_Outdoor_stop" | "NPC_Animal_Runner_anim_idle" | "SFX_Ghost_Explode" | "LvlObj_Spacepod" | "Amb_Animals_MarshBirds_Stop" | "Amb_Desert_Basic_Stop" | "AI_LvlObj_DogfighterPlane_Start" | "NPC_Animal_SandScraper_Stop" | "LvlObj_Flag_Small_start" | "Amb_Forrest_Start" | "Pirate_Hitmakers_Kill" | "AI_Birdoos_Civilian_WaitSlowDown" | "Amb_BasicWind_SandboxWLD_start" | "Amb_Forrest_FlyAway_Stop" | "Salvage_Explosive_Stop" | "AI_LvlObj_DogfighterPlane_Shooting_Start" | "NPC_Animal_Monkey_Idle_Stop" | "Amb_Lava_start" | "Birds_NorthernHawk_3D_Start" | "Amb_BasicWind_SandboxWLD_stop" | "LvlObj_Pusher_Hit_Below_Release" | "Amb_Grass_Basic_Start" | "Amb_Volcano_Base_Stop" | "Amb_Forrest_Hawk1_Stop" | "LvlObj_WindZone_stop" | "Salvage_Explosive_Start" | "Birds_NorthernHawk_3D_Stop" | "NPC_Animal_HighSeas_Whale_Start" | "AI_Amb_Coastline_Cloudwaves_Stop" | "NPC_Animal_Runner_Scared" | "DE_ACTIVATE_OCCLUSION" | "LvlObj_FlagTwin_stop" | "NPC_Animal_Runner_death" | "NPC_Enemy_AirMine_Trigger_Stop" | "NPC_Animal_Runner_anim_running" | "HideHologram" | "Amb_Forrest_Crickets_Play" | "LakeSide_Start" | "Amb_BasicWind_KingOfTheHill_stop" | "AI_Env_SateliteDish_Start" | "LvlObj_Rotator_Start" | "Amb_Animals_ExoticIsland_Start_OnlyBirds" | "HighSeas_Wind_Stop" | "Amb_Animals_Island_Stop" | "NPC_Animal_Chaser_Dizzy" | "Amb_Waves_Stop" | "AI_Amb_BaseWind_Stop" | "Whirlpool_Stop" | "LvlObj_SoftPenalty_smalltree_collision" | "Amb_ChristmasSong_start" | "LvlObj_Landmine_trigger" | "LvlObj_Landmine_reset" | "LvlObj_Flag_Simple_stop" | "Amb_Forrest_Hawk2_Stop" | "LvlObj_Grinder_stop" | "LvlObj_Spinner_stop" | "Amb_Beach_Indoor_stop" | "AI_Amb_BaseWind_Start" | "LvlObj_SoftPenalty_Cactus_ball_collision" | "Amb_HeavyWinds_Start" | "LvlObj_SmokeFire" | "Amb_Grass_Animals_Start" | "LvlObj_BlockHunt_failed" | "DeliveryStation_Loop_Stop" Audio names that can be played

--- Lets you play audio and effect audio
tm.audio = {}

--- Play audio at a position. This is more cost friendly but you can not stop or move the sound
---@param audioName AudioName Name of the audio to play
---@param position ModVector3 Position of the audio
---@param keepObjectDuration number Duration of the audio
---@return nil
function tm.audio.PlayAudioAtPosition(audioName, position, keepObjectDuration) end

--- Play audio on a GameObject
---@param audioName AudioName Name of the audio to play
---@param modGameObject ModGameObject GameObject on which the audio should be played
---@return nil
function tm.audio.PlayAudioAtGameobject(audioName, modGameObject) end

--- Stop all audio on a GameObject
---@param modGameObject ModGameObject
---@return nil
function tm.audio.StopAllAudioAtGameobject(modGameObject) end

--- Get a list of all playable audio names
---@return string[]
---@nodiscard
function tm.audio.GetAudioNames() end

--#endregion

--------------------- Input ---------------------

--#region

---@alias InputKey "`" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0" | "-" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "[" | "]" | ";" | "'" | "\\" | "," | "." | "/" | "backspace" | "tab" | "enter" | "left shift" | "right shift" | "left control" | "left alt" | "space" | "right alt" | "right control" | "insert" | "home" | "page up" | "delete" | "end" | "page down" | "up" | "down" | "left" | "right" | "numlock" | "[/]" | "[*]" | "[-]" | "[+]" | "[enter]" | "[,]" | "[1]" | "[2]" | "[3]" | "[4]" | "[5]" | "[6]" | "[7]" | "[8]" | "[9]" | "[0]" Keys that can have callbacks registered

--- Lets you trigger functions on key press/release by players
--- Keys: "`" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0" | "-" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "[" | "]" | ";" | "'" | "\\" | "," | "." | "/" | "backspace" | "tab" | "enter" | "left shift" | "right shift" | "left control" | "left alt" | "space" | "right alt" | "right control" | "insert" | "home" | "page up" | "delete" | "end" | "page down" | "up" | "down" | "left" | "right" | "numlock" | "[/]" | "[*]" | "[-]" | "[+]" | "[enter]" | "[,]" | "[1]" | "[2]" | "[3]" | "[4]" | "[5]" | "[6]" | "[7]" | "[8]" | "[9]" | "[0]"
tm.input = {}

--- Registers a function to the callback of when the given player presses the given key
---@param playerId integer ID of the player for which the function will be registered
---@param functionName string Name of the function to register. Must be in the global scope
---@param keyName InputKey Name of the key to use. See `tm.input` docs for available key names
---@return nil
function tm.input.RegisterFunctionToKeyDownCallback(playerId, functionName, keyName) end

--- Registers a function to the callback of when the given player releases  the given key
---@param playerId integer ID of the player for which the function will be registered
---@param functionName string Name of the function to register. Must be in the global scope
---@param keyName InputKey Name of the key to use. See `tm.input` docs for available key names
---@return nil
function tm.input.RegisterFunctionToKeyUpCallback(playerId, functionName, keyName) end

--#endregion

--------------------- Vector3 ---------------------

--#region

--- For all things vectors, vector3 can store 3 numbers
tm.vector3 = {}

---@class ModVector3 3D Vector object, can store 3 numbers
---@operator mul(number) : ModVector3 Vector-scalar multiplication
---@operator div(number) : ModVector3 Vector-scalar division
---@operator add(ModVector3) : ModVector3 Vector addition
---@operator sub(ModVector3) : ModVector3 Vector subtraction
---@field x number X value of the vector
---@field y number Y value of the vector
---@field z number Z value of the vector
---@field Equals fun(otherVector: ModVector3): boolean Returns true if both vectors are the same, false if not (can be done with the normal `==` operator)
---@field GetHashCode fun(): integer Returns the hash code of the vector
---@field Dot fun(otherVector: ModVector3): number Returns the dot product of two vector3
---@field Cross fun(otherVector: ModVector3): ModVector3 Returns the cross product of two vector3
---@field Magnitude fun(): number Returns the magnitude/length
---@field ToString fun(): string Returns a formatted string of a vector

--- Creates a vector3 with specified values
---@param x number
---@param y number
---@param z number
---@return ModVector3
---@nodiscard
function tm.vector3.Create(x, y, z) end

--- Creates a vector3 with values defaulted to zero
---@return ModVector3
---@nodiscard
function tm.vector3.Create() end

--- Creates a vector3 pointing right (1, 0, 0)
---@return ModVector3
---@nodiscard
function tm.vector3.Right() end

--- Creates a vector3 pointing left (-1, 0, 0)
---@return ModVector3
---@nodiscard
function tm.vector3.Left() end

--- Creates a vector3 pointing up (0, 1, 0)
---@return ModVector3
---@nodiscard
function tm.vector3.Up() end

--- Creates a vector3 pointing down (0, -1, 0)
---@return ModVector3
---@nodiscard
function tm.vector3.Down() end

--- Creates a vector3 pointing forward (0, 0, 1)
---@return ModVector3
---@nodiscard
function tm.vector3.Forward() end

--- Creates a vector3 pointing back (0, 0, -1)
---@return ModVector3
---@nodiscard
function tm.vector3.Back() end

--- Flips all the signs (can be done with the normal `-` operator)
---@param vector3 ModVector3
---@return ModVector3
---@nodiscard
function tm.vector3.op_UnaryNegation(vector3) end

--- Adds first and second together (can be done with the normal `+` operator)
---@param first ModVector3
---@param second ModVector3
---@return ModVector3
---@nodiscard
function tm.vector3.op_Addition(first, second) end

--- Subtracts first and second together (can be done with the normal `-` operator)
---@param first ModVector3
---@param second ModVector3
---@return ModVector3
---@nodiscard
function tm.vector3.op_Subtraction(first, second) end

--- Multiplies the vector by the scalar (can be done with the normal `*` operator)
---@param vector3 ModVector3
---@param scalar number
---@return ModVector3
---@nodiscard
function tm.vector3.op_Multiply(vector3, scalar) end

--- Divides the vector by the divisor (can be done with the normal `/` operator)
---@param vector3 ModVector3
---@param divisor number
---@return ModVector3
---@nodiscard
function tm.vector3.op_Division(vector3, divisor) end

--- Returns true if both vectors are the same, false if not (can be done with the normal `==` operator)
---@param first ModVector3
---@param second ModVector3
---@return boolean
---@nodiscard
function tm.vector3.op_Equality(first, second) end

--- Returns true if both vectors are not the same, false if not (can be done with the normal `~=` operator)
---@param first ModVector3
---@param second ModVector3
---@return boolean
---@nodiscard
function tm.vector3.op_Inequality(first, second) end

--#endregion

--------------------- Quaternion ---------------------

--#region

--- Quaternions are for rotations, they get rid of gimbal lock that a vector3 rotation runs into. Quaternions can store 4 numbers
tm.quaternion = {}

---@class ModQuaternion Quaternion object. Quaternions are for rotations, they get rid of gimbal lock that a vector3 rotation runs into. Quaternions can store 4 numbers
---@field x number X value of the quaternion
---@field y number Y value of the quaternion
---@field z number Z value of the quaternion
---@field w number W value of the quaternion
---@field GetEuler fun(): ModVector3 Returns a vector3 representing the euler angles of the quaternion
---@field Multiply fun(otherQuaternion: ModQuaternion): ModQuaternion Multiplies two quaternions and returns the result

--- Creates a quaternion by manually defining its components
---@param x number
---@param y number
---@param z number
---@param w number
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(x, y, z, w) end

--- Creates a quaternion using euler angle components
---@param x number
---@param y number
---@param z number
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(x, y, z) end

--- Creates a quaternion using a euler angle vector3
---@param eulerAngle ModVector3
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(eulerAngle) end

--- Creates a quaternion using an angle and an axis to rotate around
---@param angle number
---@param axis ModVector3
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Create(angle, axis) end

--- Returns the resulting quaternion from a slerp between two quaternions
---@param firstQuaternion ModQuaternion
---@param secondQuaternion ModQuaternion
---@param t number Position in the interpolation (0=firstQuaternion, 1=secondQuaternion)
---@return ModQuaternion
---@nodiscard
function tm.quaternion.Slerp(firstQuaternion, secondQuaternion, t) end

--#endregion

--------------------- Callback Data ---------------------

--#region

---@class CallbackData These are all the things you can get from the argument that UI elements pass in the function you specify
---@field playerId integer Gives you the player that interacted with the element
---@field id integer Gives you the id of the interacted element
---@field type string Gives you the type of the interacted element
---@field value string Gives you the value of the interacted element. Value is the text shown on the UI element
---@field data any Gives you the data of the interacted element. You pass in this data when registering the UI element's callback

--#endregion

--------------------- Documentation ---------------------

--#region

--- Gives the unformatted documentation
---@return string
---@nodiscard
function tm.GetDocs() end

--#endregion

--------------------- ModGameObject ---------------------

--#region

---@class ModGameObject GameObject type
---@field Despawn fun(): nil Despawns the object. This can not be done on players
---@field GetTransform fun(): ModTransform Returns the GameObject's Transform
---@field SetIsVisible fun(isVisible: boolean): nil Sets visibility of the GameObject
---@field GetIsVisible fun(): boolean Gets the visibility of the GameObject
---@field GetIsRigidbody fun(): boolean Returns true if the GameObject or any of its children are rigidbodies
---@field SetIsStatic fun(isStatic: boolean): nil Sets the GameObject's and its children's rigidbodies to be static or not
---@field GetIsStatic fun(): boolean Returns true if the GameObject and all of its children are static
---@field SetIsTrigger fun(isTrigger: boolean): nil Determines whether the GameObject lets other GameObjects pass through its colliders or not
---@field Exists fun(): boolean Returns true if the GameObject exists

--#endregion

--------------------- ModTransform ---------------------

--#region

---@class ModTransform Transform type
---@field SetPosition (fun(position: ModVector3): nil) | (fun(x: number, y: number, z: number): nil) Sets the position of the Transform
---@field GetPosition fun(): ModVector3 Gets the position of the Transform
---@field SetRotation (fun(rotation: ModVector3): nil) | (fun(x: number, y: number, z: number): nil) | (fun(rotation: ModQuaternion): nil) Sets the rotation of the Transform
---@field GetRotation fun(): ModVector3 Gets the rotation of the Transform
---@field GetRotationQuaternion fun(): ModQuaternion Gets the rotation quaternion of the Transform
---@field SetScale (fun(scaleVector: ModVector3): nil) | (fun(x: number, y: number, z: number): nil) | (fun(scale: number): nil) Sets the scale of the Transform. Setting a non-uniform scale may, among other things, break the objects physics
---@field GetScale fun(): ModVector3 Gets the scale of the Transform
---@field TransformPoint fun(point: ModVector3): ModVector3 Returns the point's position in world space (Adds the current pos with input vector)
---@field TransformDirection fun(direction: ModVector3): ModVector3 Returns the direction's world space direction

--#endregion

--------------------- ModBlock ---------------------

--#region

---@class ModBlock ModBlock type
---@field SetColor fun(r: number, g: number, b: number): nil [In buildmode only] Set the block's primary color
---@field SetSecondaryColor fun(r: number, g: number, b: number): nil [In buildmode only] Set the block's secondary color
---@field SetMass fun(mass: number): nil [In buildmode only] Set the block's mass. Units are `5kg`
---@field GetMass fun(): number Get the block's mass. Units are `5kg`
---@field SetBuoyancy fun(mass: number): nil [In buildmode only] Set the block's buoyancy
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

--#endregion

--------------------- ModStructure ---------------------

--#region

---@class ModStructure ModStructure type
---@field Destroy fun(): nil Destroy the structure
---@field GetBlocks fun(): ModBlock[] Gets all blocks in the structure
---@field AddForce fun(x: number, y: number, z: number): nil Add a force to the given structure as an impulse. Units are `5kg * m/s²`

--#endregion
