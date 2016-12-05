defmodule Socorro.Core.Slack do
	
    def send_slack_message(socorro_id, message, count, build) do

        url = Application.fetch_env!(:error_module, :errors_url)

        message = "ID=<" <> url <> socorro_id <> "|" <> socorro_id <> "> Message=" <> message
                  <> " Ocurrences=" <> Integer.to_string(count) <> " Build=" <> build

        SlackWebhook.async_send message
    end
end
