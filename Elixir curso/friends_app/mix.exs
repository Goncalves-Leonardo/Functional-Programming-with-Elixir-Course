defmodule FriendsApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :friends_app,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do

      [{:nimble_csv, "~> 0.6"},{:faker, "~> 0.13"},{:scribe, "~> 0.10"}]

  end
end
