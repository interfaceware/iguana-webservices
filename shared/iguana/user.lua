local user = {}

local method = {}

local MT = {__index=method}

-- Load and parse the IguanaConfiguration file for group information
local function LoadUserPermissions()
   local Reg = {}
   Reg._user = {}
   local Path = iguana.workingDir()..'IguanaConfigurationRepo/IguanaConfiguration.xml'
   local F = io.open(Path, "r")
   local C = F:read("*a")
   F:close()
   local X = xml.parse{data=C}

   for g=1, X.iguana_config.auth_config:childCount("group") do
      Reg[X.iguana_config.auth_config:child("group",g).name:S()] = {}
   end
   trace(Reg)
   
   for i=1, X.iguana_config.auth_config:childCount("user") do
      local U = X.iguana_config.auth_config:child("user", i)
      Reg._user[U.name:S()] = {email=U.email_address:S()}
      for g=1, U:childCount("group") do
         Reg[U:child("group", g).name:S()][U.name:S()] = true
      end
   end
   trace(Reg) 
   return Reg
end


function user.open()
   local R = {}
   setmetatable(R, MT)
   MT.info = LoadUserPermissions()   
   return R
end

local OpenHelp=[[{
   "Returns": [{"Desc": "Returns object to query user permissions."}],
   "Title": "user.open()",
   "Parameters": [],
   "ParameterTable": false,
   "Usage": "local UserInfo = user.open()",
   "Examples": [
      "local UserInfo = user.open()
if UserInfo:userInGroup{user='fred', group='Users'} then
   trace('Yes - he is a user!')
end"
   ],
   "Desc": "This function loads the Iguana user database and allows one to query roles."
}]]

help.set{input_function=user.open, help_data=json.parse{data=OpenHelp}}


function method:userInGroup(T)
   local User = T.user
   local Group = T.group
   local Info = getmetatable(self).info
   if not Info[Group] then 
      return false
   end
      
   return Info[Group][User] or false
end

local UserInGroupHelp=[[{
   "Returns": [{"Desc": "Returns true if the given user is a member of a group."}],
   "Title": "UserInfo:userInGroup()",
   "Parameters": [
      { "user": {"Desc": "Name of user to check."}},
      { "group": { "Desc": "Name of group to check if they have membership of."}}],
   "ParameterTable": true,
   "Usage": "UserInfo:userInGroup{user='fred', group='Administrators'}",
   "Examples": [
      "local UserInfo = user.open()
if UserInfo:userInGroup{user='fred', group='Users'} then
   trace('Yes - he is a user!')
end"
   ],
   "Desc": "This method confirms if user belongs to a given group."
}]]

help.set{input_function=method.userInGroup, help_data=json.parse{data=UserInGroupHelp}}

function method:user(T)
   local User = T.user
   local Info = getmetatable(self).info
   return Info._user[User]
end

local UserInfoHelp=[[{
   "Returns": [{"Desc": "Information on a user - just email currently."}],
   "Title": "UserInfo:userInGroup()",
   "Parameters": [
      { "user": {"Desc": "Name of user to check."}}],
   "ParameterTable": true,
   "Usage": "local Info = UserInfo:user{user='fred'}",
   "Examples": [
      "local UserInfo = user.open()
local Info = UserInfo:user{user='fred'}
if (Info) then
   trace('Email is Info.email')
end"
   ],
   "Desc": "This method returns information on the user."
}]]

help.set{input_function=method.user, help_data=json.parse{data=UserInfoHelp}}




return user