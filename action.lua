require(scriptPath() .. "constants")

-- wrapper for functions to be executed later
Action = {}
function Action:new(func, ...)
  newObj = {
    func = func or nil,
    args = {...} or {}
  }
  self.__index = self
  return setmetatable(newObj, self)
end
function Action:execute()
  if #self.args == 0 then
    self.func()
  elseif #self.args == 1 then
    self.func(self.args[1])
  elseif #self.args == 2 then
    self.func(self.args[1], self.args[2])
  else
    error("unsupported argument count", reportError.toCaller)
  end
  wait(1)
end