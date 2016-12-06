defmodule Socorro.Core.Exception do
	def get_trace_list() do

		trace = System.stacktrace

		IO.puts inspect(trace)
		
		if is_list(trace) do
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
		end
	end
end