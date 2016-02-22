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

local basicauth_isAuthorized=[[{
   "Desc": "Checks if the specified user is authorized, using the Iguana user database. 
            Returns <b>true</b> if authorized, otherwise <b>false</b>.<p>
            <b>Note:</b> You can modify the code to use a dfferent form of authentication if required",
   "Returns": [{
         "Desc": "<b>true</b> if authorized, otherwise <b>false</b> <u>boolean</u>"
      }
   ],
   "SummaryLine": "Checks if the specified user is authorized",
   "SeeAlso": [
      {
         "Title": "Basic authentication",
         "Link": "http://help.interfaceware.com/v6/basic-authentication"
      }
   ],
   "Title": "basicauth.isAuthorized",
   "Usage": "basicauth.isAuthorized(AuthorizationRequest)",
   "Parameters": [
      {
         "AuthorizationRequest": {"Desc": "Parsed data from a GET authorization request <u>table</u>. "}
      }
   ],
   "Examples": [
      "<pre>   -- Check authorization and do some error handling if authorization fails
   -- in this case we use basicauth.requireAuthorization to ask the user to
   -- (re)enter their login details and log an informational error message<br>
   if not basicauth.isAuthorized(R) then
      -- We display this in the prompt to the user (somewhat browser dependent)
      basicauth.requireAuthorization(\"Please enter your Iguana username and password.\")
      iguana.logInfo(\"Failed authentication.\")
      return
   end</pre>"
   ],
   "ParameterTable": false
}]]

help.set{input_function=basicauth.isAuthorized, help_data=json.parse{data=basicauth_isAuthorized}}    

local basicauth_getCredentials=[[{
   "Desc": "Extracts the credentials from a parsed GET authorization request.",
   "Returns": [
         {"Desc": "A table containing username and password <u>table</u>."},
         {"Desc": "The name or IP address of the host that the authorization request originated from <u>string</u>."}
   ],
   "SummaryLine": "Extract credentials from an authorization request",
   "SeeAlso": [
      {
         "Title": "Basic authentication",
         "Link": "hthttp://help.interfaceware.com/v6/basic-authentication"
      }
   ],
   "Title": "basicauth.getCredentials",
   "Usage": "local Auth, Host = basicauth.getCredentials(AuthorizationRequest)",
   "Parameters": [
      {
         "DOB": {"Desc": "Date of birth <u>string</u>. "}
      }
   ],
   "Examples": [
      "<pre>local Auth, Host = basicauth.getCredentials(AuthorizationRequest)</pre>"
   ],
   "ParameterTable": false
}]]

help.set{input_function=basicauth.getCredentials, help_data=json.parse{data=basicauth_getCredentials}}    

local basicauth_requireAuthorization=[[{
   "Desc": "Request authorization details (username and password) from the user.",
   "Returns": [],
   "SummaryLine": "Request authorization details from the user",
   "SeeAlso": [
      {
         "Title": "Basic authentication",
         "Link": "http://help.interfaceware.com/v6/basic-authentication"
      }
   ],
   "Title": "basicauth.requireAuthorization",
   "Usage": "basicauth.requireAuthorization()",
   "Parameters": [
      {
         "ErrorMessage": {"Desc": "Informational login message for the user <u>string</u>. "}
      }
   ],
   "Examples": [
      "<pre>   -- Check authorization and do some error handling if authorization fails
   -- in this case we use basicauth.requireAuthorization to ask the user to
   -- (re)enter their login details and log an informational error message<br>
   if not basicauth.isAuthorized(R) then
      -- We display this in the prompt to the user (somewhat browser dependent)
      basicauth.requireAuthorization(\"Please enter your Iguana username and password.\")
      iguana.logInfo(\"Failed authentication.\")
      return
   end</pre>"
   ],
   "ParameterTable": false
}]]

help.set{input_function=basicauth.requireAuthorization, help_data=json.parse{data=basicauth_requireAuthorization}}    

return basicauth
