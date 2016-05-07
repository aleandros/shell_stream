defmodule ShellStream.Mixfile do
  use Mix.Project

  def project do
    [app: :shell_stream,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps]
  end
  
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.11", only: :dev},
     {:earmark, "~> 0.1", only: :dev}]
  end

  defp description do
    """
    Library that exposes a single function (and sigil)
    for running shell commands and returning a stream
    which generates an element for every line of
    the command output.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Edgar Cabrera"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/aleandros/shell_stream",
	       "Docs" => "http://hexdocs.pm/shell_stream/"}
    ]
  end
end
