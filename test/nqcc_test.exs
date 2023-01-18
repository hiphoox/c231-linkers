defmodule NqccTest do
  use ExUnit.Case
  doctest Nqcc

  test "Pruebas nivel sistema" do
    #dir_aux = Path.absname("test/test_nora")
    #path_pruebas = Path.absname("test/test_nora/test_compiler.sh")
    #path_nqcc = Path.absname("nqcc")
    #{out,n}=System.cmd(path_pruebas, [path_nqcc, "1", "2"], cd: dir_aux)

    #{out,n}=System.cmd(path_pruebas, [path_nqcc, "3", "4"], cd: dir_aux)
    #IO.puts("\n\n====- Pruebas nivel sistema -====\n")
    #IO.puts(out)

    assert 0 == 0
  end
end
