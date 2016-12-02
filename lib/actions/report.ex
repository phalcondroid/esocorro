defmodule Socorro.Actions.Report do
    require Logger

    alias Socorro.Db.MongoPool
    alias Socorro.Models.Errors

    @frontend_error_type 1

    def start_link do
        Task.start_link fn ->
            loop()
        end
    end

    defp loop() do
        receive do
            %{"report" => report} ->
                report_error(report)
        end
        loop()
    end

    def report_error(report) do
    	Logger.info inspect(report)
    end
end