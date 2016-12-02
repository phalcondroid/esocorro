defmodule Socorro do
	use Application
    alias Socorro.Core.{ Pool }

    def start(_type, _args) do
        Pool.start_link
    end

    def send_report(report) do
    	Pool.report(%{
            "report"    => report
        })
    end
end
