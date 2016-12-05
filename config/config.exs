# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
 format: "(E_ERRORS_REPORTER) $time $metadata[$level] $message\n",
 metadata: [:user_id, :request_id]

import_config "#{Mix.env}.exs"
