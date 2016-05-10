defmodule PortHandlerTest do
  use ExUnit.Case
  alias ShellStream.PortHandler

  test "run sends single line command as a binary" do
    PortHandler.run("echo 'hello world'", self)
    assert_receive {:line, "hello world"}
  end

  test "run captures success status as a number" do
    PortHandler.run("echo 'hello world'", self)
    assert_receive {:status, 0}
  end

  test "run successfully handles multi line commands" do
    PortHandler.run("echo \"hello world\nhello again\"", self)
    assert_receive {:line, "hello world"}
    assert_receive {:line, "hello again"}
  end

  test "run correctly captures a non-zero code" do
    PortHandler.run("ls -wut", self)
    assert_receive {:status, 2}
  end
end
