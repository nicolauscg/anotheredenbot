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
  self.func(unpack(self.args))
  wait(1)
end