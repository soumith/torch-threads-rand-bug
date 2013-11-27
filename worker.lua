require 'torch'
torch.setdefaulttensortype('torch.FloatTensor')

function sample(where)
   local count = 1000000
   for i=1,count do
      local num = torch.rand(1)[1]
      if num > 1 then
	 error('[' .. where .. '] wtf torch.rand: ' .. num)
      end
   end
end