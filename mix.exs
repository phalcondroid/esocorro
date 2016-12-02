defmodule Esocorro.Mixfile do
  use Mix.Project

  def project do
    [app: :esocorro,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

   # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      mod: { Socorro, [] },
      applications: 
      [
        :logger,
        :cowboy,
        :poison,
        :mongodb,
        :poolboy,
        :hackney,
        :fnv
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
        {:cowboy,  "~> 1.0.0"},
        {:logger_file_backend, "0.0.8"},
        {:poison,  "~> 2.0"},
        {:mongodb, ">= 0.0.0"},
        {:poolboy, ">= 0.0.0"},
        {:json,   "~> 0.3.0"},
        {:slack_webhook, ">= 0.0.1"},
        {:hackney, "~> 1.6"},
        {:fnv, github: "asaaki/fnv.ex"},
        {:httpoison, "~> 0.7"},
        {:uuid,    "~> 1.1" }
    ]
  end
end
