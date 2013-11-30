require 'torch'
require 'sys'
torch.setdefaulttensortype('torch.FloatTensor')

average = {}
count = 200000000
function sample()
   local i = 2
   while i <= count do      
      sys.tic()
      local num = torch.rand(i)
      local timing = sys.toc()
      -- print('torch.rand(' .. i .. '): ' .. timing)
      if average[i] == nil then average[i] = 0 end
      average[i] = timing
      i = i * 10
   end
end

runs = 10
print('Generating random tensors and averaging timing over ' .. runs .. ' runs')

for k=1,runs do
   sample()
   collectgarbage()
end

print('torch.rand over ' .. runs .. ' runs')
for k,v in pairs(average) do
   average[k] = average[k] / runs
   print(k .. ' elements : \t\t' .. average[k])
end

print(average)
