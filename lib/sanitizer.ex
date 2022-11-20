defmodule Sanitizer do
  def sanitize_source(file_content) do
    trimmed_content = String.trim(file_content)
    words = Regex.split(~r/\s+/, trimmed_content)
    cont = 1
    CodeLines.lines(words, cont)
  end
end
