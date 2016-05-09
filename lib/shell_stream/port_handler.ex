defmodule ShellStream.PortHandler do
  @moduledoc """
  Wrap the logic of comunicating
  with a port, including boilerplate
  configuration (assumptions are made such as
  only using stdout and a 1023 max line width)
  and handling low level messages.

  The module exposes a single function
  in which it is indicated which command should be
  run.
  """

  @doc """
  Executes a shell command and sends
  each line as it is produced to the receiver
  process. The call blocks until the command
  is finished.
  """
  @spec run(binary, pid) :: atom
  def run(command, receiver) do
    # TODO should allow caller customize these options
    options = [:stderr_to_stdout, :in, :exit_status,
	       {:line, 1023}, :hide]
    Port.open({:spawn, command}, options)
    loop(receiver)
  end

  @spec loop(pid) :: atom
  defp loop(receiver) do
    receive do
      {_port, {:data, {:eol, str}}} ->
	send receiver, {:line, to_string(str)}
	loop(receiver)
      {_port, {:exit_status, status}} ->
	send receiver, {:status, status}
    end
    :ok
  end
end
