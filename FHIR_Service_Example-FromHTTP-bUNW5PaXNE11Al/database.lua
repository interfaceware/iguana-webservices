local Database = {}

---------------------------------------
------ Database Connect and Path ------
---------------------------------------
local function copyOriginalDatabaseToWorkingDatabase(OriginalDatabasePath, WorkingDatabasePath)
   local Success = true
   local Result = ""
   local PathSeparator = package.config:sub(1,1)
   if PathSeparator == '\\' then
      -- On a Windows OS
      Result = os.execute("copy /y \"" .. OriginalDatabasePath .. "\" \"" .. WorkingDatabasePath .. "\" > nul")
   else
      -- On a Posix OS
      Result = os.execute("cp -f \"" .. OriginalDatabasePath .. "\" \"" .. WorkingDatabasePath .. "\"")
   end
   Success = (Result == 0)
   
   if not Success then
      trace(Result)
      error("Error copying database into working directory.")
   end
end

Database.ensureWorkingDatabaseExists = function()
   -- Retrieve a map of the available project files and their paths
   local ProjectFiles = iguana.project.files()
   trace(ProjectFiles)
   
   -- Create the path to the original pre-populated sqlite database of Patient Data.
   local OriginalDatabasePath = iguana.workingDir() .. ProjectFiles['other/FHIR_PatientData.sqlite']
   local WorkingDatabasePath  = iguana.workingDir() .. 'FHIR_PatientData.sqlite'
   trace(OriginalDatabasePath)
   os.fs.stat(OriginalDatabasePath)
   
   local Stat = os.fs.stat(WorkingDatabasePath)

   if Stat == nil then
      -- Working database doesn't exist. Copy it over...
      copyOriginalDatabaseToWorkingDatabase(OriginalDatabasePath, WorkingDatabasePath)
   end
   return WorkingDatabasePath
end

Database.path = function()
   return Database.ensureWorkingDatabaseExists()
end

-- Connect to the database.
-- NOTE: The provided database is only for demo purposes. 
--       In practice you would be connecting to your own data source.
local DatabasePath = Database.path()
Database.connection = db.connect{api=db.SQLITE, name=DatabasePath}


------------------------------
------ Database Access -------
------------------------------
Database.queryAll = function(TableName)
   local Statement = 'SELECT * FROM ' .. Database.connection:quote(TableName)
   trace(Statement)
   return pcall(function () 
         local Result = Database.connection:query(Statement)
         return Result
   end)
end

Database.queryOne = function(TableName, EntryId)
   local Statement = 'SELECT * FROM ' .. Database.connection:quote(TableName) .. " WHERE Id=" .. Database.connection:quote(EntryId)
   trace(Statement)
   return pcall(function () 
         local Result = Database.connection:query(Statement)
         return Result
   end)
end

Database.deleteOne = function(TableName, EntryId)   
   local Statement = 'DELETE FROM ' .. Database.connection:quote(TableName) .. " WHERE Id=" .. Database.connection:quote(EntryId)
   trace(Statement)
   return pcall(function () 
         local Result = Database.connection:query(Statement)
         return Result
   end)
end

Database.createOrUpdate = function(TableEntry)
   return pcall(function () 
      local Result = Database.connection:merge{data=TableEntry, live=false}
      return Result
   end)
end

Database.getLastId = function(TableName)
   local Statement = "SELECT MAX(Id) AS LastID FROM " .. TableName
   trace(Statement)
   return pcall(function () 
      local Result = Database.connection:query(Statement)
      return Result
   end)
end

Database.exists = function(TableName, EntryId)
   
end


return Database
