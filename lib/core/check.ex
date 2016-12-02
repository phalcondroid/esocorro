defmodule Socorro.Core.Check do

	alias Socorro.Core.{ Crypto }

	def check_socorro_id(socorro_id) do
        case socorro_id do
            nil ->
                Crypto.get_fn1a64_socorro_id()
            "" ->
                Crypto.get_fn1a64_socorro_id()
            _ ->
                socorro_id
        end
    end

    def request_validator(map) do
    	
    end
end