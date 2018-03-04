defmodule ProxerEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :proxer_ex,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      applications: [:httpoison]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false},
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false},
      {:ace, "~> 0.15.10", only:  [:test]},
	    {:junit_formatter, "~> 2.2", only: [:test]}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/server"]
  defp elixirc_paths(_), do: ["lib"]
end
