defmodule Nqcc do
  @moduledoc """
  Documentation for Nqcc.
  """
  @commands %{
    "help" => "Prints this help",
    "asm" => "Shows the assembly code",
    "tl" => "Shows token list",
    "ast" => "Shows AST Tree"
  }

  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean,t: :boolean,a: :boolean,s: :boolean,o: :boolean])
  end
    defp process_args({[], [file_name], _}) do
    compile_file(file_name)
  end
  defp process_args({[help: true], _, _}) do
    print_help_message()
  end

   defp process_args({[tl: true], _, _}) do
    IO.puts("Usage --tl (path)")
  end

  defp process_args({[asm: true], _, _}) do
    IO.puts("Usage --asm (path)")
  end

  defp process_args({[ast: true], _, _}) do
    IO.puts("Usage --ast (path)")
  end

  defp process_args({[tl: true], [file_name], _}) do
    token_list_gen(file_name)
  end

  defp process_args({[asm: true], [file_name], _}) do
    asm_gen(file_name)
  end

  defp process_args({[ast: true], [file_name], _}) do
    tree_gen(file_name)
  end

  defp process_args({_, [file_name], _}) do
    compile_file(file_name)
  end

 defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")
    lista_tokens=File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    evaluar=Evaluator.evaluator_lexer(lista_tokens)
    if evaluar==[] do
      arbolAST=lista_tokens
      |> Parser.parse_program()
      if is_map(arbolAST) do
        arbolAST
        |> CodeGenerator.generate_code()
        |> Linker.generate_binary(assembly_path)
        |> IO.inspect()
      end
      if is_tuple(arbolAST) do
        IO.puts("ERROR SINTACTICO")
        {_,_,linea_numero,problema_atomo}=arbolAST
        linea=to_string(linea_numero+1)
        problema=to_string(problema_atomo)
        mensaje_error="Errror en linea:  "<>linea<>", Cerca de: "<>problema
        IO.inspect(mensaje_error)
      end
    else
      IO.puts("Error lexico:")
      [_,palabra,linea_numero]=evaluar
      linea=to_string(linea_numero+1)
      mensaje_error="La  "<>palabra<>" es noT esperada  en linea: "<>linea
      IO.inspect(mensaje_error)
    end
end


defp token_list_gen(file_path) do
    IO.puts("Token List: " <> file_path)
    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nLexer ouput (Token List)")
  end

 
 defp tree_gen(file_path) do
    IO.puts("Tree AST: " <> file_path)
    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> Parser.parse_program()
    |> IO.inspect(label: "\nParser ouput (Tree AST)")
  end

  defp asm_gen(file_path) do
    IO.puts("Assembler Code: " <> file_path)
    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> Parser.parse_program()
    |> CodeGenerator.generate_code()
  end

  

  defp print_help_message do
    IO.puts("\nnqcc --help file_name \n")

    IO.puts("\nThe compiler supports following options:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end
end
