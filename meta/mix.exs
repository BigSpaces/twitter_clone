defmodule Meta.MixProject do
  use Mix.Project

  def project do
    [
      app: :meta,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Meta.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.10"},
      {:plug_cowboy, "~> 2.6"},
      {:plug, "~> 1.14"},
      {:plug_redirect, "~> 1.0"},
      {:jason, "~> 1.4"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
