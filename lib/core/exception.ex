defmodule Socorro.Core.Exception do

	require Logger

	def set_exception(e) do

		if Exception.exception?(e) do

			IO.puts "jojij " <> inspect(get_trace())

			Socorro.send_report(%{
				"message" => Exception.message(e),
				"trace"   => ""
			})

		else
			Logger.error "Untracked exception: " <> inspect(e)
			nil
		end

	end

	def get_trace() do

		trace = System.stacktrace

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

			[file, line] = list
			map = %{"file" => file, "line" => line}

			Poison.encode!(map)
		else
			"{}"
		end
	end
end