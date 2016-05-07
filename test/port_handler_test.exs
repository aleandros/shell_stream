defmodule PortHandlerTest do
  use ExUnit.Case
  alias ShellStream.PortHandler
  
  test "run sends single line command as a binary" do
    PortHandler.run("echo 'hello world'", self)
    receive do
      {:line, line} ->
	assert line == "hello world"
    end
  end

  test "run captures success status as a number" do
    PortHandler.run("echo 'hello world'", self)
    receive do
      {:status, status} ->
	assert status == 0
    end
  end

  test "run successfully handles multi line commands" do
    PortHandler.run("echo \"hello world\nhello again\"", self)
    receive do
      {:line, line} ->
	assert line == "hello world"
    end
    receive do
      {:line, line} ->
	assert line == "hello again"
    end
  end

  test "run correctly captures a non-zero code" do
    PortHandler.run("ls -wut", self)
    receive do
      {:status, status} ->
	assert status == 2
    end
  end
end
