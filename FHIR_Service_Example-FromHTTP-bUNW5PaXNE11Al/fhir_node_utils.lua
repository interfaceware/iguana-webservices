function fhirCreate(sType)
   if not _fhirStrings.resources[sType] then
      error('Not a valid resource', 2)
   end
   return xml.parse(_fhirStrings.resources[sType])[1]
end

function node:fhirInsertComplex(sName, sType, nIndex)
   if not _fhirStrings.datatypes[sType] then
      error('Data type not recognised', 2)
   else
      if not nIndex or nIndex > self:childCount() + 1 then
         if not self:fhirFindChild(sName) then
            nIndex = self:childCount() + 1
         else
            nIndex = self:fhirFindChild(sName) + 1
         end
      end
     
      local _f = self:insert(nIndex, xml.ELEMENT, sName)
      _f:setInner(_fhirStrings.datatypes[sType])
     
      return _f
   end
end

function node:fhirInsertPrimitive(sName, nIndex)
   if not nIndex or nIndex > self:childCount() + 1 then
      if not self:fhirFindChild(sName) then
         nIndex = self:childCount() + 1
      else
         nIndex = self:fhirFindChild(sName) + 1
      end
   end

   local _f = self:insert(nIndex, xml.ELEMENT, sName)
   _f:append(xml.ATTRIBUTE, 'value')
  
   return _f
end

function node:fhirFindChild(sName)
   local nFound, xFound  = nil
   if type(sName) == 'string' then
      for nNode = self:childCount(), 1, -1 do
         if self[nNode]:nodeName() == sName then
            nFound = nNode
            xFound = self[nNode]
            break
         end
      end
   end
   return nFound, xFound
end

function node:fhirIsEmpty()
   local bIsEmpty = true

   if self:isLeaf() and self:nodeValue() ~= '' then
      bIsEmpty = false
   elseif self:nodeName() == 'div' and self:childCount() > 0 then
      bIsEmpty = false
   else     
      for n=1, self:childCount() do
         if self:childCount() == 1 and self[1]:nodeName() == 'xmlns' then
         elseif self:childCount() == 1 and self[1]:nodeName() == 'value' and self[1]:nodeValue() ~= '' then
            bIsEmpty = false
            break
         elseif not self[n]:fhirIsEmpty() then
            bIsEmpty = false
            break        
         end
      end
   end
  
   return bIsEmpty
end

function node:fhirDropEmpty()
   for nChild = self:childCount(), 1 , -1 do
      if self[nChild]:fhirIsEmpty() then
         self:remove(nChild)
      elseif self[nChild]:nodeName() == 'div' then
      else
         self[nChild]:fhirDropEmpty()
         if self[nChild]:fhirIsEmpty() then
            self:remove(nChild)
         end
      end
   end
   return self
end

function node:fhirInsertComponent(sName, sType, nIndex)   
   if not _fhirStrings.components[sType] then
      error('Data type not recognised', 2)
   else
      if not nIndex or nIndex > self:childCount() + 1 then
         if not self:fhirFindChild(sName) then
            nIndex = self:childCount() + 1
         else
            nIndex = self:fhirFindChild(sName) + 1
         end
      end
      
      local _f = self:insert(nIndex, xml.ELEMENT, sName)
      _f:setInner(_fhirStrings.components[sType])
      
      return _f
   end
end

function node:fhirAddNode(xNode)
   _s = ''
   for n = 1, self:childCount() do
      if self[n]:nodeType() ~= 'attribute' then
         _s = _s .. self[n]:S()
      end
   end
   _s = _s .. xNode:S()
   self:setInner(_s)
end

function node:fhirAddAttribute(sName, sValue)
   if not self:fhirFindChild(sName) then
      self:append(xml.ATTRIBUTE, sName)
      if sValue then
         self[sName] = sValue
      end
   end
end

function node:fhirDuplicateChild(sName)
   local nIndex = self:fhirFindChild(sName)
   local _s = self[nIndex]:S()
   local _d = self:insert(nIndex + 1, xml.ELEMENT, sName)
   _d:setInner(_s:sub(#sName + 4, #_s - #sName - 3))
   return _d
end

function node:fhirDateTime(sZone)
   local sDefaultZone = '+10:00'
   if not sZone then
      sZone = sDefaultZone
   end
   local _sHl7Date = self:S()
   local _sFhirDate = ''
   for n = 1, #_sHl7Date do
      if n == 5 or n == 7 then
         _sFhirDate = _sFhirDate.. '-' .. _sHl7Date:sub(n, n)
      elseif n == 9 then
           _sFhirDate = _sFhirDate.. 'T' .. _sHl7Date:sub(n, n) 
      elseif n == 11 or n == 13 then
         _sFhirDate = _sFhirDate.. ':' .. _sHl7Date:sub(n, n)         
      else
         _sFhirDate = _sFhirDate.. _sHl7Date:sub(n, n)
      end
      
      if _sFhirDate:find('T') then
         _sFhirDate = _sFhirDate.. sZone
      end
   end
   return _sFhirDate
end

function fhirNow(sTZ)
   local sDefaultZone = '+10:00'
   if not sTZ then
      sTZ = sDefaultZone
   end
   return os.date('%Y-%m-%dT%H:%M:%S+' .. sTZ)
end

function node:fhirGetValue(sPath)
   tPath = sPath:split('%.')
   local tNode = self
   local sReturn = ''
   local nRepeat = 1
   for n=1, #tPath do
      nRepeat = 1
      if tPath[n]:find('%^') then
         nRepeat = tonumber(tPath[n]:sub(tPath[n]:find('%^') + 1))
         tPath[n] = tPath[n]:sub(1, tPath[n]:find('%^') - 1)
      end
      local bOK, tChild = pcall(tNode.child,tNode, tPath[n], nRepeat)
      if n == #tPath then
         if bOK and  tChild.value then
              sReturn = tChild.value:S()
         end
      elseif bOK  then
         tNode = tChild
      else
         break
      end
   end
   return sReturn
end

function string:split(sDelimiter, bNoTrim)
   t = {}
   s = self .. sDelimiter:gsub('%%', '')
   nEsc = 0
   if sDelimiter:find('%%') then
      nEsc = 1
   end
   
   if not bNoTrim then
      s = s:gsub('%s$', '')
   end
   s:gsub('(.-' .. sDelimiter .. ')', function(ss) 
         table.insert(t, ss:sub(1, -1-#sDelimiter+nEsc))   
      end)
   return t
end

function node:S()
   if self:isLeaf() then
      return self:nodeValue()
   else
      return tostring(self)
   end
end