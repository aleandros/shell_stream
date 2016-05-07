defmodule ShellStreamTest do
  use ExUnit.Case
  doctest ShellStream

  test "shell works with a simple command" do
    output = ShellStream.shell("echo 'hello world'")
    |> Enum.to_list
    assert output == ["hello world"]
  end

  test "shell can be chained with stream functions" do
    output = ShellStream.shell("seq 10")
    |> Stream.map(&String.to_integer/1)
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Enum.to_list
    assert output == [2, 4, 6, 8, 10]
  end

  test "sigil syntax works the same way" do
    import ShellStream
    output = ~x(seq 10)
    |> Stream.map(&String.to_integer/1)
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Enum.to_list
    assert output == [2, 4, 6, 8, 10]
  end
end
