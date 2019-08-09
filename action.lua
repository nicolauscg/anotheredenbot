require(scriptPath() .. "constants")

-- wrapper for functions to be executed later
Action = {}
function Action:new(func, ...)
  local newObj = {
    func = func or nil,
    args = {...} or {}
  }
  self.__index = self
  return setmetatable(newObj, self)
end
function Action:execute()
  self:func(table.unpack(args))
end