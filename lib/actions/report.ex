defmodule Socorro.Actions.Report do
    require Logger

    alias Socorro.Db.MongoPool
    alias Socorro.Models.Errors
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

        Logger.info "Me report"

        message      = Map.fetch!(report, "message")
        time         = :os.system_time(:seconds)
        content_body = Map.fetch!(report, "content")
        checksum     = Crypto.get_checksum(message <> content_body)

        uuid         = "?"
        build        = "?"
            
        temp_socorro_id = Check.check_socorro_id(nil)

        content      = temp_socorro_id <> content_body

        insert_result = Errors.new(MongoPool, %{
            "count"       => 1,
            "type"        => 1,
            "checksum"    => checksum,
            "time"        => time,
            "message"     => message,
            "lastTime"    => time,
            "build"       => build,
            "UUID"        => uuid,
            "socorroId"   => temp_socorro_id
        })

        result_check = Errors.check_insert_result(insert_result)

        if result_check != false do
            Slack.send_slack_message(temp_socorro_id, message, 1, build)
        end
    end
end