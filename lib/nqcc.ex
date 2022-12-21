defmodule Nqcc do
  @moduledoc """
  Documentation for Nqcc.
  """
  @commands %{
    "help" => "Prints this help",
    "asm" => "Shows the assembly code",
    "tl" => "Shows token list",
    "ast" => "Shows AST Tree",
    "o" => "Rename the executable"
  }

  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean,tl: :boolean,asm: :boolean,ast: :boolean,o: :boolean])
  end

  # Compile file
  defp process_args({[], [file_name], []})do
    compile_file(file_name, [])
  end

  # Rename the executable
  defp process_args({[o: true], [file_name,new_name], []}) do
    compile_file(file_name, [new_name])
  end

  # Token list
  defp process_args({[tl: true], [file_name], []}) do
    token_list_gen(file_name)
  end

  # AST tree
  defp process_args({[ast: true], [file_name], []}) do
    tree_gen(file_name)
  end

  # Code generator
  defp process_args({[asm: true], [file_name], []}) do
    asm_gen(file_name)
  end

  # Help
  defp process_args({[help: true], [], []}) do
    print_help_message()
  end

  defp process_args({[tl: true], _, _}) do
    IO.puts("Usage: nqcc --tl (path)")
  end

  defp process_args({[ast: true], _, _}) do
    IO.puts("Usage: nqcc --ast (path) ")
  end

  defp process_args({[asm: true], _, _}) do
    IO.puts("Usage: nqcc --asm (path)")
  end

  defp process_args({[o: true], _, _}) do
    IO.puts("Usage: nqcc --o (path) (new_name)")
  end

  defp process_args({_, _, _}) do
    IO.puts("**Error: Unrecognized command**")
    IO.puts("Usage: nqcc --help")
  end


  defp compile_file(file_path, name) do
    IO.puts("Compiling file: " <> file_path<>"\n")

    assembly_path = if name != [] do
      [new_name] = name
      basename = Path.basename(file_path)
      String.replace(file_path,basename,new_name<>".s")
    else
      String.replace_trailing(file_path, ".c", ".s")
    end

    try do
      lista_tokens=File.read!(file_path)
      |> Sanitizer.sanitize_source()
      |> Lexer.scan_words()

      evaluar = Evaluator.evaluator_lexer(lista_tokens)
      if evaluar == :ok do
        arbolAST=lista_tokens
        |> Parser.parse_program()
        if is_map(arbolAST) do
          arbolAST
          |> CodeGenerator.generate_code()
          |> Linker.generate_binary(assembly_path)
          |> IO.inspect()
        else

          if is_tuple(arbolAST) do
            IO.puts("ERROR SINTACTICO")
            {:error, msj, num_line, problema_atomo} = arbolAST
            line = to_string(num_line)

            if is_tuple(problema_atomo) do #Constante
              {token,int} = problema_atomo
              problema = to_string(token) <> "["<> to_string(int)<>"]"
              msj_error="En linea (#{line}), #{msj}. Cerca de: #{problema}"
              IO.inspect(msj_error)
            else #Es un atomo
              problema = to_string(problema_atomo)
              msj_error="En linea (#{line}), #{msj}. Cerca de: #{problema}"
              IO.inspect(msj_error)
            end
          end

        end
      end
    rescue
      File.Error -> IO.puts("\nError: El fichero o directorio no existe")
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
    IO.puts("\nCode generator ouput (Assembler Code):\n")
    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> Lexer.scan_words()
    |> Parser.parse_program()
    |> CodeGenerator.generate_code()
    |> IO.puts()
  end

  defp print_help_message do
    IO.puts("Commands:")
    IO.puts("\nnqcc --help")
    IO.puts("nqcc --<flag> (path of the .c) \n")

    IO.puts("\nThe compiler supports following options:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end
end
