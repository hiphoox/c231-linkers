defmodule Nqcc do
  @moduledoc """
  Documentation for Nqcc.
  """
  @commands %{
    "help" => "Prints this help",
    "asm" => "Shows the assembly code",
    "tl" => "Shows token list",
    "aa" => "Shows AST Tree"
  }

  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean])
    OptionParser.parse(args, switches: [asm: :boolean])
    OptionParser.parse(args, switches: [tl: :boolean])
    OptionParser.parse(args, switches: [aa: :boolean])
  end

  defp process_args({[help: true], _, _}) do
    print_help_message()
  end

  defp process_args({[asm: true], _, _}) do
    print_asm_message()
  end

  defp process_args({[tl: true], _, _}) do
    print_tl_message()
  end

  defp process_args({[aa: true], _, _}) do
    print_aa_message()
  end

  defp process_args({_, [file_name], _}) do
    compile_file(file_name)
  end

  defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    File.read!(file_path)
    |> Sanitizer.sanitize_source()
    |> IO.inspect(label: "\nSanitizer ouput")
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nLexer ouput")
    |> Parser.parse_program()
    |> IO.inspect(label: "\nParser ouput")
    |> CodeGenerator.generate_code()
    |> Linker.generate_binary(assembly_path)
  end

  defp print_help_message do
    IO.puts("\nnqcc --help file_name \n")

    IO.puts("\nThe compiler supports following options:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end

  defp print_asm_message do
    IO.puts("\nnqcc --asm file_name \n")

    IO.puts("\nThe compiler shows the assembly code\n")
  end

  defp print_tl_message do
    IO.puts("\nnqcc --tl file_name \n")

    IO.puts("\nThe compiler shows the token list\n")
  end

  defp print_aa_message do
    IO.puts("\nnqcc --aa file_name \n")

    IO.puts("\nThe compiler shows the AST Tree\n")
  end


end
