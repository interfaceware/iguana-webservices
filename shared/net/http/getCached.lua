local store = require 'store2'

-- Create a unique SQLite cache just for this translator instance
local Cache = store.connect(iguana.project.guid()..'http')

-- To make a unique key of the inputs take the MD5 hash of the JSON of the parameters
local function CacheKey(T)
   local R = json.serialize{data=T, compact=true}
   trace(R)
   return util.md5(R)
end


net.http.getCached = function(T)
   local CacheTime = T.cache_time or 3600
   T.cache_time = nil
   
   local Key
   if iguana.isTest() then
      Key = CacheKey(T)
      local Value = Cache:get(Key) 
      if Value and tonumber(Value) <= os.ts.time() then
         trace("Using cached value")
         return Cache:get(Key..":R"), Cache:put(Key..":C"), Cache:put(Key..":H")
      end
   end
   
   local Success, Result, Code, Headers = pcall(net.http.get,T)
   if not Success then
      error(X,2)
   end
   -- We only cache successful calls and in test mode.
   if (iguana.isTest() and Code == 200) then
      Cache:put(Key, os.ts.time())
      Cache:put(Key..":R", Result)
      Cache:put(Key..":C", Code)
      Cache:put(Key..":H", Headers)
   end
   return Result,Code, Headers
end

-- Get access to the cache we are using
net.http.cache = function()
   return Cache
end

HelpDataGetCached=[[{
      "ParameterTable": true,
      "Usage": "net.http.getCached{url=&#60;value&#62; [, timeout=&#60;value&#62;] [, ...]}",
      "Title": "net.http.getCached",
      "SummaryLine": "Fetches data from an HTTP address using the GET method using caching in a local SQLite database.",
      "Desc": "Fetches data from an HTTP address using the GET method using caching.",
      "Returns": [{"Desc": "Response data <u>string</u>."},
                  {"Desc": "Response code <u>string</u>."},
                  {"Desc": "Response headers <u>table</u>."}],
      "Examples": [
         "<pre>local Results = net.http.getCached{url='http://www.interfaceware.com', parameters={key='value'}}</pre>"
      ],
      "Parameters": [{"url": {"Desc": "The URL to fetch data from <u>string</u>."}},
         {"timeout": {"Desc": "Timeout for the operation (default = 15 seconds) <u>integer</u>.", "Opt": true}},
         {"parameters": {"Desc": "A table of parameters to be passed to the server, and is appended to existing parameters in 'url'. E.g., {q='a name'} would be passed as \"?q=a&percnt;20name\" <u>string</u>.",
               "Opt": true}},
         {"headers": {"Desc": "A key/value table of HTTP header values (e.g. {['Set-Cookie']='Val'}), or an array of strings (e.g. {'Set-Cookie: Val1','Set-Cookie: Val2'}) <u>table</u>.",
                      "Opt": true}},
         {"response_headers_format": {
               "Desc": "Specifies the output format of the response headers: 'default' - a table of key/value pairs from the last response after redirects, where the value is the last value for the given header key; 'raw' - a table containing every line of every header, including redirects; or 'multiple' - a table of key/value pairs of the form {HeaderKey = {Values={Val1,LastVal},Value=LastVal}} where the values are from the last response after redirects <u>table</u>.",
               "Opt": true}},
         {"cache_time": {
               "Desc": "The time in seconds to cache the results (default=3600 i.e. 1 hour).<u>integer</u>.",
               "Opt": true}},

         {"method": {
               "Desc": "The method to use (default = GET) <u>string</u>.",
               "Opt": true}},
         {"auth": {
 	       "Desc": "The 'auth' table, when used, contains these parameters:<br/><ul>   <li>username : the username to send to the HTTP server.</li>   <li>password : the password to send to the HTTP server.</li>   <li>method : optional: the authorization method(s) to allow.  See below.</li>   <li>follow : optional: continue authorization attempts after redirect.This defaults to false to avoid compromising security.</li></ul><p>The authentication method defaults to 'basic', but can be changed to:'digest', 'digest-ie', 'gss-negotiate', 'ntlm', 'any' (allow any method),'anysafe' (not 'basic'), or a combination (e.g., {'digest','digest-ie'}).</p><p>When more than one method is allowed, the server will be asked which it supports before authentication is attempted.</p><u>table</u>",
               "Opt": true}},
         {"ssl": {
 	           "Desc": "The 'ssl' table, when used, may contain these parameters:<br/><ul><li>cert : the name of your certificate file.</li><li>cert_type : your certificate's type: PEM (default) or DER.</li><li>key : the name of your private key file.</li><li>key_pass : the password to access your private key.</li><li>key_type : your private key's type: PEM (default), DER, or ENG.</li><li>ssl_engine : the engine to use with 'key_type' ENG.</li><li>verify_peer : verify peer certificate (default true).</li><li>verify_host : verify host certificate matches URL (default true).</li><li>ca_file : the certificate(s) file to use for peer verification.</li><li>issuer_cert : the PEM certificate file to validate the issuer of the peer's certificate during peer validation.</li><li>crl_file : the name of the certificate revocation list to use during peer validation.</li><li>ssl_version : use a particular SSL version.  Normally ssl-v3 is tried first, then tls-v1; ssl-v2 is never used automatically.;</li></ul><u>table</u>",
              "Opt": true}},
         {"live": {
              "Desc": "When true, requests are sent while in the editor (default = false) <u>boolean</u>.",
              "Opt": true}},
         {"debug": {
              "Desc": "When true return verbose debug information - errors thrown will also contain debug information (default = false) <u>boolean</u>.",
              "Opt": true}}
      ]
   }
]]

help.set{input_function=net.http.getCached,help_data=json.parse{data=HelpDataGetCached}}
 
HelpDataCache=[[{
      "ParameterTable": false,
      "Usage": "net.http.cache()",
      "Title": "net.http.cache",
      "SummaryLine": "Returns the store2 cache used by the net.http.getCache method.",
      "Desc": "Returns the store2 cache used by the net.http.getCache method.",
      "Returns": [{"Desc": "store2 Cache object <u>object</u>."}],
      "Examples": [
"<pre>local Cache = net.http.cache()
Cache:reset()</pre>"
      ],
      "Parameters": []
   }
]]

help.set{input_function=net.http.cache,help_data=json.parse{data=HelpDataCache}}
