-- To make this channel 'just work' we follow a trick of packaging the SQLite database with the
-- channel with the sample data.  You wouldn't normally do this but it's handy for making it work
-- out of the box.  This is an educational tool after all.

function getDatabasePath()
   -- Retrieve a map of the available project files and their paths
   local ProjectFiles = iguana.project.files()
   -- Create the path to the pre-populated sqlite database of Patient Data.
   local DatabasePath = iguana.workingDir() .. ProjectFiles['WebServicePatientData.sqlite']
   return DatabasePath
end

-- Connect to the database.
-- NOTE: The provided database is only for demo purposes. 
--       In practice you would be connecting to your own data source.
local DatabasePath = getDatabasePath()
return db.connect{api=db.SQLITE, name=DatabasePath}


