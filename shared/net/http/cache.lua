-- net.http.cache adds local caching to the net.http API built into Iguana
-- It makes use of a local SQLite database in the store2 module to do so.
-- See http://help.interfaceware.com/v6/http-caching 
-- To understand the value of the HTTP caching that this gives support for.

local store = require 'store2'

local function findItem(Array, Key)
	for i=1, #Array do 
      if Array[i][Key] then 
         return true
      end
   end
   return false
end
local DbPath = iguana.project.guid()..'.http.cache'
local Cache  = store.connect(DbPath)

local CacheHelp = {
   cache_time = {
      Opt  = true,
      Desc = 'When greater than zero, responses are cached in a local database to speed up annotations (default = 0) <u>integer - seconds</u>.'
   }
}

local NetHttpList ={'post', 'delete', 'options', 'head', 'patch', 'trace', 'put', 'get'}
for i=1,#NetHttpList do
   local Name = NetHttpList[i]
   local Func = net.http[Name]
   local h = help.get(Func)
   -- Override net.http.* to check the cache before making a request
   net.http[Name] = function(Args)
      if not iguana.isTest() or not Args.cache_time or Args.cache_time == 0 then
         Args.cache_time = nil
         local Success, Response, Code, Headers = pcall(Func, Args)
         if not Success then
            error(Response, 2)
         end
         return Response, Code, Headers
      end
      local TimeOut = Args.cache_time
      Args.cache_time = nil
 
      local Key        = util.md5(json.serialize{data=Args})
      local Recent     = Cache:get(Key .. '_time')
      local Now        = os.ts.time()
      if not Recent or Now - Recent > TimeOut then
         local Success,Response, Code, Headers = pcall(Func,Args)
         if not Success then
            error(Response, 2)
         end
         if Code == 200 then -- only cache good results!
            Cache:put(Key .. '_time', os.ts.time())
            Cache:put(Key, Response)
            Cache:put(Key..":C", Code)
            Cache:put(Key..":H", json.serialize{data=Headers,compact=true})
         end
         return Response, Code, Headers
      end
      return Cache:get(Key), tonumber(Cache:get(Key..":C")), json.parse{data=Cache:get(Key..":H")}
   end

   -- Only add help note on the first pass
   if not findItem(h.Parameters, 'cache') then 
      table.insert(h.Parameters, CacheHelp)
   end 
   help.set{input_function = net.http[Name], help_data = h} 
end

function net.http.cache()
   return Cache
end

