-- Notice that the namespace for the module matches the module name - i.e. basicauth
-- When we use it within the code it is desirable to do:
-- basicauth = require 'basicauth'
-- Since this keeps the name of the module very consistent.

-- Basic authentication is part of the HTTP protocol.  See this reference:
-- http://en.wikipedia.org/wiki/Basic_access_authentication

-- This module takes the user name and password from the user and validates the user id
-- against the local Iguana user id.  If an invalid user name and password is given it won't be possilble to login.
local basicauth = {}
 
local function getCreds(Headers)
   if not Headers.Authorization then
      return false
   end
   local Auth64Str = Headers.Authorization:sub(#"Basic " + 1)
   local Creds = filter.base64.dec(Auth64Str):split(":")
   local Host = Headers.Host:split(':')[1]   --this is kinda funny cuz it can read as localhost
   return {username=Creds[1], password=Creds[2]}, Host
end
 
function basicauth.isAuthorized(Request)
   local Credentials, Host = getCreds(Request.headers)
   if not Credentials then
      return false
   end
   -- webInfo requires Iguana 5.6.4 or above
   local WebInfo = iguana.webInfo()  
   -- TODO - it would be really nice if we could have a Lua API
   -- to do this against the local Iguana instance - it would be
   -- a tinsy winsy bit faster.
   local UrlBase = "http"
   if WebInfo.web_config.use_https then
       UrlBase = "https"  
   end
   iguana.logInfo("Authenticating with ".. Credentials.username..":"..Credentials.password)
   local Status, Code = net.http.post{
      url= UrlBase..'://localhost:'..WebInfo.web_config.port..'/status',
      parameters={username=Credentials.username, password=Credentials.password},
      live=true}
   if (Code ~= 200) then
      iguana.logInfo("Failed authentication")
      iguana.logInfo(Status)
   end
   
   return Code == 200
end

function basicauth.requireAuthorization(ErrorMessage)
   ErrorMessage = ErrorMessage or "Enter your Iguana username and password"
   net.http.respond{
      code=401,
      headers={["WWW-Authenticate"]='Basic realm='..ErrorMessage}, 
      body="Please Authenticate"}
end

function basicauth.getCredentials(HttpMsg)
   return getCreds(HttpMsg.headers)
end

return basicauth
