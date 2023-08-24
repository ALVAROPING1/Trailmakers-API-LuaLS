---@meta

-- Additions to Lua made by moonsharp (interpreter used by the game to run lua)

--------------------- Moonsharp Table ---------------------

--#region

---Table with information related to Moonsharp
_MOONSHARP = {}

---Version of the Moonsharp interpreter
_MOONSHARP.version = "2.0.0.0"

---Lua version emulated
_MOONSHARP.luacompat = "5.2"

---Name of the platform in which moonsharp is running
_MOONSHARP.platform = "limited.unity.dll.mono.clr4.aot"

---Whether moonsharp is running in an aot platform
_MOONSHARP.is_aot = true

---Whether moonsharp is running inside Unity
_MOONSHARP.is_unity = true

---Whether moonsharp is running on Mono
_MOONSHARP.is_mono = true

---Whether moonsharp is running on .NET 4.x
_MOONSHARP.is_clr4 = true

---Whether moonsharp is running as a portable class library
_MOONSHARP.is_pcl = false

--#endregion

--------------------- Global Functions ---------------------

--#region

pack = table.pack
unpack = table.unpack

--#endregion

--------------------- String Module ---------------------

--#region

---Returns unicode code of each character in a segment of a string
---@param string string Input string
---@param i integer? Index of the first character in the segment. 1 by default
---@param j integer? Index of the last character in the segment. 1 by default
---@return integer ... Unpacked unicode codes
function string.unicode(string, i, j) end

---Returns whether str2 is contained in str1
---@param str1 string
---@param str2 string
---@return boolean
---@nodiscard
function string.contains(str1, str2) end

---Returns whether str1 starts with str2
---@param str1 string
---@param str2 string
---@return boolean
---@nodiscard
function string.startsWith(str1, str2) end

---Returns whether str1 ends with str2
---@param str1 string
---@param str2 string
---@return boolean
---@nodiscard
function string.endsWith(str1, str2) end

--#endregion

--------------------- Dynamic Module ---------------------

--#region

---Module for expression evaluation at runtime
dynamic = {}

---@class ExpressionObject Expression object containing a parsed expression

---Evaluates and executes the given expression. The expression can be any valid single lua expression, but isn't allowed to define/call any functions. The evaluation is guaranteed to be side-effects free
---
---**Warning**: parsing a `string` expression has a significant performance cost over normal lua code. It's advised to use normal code where possible, and, if this expression will be evaluated several times, it's recommended to transform the `string` into a `ExpressionObject` with `dynamic.prepare()` once beforehand and reuse that as necessary
---@param expression string | ExpressionObject Expression to evaluate
---@return any Result The result of evaluating the expression
---@nodiscard
function dynamic.eval(expression) end

---Creates a prepared `ExpressionObject` for faster execution when passed to `dynamic.eval()` than using the `string` directly
---
---Note: `dynamic.eval(dynamic.prepare(<expression>))` is equivalent in performance to `dynamic.eval(<expression>)`. Only use if you are going to cache the result
---@param expression string Expression to parse
---@return ExpressionObject Result Prepared expression
---@nodiscard
function dynamic.prepare(expression) end

--#endregion

--------------------- JSON Module ---------------------

--#region

---Module for parsing/serializing JSON strings
json = {}

---@class JSONNull Representation of a Null value on a JSON

---Parses a JSON string and returns it as a lua table
---@param json string
---@return table
---@nodiscard
function json.parse(json) end

---Serializes a lua table to a JSON string
---@param table table
---@return string
---@nodiscard
function json.serialize(table) end

-- This function appears in the moonsharp documentation, but isn't functional in game
-- --- Checks whether the value is the special value representing a Null in a JSON
-- ---@param value any
-- ---@return boolean
-- function json.isNull(value) end

---Returns a special value which represents a Null in a JSON
---@return JSONNull
---@nodiscard
function json.null() end

--#endregion
