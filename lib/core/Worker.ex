
defmodule Socorro.Core.Worker do
    use GenServer
    require Logger
    alias Socorro.Actions.Report

    def start_link([]) do
        :gen_server.start_link(__MODULE__, [], [])
    end

    def init(state) do
        Logger.info "juas juas"
        {:ok, pid} = Report.start_link
        {:ok, [pid | state]}
    end

    def handle_cast(payload, state) do
        report = List.first(state)
        Logger.info "Using worker: " <> inspect(report)
        send report, payload
        :timer.sleep(100)
        {:noreply, state}
    end

    def report(pid, payload) do
        :gen_server.cast(pid, payload)
    end
end
