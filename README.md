# Esocorro

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `esocorro` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:esocorro, github: "phalcondroid/esocorro"}]
    end
    ```

  2. Ensure `esocorro` is started before your application:

    ```elixir
    def application do
      [applications: [:esocorro]]
    end
    ```

  3. Set config variables, it is mandatory

    ## dev.exs

    **Development enviroment**

    ```elixir

    config :mongodb,
        hostname: "localhost",
        username: "test",
        password: "***",
        database: "test"

    config :slack_webhook,
        :url, "http://slack.webhook.url.com/test"

    config :error_module,
        errors_url: "https://localhost/wwd-backend/admin/errors/index?errorId=",
        private_key: "your-key"
    ```

    ## prod.exs

    **Production enviroment, this keys BRAINZ_* should be set as a enviroment variable in your SO**

    ```elixir

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
    ```

  3. Add socorro alias in your module

    ```elixir
    alias Socorro.Core.Exception
    ```

  4. Report your exception in your project

    ```elixir
    try do
      :dodod + 1
    rescue
      e ->
        Exception.set_exception(e)
    end
    ```

    this get raise exception "bad argument in arithmetic expression"


