defmodule Socorro.Actions.Report do
    require Logger

    @frontend_error_type 1

    def start_link do
        
        Logger.info inspect("map")

        Task.start_link fn ->
            loop()
        end
    end

    defp loop() do
        receive do
            %{"body" => body} ->
                report_error(%{"body" => body})
        end
        loop()
    end

    def report_error(map) do
    	Logger.info inspect(map)
    end
end