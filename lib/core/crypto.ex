defmodule Socorro.Core.Crypto do

	def get_fn1a64_socorro_id() do
        String.upcase(FNV.FNV1a.hex(UUID.uuid1(), 64))
    end

    def get_checksum(content) do
    	:crypto.hash(:md5, content) |> Base.encode16 |> String.downcase
    end
    
end