defmodule Socorro.Core.Exception do

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

			list = []

			for {namespace, _, _, [file: file, line: line]} <- trace, do: 
				List.insert_at(
					list,
					%{
						"file"      => file,
						"namespace" => to_string(namespace),
						"line"      => line
					}
				)

			IO.puts inspect(list)

			Poison.encode!(%{"a" => ""})
		else
			"{}"
		end
	end
end