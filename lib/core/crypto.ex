defmodule Socorro.Core.Crypto do

	def get_fn1a64_socorro_id() do
        String.upcase(FNV.FNV1a.hex(UUID.uuid1(), 64))
    end
    
end