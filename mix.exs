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
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.2.0"},
      # recommended adapter for tesla
      {:hackney, "~> 1.14.0"},
      # required by tesla's JSON middleware
      {:jason, ">= 1.0.0"},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false},
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:junit_formatter, "~> 2.2", only: [:test]}
    ]
  end

  defp elixirc_paths(_), do: ["lib"]
end
