defmodule NqccTest do
  use ExUnit.Case
  doctest Nqcc

  # test "greets the world" do
  #   assert Nqcc.hello() == :world
  # end
  test "Pruebas nivel sistema" do
    dir_aux = Path.absname("test/test_nora")
    path_pruebas = Path.absname("test/test_nora/test_compiler.sh")
    path_nqcc = Path.absname("nqcc")
    #IO.puts(dir_aux)
    #IO.puts(path_pruebas)
    #IO.puts(path_nqcc)

    {out,n}=System.cmd(path_pruebas, [path_nqcc, "3", "4"], cd: dir_aux)
    IO.puts("\n\n====- Pruebas nivel sistema -====\n")
    IO.puts(out)

    assert n == 0
  end
end
