-- This inserts a new getCached function into the net.http namespace.
-- i.e. net.http.getCached
require 'net.http.getCached'

-- This module is intended for people who are more experienced with Iguana and webservices
-- rather than being a beginner module.

-- The translator works on the assumption that it's possible to execute the entire Lua
-- script within a fraction of a second.  This makes it possible to generate the rich
-- annotations and intellisense that make the environent fun and efficient to use.
--
-- Slow webservice calls break this assumption.  So the purpose of this net.http.getCached is
-- to solve this problem.  Results are cached in SQLite database so that we don't always have
-- to hit the webservice in question.  This makes development much faster and means less calls
-- are make to the web services in question.
-- 
-- There are some cons.  Because results are cached, the cached results can be out of date.
-- Cached data is stored on disk which may not be desirable.
-- 
-- net.http.getCached supports the same arguments as net.http.get - with the additional argument
-- cache_time which specifies in seconds how long cached data should be retained.

function main()
   -- Just making a web call to google with some dummy data
   local Result = net.http.getCached{url="http://www.google.com/", 
                     headers={acme="livelong"}, 
                     parameters={a="1", b="2", c="3"}, 
                     auth={username="foo", password="secret"}, 
                     live=true, cache_time=60}
   
   trace(Result)
   
   local R = net.http.cache():info()
   trace("The cache has "..#R.." entries.")
   
   -- We can reset the cache with this line
   --net.http.cache():reset()
end