local user = require "iguana.user"

local iguana_action = {}

local method = {}

local MT = {__index=method}

local function BaseUrl()
   local C = iguana.channelConfig{guid=iguana.channelGuid()}
   local X = xml.parse{data=C}
   return X.channel.from_http.mapper_url_path:S()
end

function iguana_action.create()
   local AT = {_actions={}, _priority={}}
   AT._baseurllength = #BaseUrl() +2
   setmetatable(AT, MT)
   return AT
end


function method:actions(T)
   if not T.group then 
      error("Need group", 2)
   end
   if not self._actions[T.group] then
      self._actions[T.group] = {}
   end
   self._priority[T.priority] = T.group
   return self._actions[T.group]
end

local ActionInfoHelp=[[{
   "Returns": [{"Desc": "Action table for a particular group."}],
   "Title": "RequestInfo:actions()",
   "Parameters": [
      { "group": {"Desc": "Group to return action table for."}},
      { "priority" : { "Desc" : "What priority does this permission take.  This is an integer."}}],
   "ParameterTable": true,
   "Usage": "local ActionTable = RequestInfo:actions{group='Administrators'}",
   "Examples": [
      "local RequestInfo = iguana_action.create()
local ActionTable = RequestInfo:actions{group='Administrators'}"
   ],
   "Desc": "This method returns a table of actions for a given permission."
}]]

help.set{input_function=method.actions, help_data=json.parse{data=ActionInfoHelp}}

function method:dispatch(T)
   local Request = T.path:sub(self._baseurllength)
   local User = user.open()
   for K,Group in ipairs(self._priority) do
      trace(K,Group)
      if User:userInGroup{user=T.user, group=Group} then
         if self._actions[Group][Request] then
            return self._actions[Group][Request]
         end
      end
   end
end

local DispatchInfoHelp=[[{
   "Returns": [{"Desc": "Returns function action depending on the user and their permissions."}],
   "Title": "RequestInfo:dispatch()",
   "Parameters": [
      { "path": {"Desc": "Path for action."}},
      { "user" : { "Desc" : "User requesting path"}}],
   "ParameterTable": true,
   "Usage": "local Action = RequestInfo:actions{user='Admin', path='status'}",
   "Examples": [
      "local UserInfo = user.open()
local ActionTable = RequestInfo:actions{group='Administrators'}"
   ],
   "Desc": "This method returns a table of actions for a given permission."
}]]

help.set{input_function=method.dispatch, help_data=json.parse{data=DispatchInfoHelp}}

return iguana_action