defmodule Socorro.Core.ErrorException do

	require Logger

	def set_exception(e) do

		if Exception.exception?(e) do

			Socorro.send_report(%{
				"message" => Exception.message(e),
				"trace"   => get_trace()
			})

		else
			Logger.error "Untracked exception: " <> inspect(e)
			nil
		end

	end

	def get_trace() do

		trace = System.stacktrace

		if Enum.count(trace) > 0 do
			
			list = iterate_trace(trace, [], 0)

			Poison.encode!(list)
		else
			"[]"
		end
	end

	def iterate_trace(trace, new, n) do

	    if n < Enum.count(trace) do

	    	row = Enum.at(trace, n, 0)

	    	case row do
	    		{namespace, _, _, [file: file, line: line]} ->
	    			IO.puts "mother foca : " <> inspect(row)
	    			{namespace, _, _, [file: file, line: line]} = row
			    	new = new ++ [%{"file" => to_string(file), "namespace" => to_string(namespace),"line" => line}]
			    	iterate_trace(trace, new, n + 1)
			    _ ->
			    	""
	    	end
	    	
	    else
	    	new
	    end
	end
end