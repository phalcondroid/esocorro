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

			for {namespace, _, _, [file: file, line: line]}
				<- trace,
				do: List.insert_at(list, %{"file" => to_string(file), "namespace" => to_string(namespace),"line" => line}, 0)

			IO.puts inspect(list)

			Poison.encode!(%{"a" => ""})
		else
			"{}"
		end
	end
end