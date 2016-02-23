-- Very simple example of redirecting a web request to a different location
-- This is helpful when creating links from one web application to another.
-- Say you wanted to make a URL from a EMR that could redirect to a Lab system
-- for instance.  This would be a useful tool to achieve that.

function main(Data)
   local R = net.http.parseRequest{data=Data}
   -- One could take data from the request for the user and redirect to a different place.   
   trace(R)

   -- Redirecting to another website is just a one liner.  
   -- You might want to wrap this up into a helper function
   net.http.respond{body="Go to interfaceware.", code=301,  
                    headers={Location="http://www.interfaceware.com"}}
end