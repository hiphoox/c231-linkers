defmodule Sanitizer do
  def sanitize_source(file_content) do
    lines = String.split(file_content,"\n") # Separa las líneas de código
    get_lines(lines,1)
  end

  def get_lines(lines,num_line) when lines != [] do
    {line,list_line} = List.pop_at(lines,0) # Obtiene sólo una línea
    if line != "" do
      cl = clean_line(line,num_line) #Límpia la linea de espacios y coloca el número de ln
      cl ++ get_lines(list_line, num_line + 1) #Realiza los pasos con el resto
    else
      get_lines(list_line, num_line + 1)
    end
  end

  def get_lines(_,_) do
    []
  end

  def clean_line(content,num_line) do
    trimmed_content = String.trim(content)
    words = Regex.split(~r/\s+/, trimmed_content)
    Enum.flat_map(words, fn x -> [{x, num_line}] end)
  end

end
