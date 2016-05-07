defmodule ShellStream do
  @moduledoc """
  Simple interface for dealing with shell commands
  as streams.
  
  Exposes the functionality via the `shell` function
  or with `sigil_x`. Probably useful for using
  elixir in shell scripts.
  """
  alias ShellStream.PortHandler

  @doc """
  Exposes a shell command as an elixir stream.
  As simple as that.
  """
  # TODO find out how to specify Stream as
  # return type in a spec
  def shell(command) do
    Stream.resource(
      fn ->
	spawn(PortHandler, :run, [command, self])
	self
      end,
      fn owner ->
	receive do
	  {:line, line} ->
	    {[line], owner}
	  {:status, _status} ->
	    {:halt, owner}
	end
      end,
      fn _ -> nil end
    )
  end

  @doc """
  Wraps the shell command around
  the ~x sigil for nicer syntax, but
  it is completely optional.
  
  Currently supports no options.
  """
  def sigil_x(command, []) do
    shell(command)
  end
end
