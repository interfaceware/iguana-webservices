-- This API module shows how we can use Iguana to talk to the iFormBuilder Web API.
-- For more information see:
-- http://help.interfaceware.com/v6/oauth2-with-iformbuilder 
-- This API makes use of OAuth 2.0 using a Json Web Token (JWT) for authentication

-- We use the store2 module to store the access token 
local store = require 'store2'
local jwt = require "oauth.jwt"

-- Warning - this will alter the behavior of the built in net.http APIs
require 'net.http.cache'

local TokenStore = store.connect(iguana.project.guid()..'_token')

function GetCachedToken()
   local ExpiryTime = TokenStore:get("expiry_time")
   if ExpiryTime and tonumber(ExpiryTime) > os.ts.gmtime() then
      trace('We are using a cached access token.')
      return TokenStore:get("access_token")
   end 
   return nil
end

-- 4) Carefully trace through all the steps to see how we create
--    a Json Web Token to do the OAuth authentication
local function fetchAccessToken(ClientKey, ClientSecret, CacheToken)
   -- First see if we have a cached access token we can use     
   local RequestToken = GetCachedToken()
   if CacheToken and RequestToken then return RequestToken end
 
   local IssuedAt  = os.ts.gmtime()
   local ExpiresAt = IssuedAt + 60 * 9
   local Url = "https://www.iformbuilder.com/exzact/api/oauth/token"
   local Payload={iss=ClientKey, aud=Url,
                  exp=ExpiresAt, iat=IssuedAt }
   trace("iss="..ClientKey)
   trace("aud="..Url)
   trace("Expiry:    exp="..ExpiresAt)
   trace("Issued at: iat="..IssuedAt)
   trace(Payload)
   -- 5) See how the signature is generated.
   local Token = jwt.sign{header={alg="HS256", typ="JWT"}, payload=Payload,
                          algo="HS256", key=ClientSecret}
   trace(Token)
   local GrantType = "urn:ietf:params:oauth:grant-type:jwt-bearer"
   local Params = {grant_type=GrantType, assertion=Token}
   
	local R, Code = net.http.post{live=true, url=Url, parameters=Params}
   R = json.parse{data=R}
   if Code == 200 then
      local ExpireTime = os.ts.gmtime() + R.expires_in
      TokenStore:put("access_token", R.access_token)
      TokenStore:put("expiry_time", ExpireTime)
   end
   
   trace(R.access_token)
   return R.access_token
end

local Method = {}
local MT = {__index=Method}

local iformbuilder={}

function iformbuilder.connect(T)
   local R = {}
   local Cache = T.cache
   if Cache == nil then Cache = true end
   -- 3) Click on fetchAccessToken
   R.access_token = fetchAccessToken(T.client_key, T.client_secret, Cache)
   if not R.access_token then
      error('Failed to authenticate', 2)
   end
   trace("Access token: "..R.access_token)
   R.profile_id = T.profile_id
   setmetatable(R, MT)
   return R
end

-- Help documentation for jwt.sign
local IFormBuilderConnectHelp = {
   Title = "iformbuilder.connect",
   Usage = "iformbuilder.connect{client_key=&lt;Client Key&gt;, client_secret=&lt;Client Secret&gt;, profile_id=&lt;Profile Id&gt;}}",
   Desc  = [[
Creates a iFormbuilder connection using OAuth 2.0 and JWT. To get the parameters to put into this API object
you will need to set up an API client within the iFormBuilder administration portal.  Read our help for more
information on doing this.
   ]],
   ParameterTable = true,

   Parameters = {
      { client_key        = { Desc='Client key for iFormBuilder API<u>string</u>.'    }},
      { client_secret     = { Desc='Client secret for iFormBuilder API<u>string</u>.' }},
      { profile_id        = { Desc='Profile id for API iFormBuilder API<u>string</u>.'}},
      { cache             = { Desc='Cache request token - default true<u>boolean</u>.', Opt=true}},
   },

   Returns   = {
      { Desc = 'Connection object to iFormBuilder API <u>string</u>' }
   },
      
   SeeAlso={{Title="iFormBuilder - OAuth 2.0 Authentication with JWT", 
             Link="http://help.interfaceware.com/v6/oauth2-with-iformbuilder"}},
}

help.set{input_function=iformbuilder.connect, help_data=IFormBuilderConnectHelp}

-- We have one example method created here.  To create convenience methods for other APIs go to
-- https://iformbuilder.zendesk.com/hc/en-us/sections/200330890-API-Documentation
function Method.users(self)
   local FetchUsersUrl = "https://www.iformbuilder.com/exzact/api/profiles/"..self.profile_id.. "/users"
   -- Setup the request parameters as per the API you are using. This call fetches all users in the specified
   -- iFormBuilder user group.
   -- See https://iformbuilder.zendesk.com/hc/en-us/articles/201702990-User-API-5-1#u2
   local Result = net.http.get{
      cache_time = 3600,
      url     = FetchUsersUrl,
      live    = true,
      headers = {"Authorization: Bearer " .. self.access_token, "X-IFORM-API-VERSION: 5.1"}
   }
   Result = json.parse{data=Result}
   return Result
end

return iformbuilder