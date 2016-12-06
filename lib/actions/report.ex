defmodule Socorro.Actions.Report do
    require Logger

    alias Socorro.Models.Errors
    alias Socorro.Models.BackgroundError
    alias Socorro.Core.{ Check, Slack, Crypto }

    @elixir_error_type 3

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

        message      = Map.fetch!(report, "message")
        time         = :os.system_time(:seconds)
        content_body = Map.fetch!(report, "message")
        checksum     = Crypto.get_checksum(message <> content_body)

        uuid         = "?"
        build        = "?"
            
        temp_socorro_id = Check.check_socorro_id(nil)

        insert_result = Errors.new(%{
            "count"       => 1,
            "type"        => @elixir_error_type,
            "checksum"    => checksum,
            "time"        => time,
            "message"     => message,
            "lastTime"    => time,
            "build"       => build,
            "UUID"        => uuid,
            "socorroId"   => temp_socorro_id
        })

        error_id = Errors.check_insert_result(insert_result)

        if error_id != false do

            trace = Map.fetch!(report, "trace")
            
            BackgroundError.new(%{
                "errorId"  => error_id,
                "message"  => message,
                "trace"    => trace
            })

            Slack.send_slack_message(temp_socorro_id, message, 1, build)

            Logger.info "Insert error report success: " <> temp_socorro_id
        end
    end
end