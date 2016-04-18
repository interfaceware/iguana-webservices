-- Please see http://help.interfaceware.com/v6/oauth-1-0-with-twitter

local oauth = {}

-- Read in the whole file, close it and return its contents.
oauth.readCertificate = function(Path)
   local File = io.open(Path)
   local Data = File:read("*a")
   File:close()
   return Data
end

-- Generate a nonce. See https://en.wikipedia.org/wiki/Cryptographic_nonce.
oauth.makeNonce = function(InputData)
   return filter.hex.enc(crypto.digest{data=tostring(InputData), algorithm='sha1'})
end

-- Using + instead of %20 is outdated and breaks OAuth. This ensures that
-- spaces are encoded as %20 and not +. The proper version is known as
-- percent encoding.
local function percentEncode(Data)
   local StrictResultData = filter.uri.enc(Data)
   StrictResultData = StrictResultData:gsub("+", "%%20")
   return StrictResultData
end

-- The following steps are specified by the OAauth RFC for building
-- the parameter string to be used in the signature base.
-- See https://tools.ietf.org/html/rfc5849#section-3.4.1.3.2
local function makeOAuthParamStr(Table)
   -- 1. URI encode the keys and values.
   EncodedTable = {}
   for k,v in pairs(Table) do
      EncodedTable[percentEncode(k)] = percentEncode(tostring(v))
   end

   -- 2. Sort alphabetically by key. In Lua this requires building an
   --    array using the keys, sorting it, then using that array to 
   --    index the table.
   local SortedKeys = {}
   for Key in pairs(Table) do
      table.insert(SortedKeys, Key)
   end

   table.sort(SortedKeys)

   -- 3. Build the string into a standard GET query string.
   local Out = ""
   for i in ipairs(SortedKeys) do
      Out = Out .. SortedKeys[i] .. "=" .. EncodedTable[SortedKeys[i]] .. "&"
   end

   -- Remove the final ampersand.
   Out = Out:sub(1, -2)
   trace(Out)

   return Out
end

oauth.buildSignature = function(Params)
   -- 1. Build the sorted parameter string.
   -- 1.a Gather all the arguments.
   local OAuthParams = {
      oauth_nonce            = Params.nonce,
      oauth_consumer_key     = Params.consumer_key,
      oauth_signature_method = Params.signature_method,
      oauth_timestamp        = Params.timestamp,
      oauth_token            = Params.access_token,
      oauth_version          = "1.0",
   }
  
   if Params.additional_params then
      for k,v in pairs(Params.additional_params) do
	      OAuthParams[k] = v
      end
   end

   -- 1.b makeOauthParamStr handles the details of OAuth.
   --     See it's implementation if you're interested.
   local OAuthParamString = makeOAuthParamStr(OAuthParams)

   -- 2. Build the signature base string.
   local SignatureBase = string.format("%s&%s&%s",
      Params.method,                      -- 2.a Start with the HTTP method (uppercase).
      percentEncode(Params.url),        -- 2.b Append the percent encoded URL.
      percentEncode(OAuthParamString) -- 2.c Append the percent encoded argument string.
   )
   
   -- 3. Read the private key off disk.
   --local PrivateKey = h.readAll(self.private_key_path)
   
   -- 4. Generate the signature.
   local SignatureOperation
   if Params.signature_method:find("HMAC") then
      SignatureOperation = crypto.hmac
   else
      SignatureOperation = crypto.sign
   end

   local Sig = SignatureOperation{
      key       = Params.key,
      data      = SignatureBase,
      algorithm = Params.signature_algorithm
   }

   -- 4.a Base64 encode the binary signature.
   return filter.base64.enc(Sig)
end

oauth.buildAuthHeader = function(Params)
   -- 5. Build the header string. Note that the header string contains
   --    oauth_signature but the sorted argument string does not.
   local AuthHeaderFormat    =  'OAuth '
                             .. 'oauth_consumer_key="%s", '
                             .. 'oauth_nonce="%s", '
                             .. 'oauth_signature="%s", '
                             .. 'oauth_token="%s", '
                             .. 'oauth_signature_method="%s", '
                             .. 'oauth_timestamp="%s", '
                             .. 'oauth_version="1.0"'
   -- 5.a Substitute the proper values.
   AuthHeaderValue = string.format(AuthHeaderFormat,
      Params.consumer_key,
      Params.nonce,
      percentEncode(Params.signature),
      Params.access_token,
      Params.signature_method,
      Params.timestamp
   )
   
   return "Authorization: " .. AuthHeaderValue
end

-- This is useful in other places also.
oauth.percentEncode = percentEncode

return oauth
