---@meta

-- Redefinitions of functions/fields from standard library modules that are partially disabled

--------------------- Basic Library ---------------------

--#region

-- Disabled functions: `dofile()`, `load()` and `loadfile()`

---Raises an error if the value of its argument v is false (i.e., `nil` or `false`); otherwise, returns all its arguments. In case of error, `message` is the error object; when absent, it defaults to `"assertion failed!"`
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-assert)
---@generic T
---@param v? T
---@param message? any
---@return T
---@return any ...
function assert(v, message, ...) end

---This function is a generic interface to the garbage collector. It performs different functions according to its first argument, `opt`.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-assert)
---@param opt? gcoptions
---@param arg? integer
---@return any
function collectgarbage(opt, arg) end

---Terminates the last protected function called and returns message as the error object.
---
---Usually, `error` adds some information about the error position at the beginning of the message, if the message is a string.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-error)
---@param message any
---@param level?  integer
function error(message, level) end

---@class _G
_G = {}

---If object does not have a metatable, returns nil. Otherwise, if the object's metatable has a __metatable field, returns the associated value. Otherwise, returns the metatable of the given object.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-getmetatable)
---@param object any
---@return table metatable
---@nodiscard
function getmetatable(object) end

---Returns three values (an iterator function, the table `t`, and `0`) so that the construction
---```lua
---    for i,v in ipairs(t) do body end
---```
---will iterate over the key–value pairs `(1,t[1]), (2,t[2]), ...`, up to the first absent index.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-ipairs)
---@generic T: table, V
---@param t T
---@return fun(table: V[], i?: integer):integer, V
---@return T
---@return integer i
function ipairs(t) end

---Allows a program to traverse all fields of a table. Its first argument is a table and its second argument is an index in this table. A call to `next` returns the next index of the table and its associated value. When called with `nil` as its second argument, `next` returns an initial index and its associated value. When called with the last index, or with `nil` in an empty table, `next` returns `nil`. If the second argument is absent, then it is interpreted as `nil`. In particular, you can use `next(t)` to check whether a table is empty.
---
---The order in which the indices are enumerated is not specified, *even for numeric indices*. (To traverse a table in numerical order, use a numerical `for`.)
---
---The behavior of `next` is undefined if, during the traversal, you assign any value to a non-existent field in the table. You may however modify existing fields. In particular, you may set existing fields to nil.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-next)
---@generic K, V
---@param table table<K, V>
---@param index? K
---@return K?
---@return V?
---@nodiscard
function next(table, index) end

---If `t` has a metamethod `__pairs`, calls it with t as argument and returns the first three results from the call.
---
---Otherwise, returns three values: the [next](http://www.lua.org/manual/5.2/manual.html#pdf-next) function, the table `t`, and `nil`, so that the construction
---```lua
---    for k,v in pairs(t) do body end
---```
---will iterate over all key–value pairs of table `t`.
---
---See function [next](http://www.lua.org/manual/5.2/manual.html#pdf-next) for the caveats of modifying the table during its traversal.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-pairs)
---@generic T: table, K, V
---@param t T
---@return fun(table: table<K, V>, index?: K):K, V
---@return T
function pairs(t) end

---Calls the function `f` with the given arguments in *protected mode*. This means that any error inside `f` is not propagated; instead, `pcall` catches the error and returns a status code. Its first result is the status code (a boolean), which is true if the call succeeds without errors. In such case, `pcall` also returns all results from the call, after this first result. In case of any error, `pcall` returns `false` plus the error object.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-pcall)
---@param f async fun(...):...
---@param arg1? any
---@return boolean success
---@return any result
---@return any ...
function pcall(f, arg1, ...) end

---Receives any number of arguments and prints their values to `stdout`, converting each argument to a string following the same rules of [tostring](http://www.lua.org/manual/5.2/manual.html#pdf-tostring).
---The function print is not intended for formatted output, but only as a quick way to show a value, for instance for debugging. For complete control over the output, use [string.format](http://www.lua.org/manual/5.2/manual.html#pdf-string.format) and [io.write](http://www.lua.org/manual/5.2/manual.html#pdf-io.write).
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-print)
function print(...) end

---Checks whether v1 is equal to v2, without invoking the `__eq` metamethod.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-rawequal)
---@param v1 any
---@param v2 any
---@return boolean
---@nodiscard
function rawequal(v1, v2) end

---Gets the real value of `table[index]`, without invoking the `__index` metamethod.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-rawget)
---@param table table
---@param index any
---@return any
---@nodiscard
function rawget(table, index) end

