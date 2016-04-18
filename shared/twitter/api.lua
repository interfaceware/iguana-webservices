-- Please see http://help.interfaceware.com/v6/oauth-1-0-with-twitter

local oauth = require "oauth.oauth"

local twitter = {
	urls = {
	   post_tweet = 'https://api.twitter.com/1.1/statuses/update.json',
   },
   -- The algorithm to pass to Interfaceware's crypto API.
   signature_algorithm = 'sha1',
   -- The oauth signature method.
   signature_method = 'HMAC-SHA1',
}
twitter.__index = twitter

function twitter:connect(Params)
   setmetatable(Params, self)
   return Params
end

function twitter:tweet(Status)
   local AuthHeader = self:_buildHeader(self.urls.post_tweet, "POST", {status=Status})
   local Result = net.http.post{
      url        = self.urls.post_tweet,
      live       = true,
      headers    = {AuthHeader},
      parameters = {status=Status}
   }
   return json.parse{data=Result}
end

function twitter:_buildHeader(Url, Method, additional_params)
   local Timestamp = os.ts.time()
   local Nonce = oauth.makeNonce(Timestamp)

   local Key = string.format("%s&%s",
      oauth.percentEncode(self.consumer_secret),
      oauth.percentEncode(self.token_secret)
   )
   
   local Signature = oauth.buildSignature{
      url    = Url,
      key    = Key,
      nonce  = Nonce,
      method = Method,
      timestamp     = Timestamp,
      consumer_key  = self.consumer_key,
      access_token  = self.access_token,
      signature_method    = self.signature_method,
      signature_algorithm = self.signature_algorithm,
      additional_params = additional_params
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

return twitter