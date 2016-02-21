require 'nn'
require 'requ'

function odom_create_model(opt)
  ------------------------------------------------------------------------------
  -- MODEL
  ------------------------------------------------------------------------------
  local n_inputs = 2        --number of input 
  local n_hidden = 20        --number of hidden nodes
  local n_outputs = 2       --number of output 
  -- OUR MODEL:
  --     linear -> ReLU-> linear
　　local model = nn.Sequential()

  if opt.model_type == 'rnn' then
     model:add(nn.FastLSTM(n_inputs, n_hidden))
     model.add(nn.Linear(n_hidden, n_outputs))
  elseif opt.model_type == 'nn' then
     model:add(nn.Linear(n_inputs, n_hidden))
     model:add(nn.ReLU())
     model:add(nn.Linear(n_hidden,n_outputs))
  else
     error('undefined model' .. tostring(opt.model_type))
  end

 
  ------------------------------------------------------------------------------
  -- LOSS FUNCTION
  ------------------------------------------------------------------------------
  local criterion = nn.MSECriterion()

  return model, criterion

end