--- Returns the length of the object `v`, without invoking the `__len` metamethod.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-rawlen)
---@param v table|string
---@return integer len
---@nodiscard
function rawlen(v) end

---Sets the real value of `table[index]` to `value`, without using the `__newindex` metavalue. `table` must be a table, `index` any value different from `nil` and `NaN`, and `value` any Lua value.
---This function returns `table`.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-rawset)
---@param table table
---@param index any
---@param value any
---@return table
function rawset(table, index, value) end

---If `index` is a number, returns all arguments after argument number `index`; a negative number indexes from the end (`-1` is the last argument). Otherwise, `index` must be the string `"#"`, and `select` returns the total number of extra arguments it received.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-select)
---@param index integer|"#"
---@return any
---@nodiscard
function select(index, ...) end

---Sets the metatable for the given table. If `metatable` is `nil`, removes the metatable of the given table. If the original metatable has a `__metatable` field, raises an error.
---
---This function returns `table`.
---
---To change the metatable of other types from Lua code, you must use the debug library ([§6.10](http://www.lua.org/manual/5.2/manual.html#6.10)).
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-setmetatable)
---@param table table
---@param metatable? metatable|table
---@return table
function setmetatable(table, metatable) end

---When called with no `base`, `tonumber` tries to convert its argument to a number. If the argument is already a number or a string convertible to a number, then `tonumber` returns this number; otherwise, it returns `fail`.
---
---The conversion of strings can result in integers or floats, according to the lexical conventions of Lua (see [§3.1](http://www.lua.org/manual/5.2/manual.html#3.1)). The string may have leading and trailing spaces and a sign.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-tonumber)
---@overload fun(e: string, base: integer):integer
---@param e any
---@return number?
---@nodiscard
function tonumber(e) end

---Receives a value of any type and converts it to a string in a human-readable format.
---
---If the metatable of `v` has a `__tostring` field, then `tostring` calls the corresponding value with `v` as argument, and uses the result of the call as its result. Otherwise, if the metatable of `v` has a `__name` field with a string value, `tostring` may use that string in its final result.
---
---For complete control of how numbers are converted, use [string.format](http://www.lua.org/manual/5.2/manual.html#pdf-string.format).
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-tostring)
---@param v any
---@return string
---@nodiscard
function tostring(v) end

---Returns the type of its only argument, coded as a string. The possible results of this function are `"nil"` (a string, not the value `nil`), `"number"`, `"string"`, `"boolean"`, `"table"`, `"function"`, `"thread"`, and `"userdata"`.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-type)
---@param v any
---@return type type
---@nodiscard
function type(v) end

---A global variable (not a function) that holds a string containing the running Lua version.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-_VERSION)
_VERSION = "MoonSharp 2.0.0.0"

---Calls function `f` with the given arguments in protected mode with a new message handler.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-xpcall)
---@param f     async fun(...):...
---@param msgh  function
---@param arg1? any
---@return boolean success
---@return any result
---@return any ...
function xpcall(f, msgh, arg1, ...) end

--#endregion

--------------------- Package Library ---------------------

--#region

---@class packagelib
---A table used by `require` to control which modules are already loaded.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-package.loaded)
---@diagnostic disable-next-line: duplicate-doc-field
---@field loaded table
package = {}

--#endregion

--------------------- OS Library ---------------------

--#region

os = {}

---Returns an approximation of the amount in seconds of CPU time used by the program.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-os.clock)
---@return number
---@nodiscard
function os.clock() end

---Returns a string or a table containing date and time, formatted according to the given string `format`.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-os.date)
---@param format? string
---@param time?   integer
---@return string|osdate
---@nodiscard
function os.date(format, time) end

---Returns the difference, in seconds, from time `t1` to time `t2`.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-os.difftime)
---@param t2 integer
---@param t1 integer
---@return integer
---@nodiscard
function os.difftime(t2, t1) end

---Returns the current time when called without arguments, or a time representing the local date and time specified by the given table.
---
---[View documents](http://www.lua.org/manual/5.2/manual.html#pdf-os.time)
---@param date? osdate
---@return integer
---@nodiscard
function os.time(date) end

--#endregion