use Mix.Config

config :mongodb,
    hostname: System.get_env("BRAINZ_MONGO_HOSTNAME"),
    username: System.get_env("BRAINZ_MONGO_USERNAME"),
    password: System.get_env("BRAINZ_MONGO_PASSWORD"),
    database: System.get_env("BRAINZ_MONGO_DATABASE")

config :slack_webhook,
    :url, System.get_env("BRAINZ_SLACK_WEBHOOK")

config :error_module,
	errors_url: System.get_env("BRAINZ_ERRORS_URL"),
	private_key: System.get_env("BRAINZ_ERRORS_PRIVATE_KEY")
    #errors_url: "http://dev.worldwardoh.com/admin/errors/index?errorId=",
    #private_key: "my-private-key"
