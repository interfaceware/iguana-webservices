-- This example shows using OAuth 2.0 using a Json Web Token for authentication.
-- This is done with the iFormBuilder application.
-- For more information see:
-- http://help.interfaceware.com/v6/oauth2-with-iformbuilder 

-- This example illustrates:
--  Caching of HTTP requests
--  OAuth 2.0
--  JWT

-- Please follow the numbered steps to see how it works.

local iFormBuilder = require 'iformbuilder.api'

function work()
   -- First authenticate and get a connection
   -- 1) Create yourself a free iFormBuilder account and get an
   --    your own 'client_key', 'client_secret' and 'profile_id'
   --    See http://help.interfaceware.com/v6/oauth2-with-iformbuilder 
   --    for instructions.
   -- 2) Click on the connect option.
   local C = iFormBuilder.connect{
      cache=false,  -- After reading the JWT code change to true for efficiency
      client_key   ='<your client key>', 
      client_secret='<your client secret>', 
      profile_id   ='<your profile id>'
   }
   -- Then we query a list of users
   local Result = C:users() 

   -- Then we format a list of the users
   local R = 'Example of Oauth 2.0 query to iFormbuilder:\n'
   for i=1,#Result.USERS do
      R = R..Result.USERS[i].NAME.."\n"
   end
   trace(R)
   net.http.respond{body=R, entity_type='text/plain'}
end   

function main(Data)
   local Success,Msg = pcall(work)
   if not Success then
      local Response = [[
      <p>
      To make this example work you will need to go to here:
      </p>   
      <a href="http://help.interfaceware.com/v6/oauth2-with-iformbuilder">http://help.interfaceware.com/v6/oauth2-with-iformbuilder</a>
      <p>   
      And follow these instructions.  The error raised was:
      </p>
      <pre>
      #ERROR#   
      </pre>
      ]]
      Response=Response:gsub("#ERROR#", Msg)
      net.http.respond{body=Response}
   end
end
