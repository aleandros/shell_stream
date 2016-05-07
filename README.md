# ShellStream

[![Build Status](https://travis-ci.org/aleandros/shell_stream.svg?branch=master)](https://travis-ci.org/aleandros/shell_stream)

ShellStream is a small library that exposes a single function (and sigil)
for running shell commands and returning a stream which generates an 
element for every line of the command output.

## Usage

If you do not need the sigil, simply run:

```elixir
ShellStream.shell("seq 10") |> Stream.map(&String.to_integer/1) |> Enum.to_list
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

The sigil syntax simply wraps the `shell` function. Only the extra
import is required.

```elixir
import ShellStream
~x(seq 10) |> Stream.map(&String.to_integer/1) |> Enum.to_list
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

## Installation

  1. Add shell_stream to your list of dependencies in `mix.exs`:

        def deps do
          [{:shell_stream, "~> 0.0.1"}]
        end

  2. Ensure shell_stream is started before your application:

        def application do
          [applications: [:shell_stream]]
        end

