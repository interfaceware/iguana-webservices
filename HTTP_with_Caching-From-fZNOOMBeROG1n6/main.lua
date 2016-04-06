-- This module is intended for people who are more experienced with Iguana and webservices
-- rather than being a beginner module.

-- The translator works on the assumption that it's possible to execute the entire Lua
-- script within a fraction of a second.  This makes it possible to generate the rich
-- annotations and intellisense that make the environent fun and efficient to use.

-- Slow webservice calls break this assumption.  So the purpose of this net.http.cache is
-- to solve this problem.  

-- It alters all the relevant net.http.* commands that are built into Iguana to introduce
-- a new cache_time parameter.  By default this is set to 0 seconds meaning there is no caching
-- if you do not use it.  

-- If it is set to be greater than 0 then results are cached in SQLite database so that we don't always have
-- to hit the webservice in question.  This makes development much faster and means less calls
-- are make to the web services in question.
--
-- This has the additional advantage that if you are using a cloud application that only allows
-- limited numbers of API calls then this greatly reduces how often Iguana is calling those API calls.

-- There are some cons.  Because results are cached, the cached results can be out of date.
-- Cached data is stored on disk which may not be desirable.

-- All the net.http.* commands support the same arguments as before - with the additional argument
-- cache_time which specifies in seconds how long cached data should be retained.


-- Requiring net.http.cache modifies the net.http.* apis to introduce the new cache_time parameter
require 'net.http.cache'

function main()
   local Response, Code, Headers = net.http.get{
      url   = 'http://www.google.com/',
      live  = true,
      cache_time = 60 -- Cache for 60 seconds
   }
   trace(Response)
   trace(Code)
   trace(Headers)
   
   -- It works with binary data too!
   local BinResponse = net.http.get{
      url='http://asd.gsfc.nasa.gov/archive/hubble/Hubble_20th.jpg', 
      cache_time=30, live=true}
   trace(BinResponse)
   -- We can access the cache here - useful if we we want to clear it etc.
   trace(net.http.cache():info())
end
