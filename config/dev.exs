use Mix.Config

config :mongodb,
    hostname: "localhost",
    username: "admin",
    password: nil,
    database: "wwd"

config :slack_webhook,
    :url, "https://hooks.slack.com/services/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"

config :eerrors,
    errors_url: "https://localhost/wwd-backend/admin/errors/index?errorId=",
    private_key: "my-private-key"
