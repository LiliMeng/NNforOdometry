require 'torch'

local dataLoader = {}


--[[
ignore - number of cols to ignore at start of csv
numInputs - number of cols for input
numOutputs - num of cols for output
]]--
function dataLoader.getSeq(fileLoc, ignore, numInputs, numOutputs)
  local file = io.open(fileLoc, 'r')
  input = {}
  output = {}
  i=0
  while true do
    line = file:read()

    if line == nil then break end

    i = i +1
    ll = line:split(',')

    input[i] = {}
    for col=ignore+1,ignore+numInputs do
      table.insert(input[i], ll[col])
    end

    output[i] = {}
    for col=ignore+numInputs+1, ignore+numInputs+numOutputs do
      table.insert(output[i], ll[col])
    end

  end

  file.close()
  return{inputs=torch.Tensor(input), outputs=torch.Tensor(output)}
end

-- Load all seq*.csv files in a directory.
function dataLoader.load(dir, ignore, numInputs, numOutputs)

  seqs = {}

  for file in lfs.dir(dir) do
    if file:match('seq.*.csv') ~= nil then
      table.insert(seqs, dataLoader.getSeq(dir .. file, ignore, numInputs, numOutputs))
    end
  end

  return(seqs)
end

return dataLoader
