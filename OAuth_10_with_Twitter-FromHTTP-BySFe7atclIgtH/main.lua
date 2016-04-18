-- This example shows how to use the Twitter API using OAuth 1.0.
-- For more information see:
-- See http://help.interfaceware.com/v6/oauth-1-0-with-twitter

-- This example illustrates:
--   Posting a tweet using a signed OAuth 1 request.

local twitter = require 'twitter.api'

local ArticleLink = "http://article-link-goes-here"

function work(Status)
	local Status = Status or "You can pass a status in the query string or put it here."
   local C = twitter:connect{
      consumer_key    = 'Your consumer key',
      consumer_secret = 'Your consumer secret',
      access_token    = 'Your access token',
      token_secret    = 'Your token secret',
   }

   -- Then we query a list of users
   local TweetResult = C:tweet(Status) 
   -- Then we format a list of the users
   local Response = 'Example of Oauth 1.0 post to Twitter:\n--\n\n'
   Response = Response .. json.serialize{data=TweetResult}
	trace(Response)
   net.http.respond{body=Response, entity_type='text/plain'}
end   

function main(Data)
   local Status = net.http.parseRequest{data=Data}.params.status
   local Success,Msg = pcall(work, Status)
   if not Success then
      local Response = [[
      <p>
      To make this example work you will need to go to here:
      </p>   
      <a href="#LINK#">#LINK#</a>
      <p>   
      And follow these instructions.  The error raised was:
      </p>
      <pre>
      #ERROR#   
      </pre>
      ]]
      Response=Response:gsub("#LINK#", ArticleLink)
      Response=Response:gsub("#ERROR#", Msg)
      trace(Response)
      net.http.respond{body=Response}
   end
end
