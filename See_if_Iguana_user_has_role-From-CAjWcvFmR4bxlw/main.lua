-- The main function is the first function called from Iguana.
local user = require 'iguana.user'

-- The iguana.user module can be helpful if for instance you have a web service for which you need
-- to authenticate.  The module could be fleshed out more but it shows how one can query if a user
-- belongs to a given group and what their email address is.

function main()
   -- For efficiency you might want to put the user.open
   -- statement outside of the main function.
   local Info = user.open()
     
   Info:userInGroup{user='admin', group='Administrators'}
   Info:userInGroup{user='admin', group='Users'}
   Info:userInGroup{user='somefella', group='Users'}
   
   -- Here we find out the email address of a user
   local Info = Info:user{user='admin'}
   trace(Info.email)
end