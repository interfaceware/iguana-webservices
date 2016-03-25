-- Consider if you want to use Iguana to act as a corporate webservice to serve up data
-- to various people in your company.

-- We can leverage the user permission system built into Iguana to do that.  Because people
-- have different roles it's nice to be able to serve up different available webservices based
-- on their role.  Also some webservice queries might serve up different data depending on
-- the role of the user.

-- We can power this off Iguana's built in user permission system by leveraging the group
-- feature.  Different requests can be mapped to different functions for different groups.

-- This channel shows how this can be done using the iguana.action and iguana.user modules.  It
-- also makes use of the basic authentication to do the authentication.

local basicauth = require 'web.basicauth'
local user = require 'iguana.user'
local actionTable = require 'iguana.action'

-- We set up the map of web requests to actions using the actionTable object.

function SetupActions()
   -- First we create it
   local Dispatcher = actionTable.create()
   -- Define the actions for Administrators
   -- Priority 1 means Administrator actions override actions defined for
   -- other groups that a user might belong to.
   local AdminActions = Dispatcher:actions{group='Administrators', priority=1}
   -- We just assign URL request paths to functions
   AdminActions[""] = AdminStatus
   AdminActions["admin"] = AdminReset
   -- Define user actions
   -- Priority 2 means these actions will not be invoked if a user also belongs
   -- to a group with lower priority permissions.
   local UserActions = Dispatcher:actions{group='User', priority=2}
   UserActions[""] = UserStatus
   -- Notice that both the Administrator and User permissions define the
   -- default "" path.  This allows us to alter behavior of what administrators
   -- see vs. normal Users.
   -- You can add additional actions tables for different user groups.
   return Dispatcher
end
   
function main(Data)
   -- Setting up the dispatcher - we could do this outside of main if we wanted
   -- to be more efficient and only call the code once when the channel starts up.
   local Dispatcher = SetupActions()
   -- Parse the HTTP request
   local R = net.http.parseRequest{data=Data}
   
   -- Check for authentication against the users defined in Iguana.     
   if not basicauth.isAuthorized(R) then
      -- We display this in the prompt to the user (somewhat browser dependent)
      basicauth.requireAuthorization("Please enter your Iguana username and password.")
      iguana.logInfo("Failed authentication.")
      return
   end
   -- Extract the user name and password
   local Auth = basicauth.getCredentials(R)
   trace(Auth.username)
   
   -- Find an action based on the user name and request 
   local Action = Dispatcher:dispatch{path=R.location,  user=Auth.username}
   if (Action) then
      if iguana.isTest() then
         -- In the editor we don't want to catch errors.
         return Action(R, Auth)
      end
      -- we will catch exceptions here
      local Success, ErrorMessage = pcall(Action, R,Auth)
      if not Success then
         net.http.respond{body=ErrorMessage, code=500}
      end
   else
      net.http.respond{body="Request refused.", code=401}
   end
end

function AdminStatus(R, A)
   net.http.respond{body="Welcome "..A.username..". You have administrative privileges."}   
end

function UserStatus(R, A)
   net.http.respond{body="Welcome user "..A.username.."."} 
end

function AdminReset(R, A)
   net.http.respond{body="Resetting system..."}
end


