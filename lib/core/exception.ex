defmodule Socorro.Core.Exception do
	def get_trace_list() do

		trace = System.stacktrace

		IO.puts "no is list: " <> inspect(trace)
		
		if Enum.count(trace) > 0 do
			[
				{
					_,
					_,
					_,
					list
				},
				_
			] = trace
			list
		else
			trace
		end
	end
end