dofile 'worker.lua'

local Threads = require 'threads'
local sdl = require 'sdl2'
sdl.init(0)

-- initialize worker thread                                                                              
threads = Threads(1 , -- number of threads                                                               
                        -- typically the first callback requires modules                                 
                        -- necessary to serialize other callbacks                                        
   function()
      gsdl = require 'sdl2'
   end,

   -- other callbacks (one is enough in general!) prepare stuff                     
                        -- you need to run your program                                                  
   function()
      print('starting a new thread/state')
      dofile('worker.lua')
   end
);

function workerJob()
   threads:addjob(
      -- job callback
      function()
	 sample('workerThread')
      end,
      -- end callback (runs in main thread)
      function()
      end
   )
end

while 1 do
   workerJob()
   sample('mainThread')
end
