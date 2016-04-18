-- See http://help.interfaceware.com/v6/oauth-with-xero 

local oauth = require 'oauth.oauth'

-- Xero "class"
local xero = {
   urls = {
      users = 'https://api.xero.com/api.xro/2.0/Users',
      -- More API urls here ...
   },
   -- The algorithm to pass to Interfaceware's crypto API.
   signature_algorithm = 'sha1',
   -- The oauth signature method.
   signature_method = 'RSA-SHA1',
   access_token = "",
   private_key_path = iguana.project.files()["other/privatekey.pem"] or "upload your private certificate!",
}
xero.__index = xero

-- Constructor for Xero API objects.
function xero:connect(Params)
   local NewObj = Params or {}
   setmetatable(NewObj, self)
   -- Xero happens to use the same value for the OAuth
   -- access token and the consumer key.
   NewObj.access_token = NewObj.consumer_key
   return NewObj
end

-- API calls
function xero:users()
   local AuthHeader = self:_signHeader(self.urls.users, "GET")
   
   local Result, Code = net.http.get{
      url = self.urls.users,
      live = true,
      headers = { AuthHeader }
   }
   
   if Code ~= 200 then
      -- Xero errors are percent encoded which conflicts with Lua patterns.
      error("Request failed. Result = " .. Result:gsub("%%20", "+"))
   end
   
   return xml.parse{data=Result}
end
-- Private helpers (needs to use "self")
function xero:_signHeader(Url, Method)
   local Timestamp = os.ts.time()
   local Nonce = oauth.makeNonce(Timestamp)

   local Signature = oauth.buildSignature{
      url    = Url,
      key    = oauth.readCertificate(self.private_key_path),
      nonce  = Nonce,
      method = Method,
      timestamp     = Timestamp,
      consumer_key  = self.consumer_key,
      access_token  = self.access_token,
      signature_method    = self.signature_method,
      signature_algorithm = self.signature_algorithm,
   }

   local AuthHeader = oauth.buildAuthHeader{
      signature = Signature,
      nonce     = Nonce,
      timestamp = Timestamp,
      consumer_key = self.consumer_key,
      access_token = self.access_token,
      signature_method = self.signature_method,
   }
   
   return AuthHeader
end

return xero
