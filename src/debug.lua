local function local_VarDump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. local_VarDump(v) .. ','
        end
        return s .. '} '
     else
        return tostring(o)
     end
end

function VarDump(o)
   print(local_VarDump(o))
end

function SimpleVarDump(o)
   if type(o) == 'table' then
      for k,v in pairs(o) do
         print(k)
      end
   else 
      print(tostring(o))
   end
   
end