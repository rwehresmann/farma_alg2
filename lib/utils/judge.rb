module Judge
  CASE_TEST_END = "<--FIM-->\n"
  OUTPUT_OR = "<--OU-->\n"

  # Save the source code in a file and call the compiler script. This script
  # returns in the last line the number of errors after compilation.
  def self.compile(lang = "pas", source_code, id)
    filename = "/tmp/#{id}-response.#{lang}"
    save_source_code(filename, source_code)

    result = `bin/compile #{lang} #{filename} #{filename[0..-5]} #{filename}-compile_errors`

    if has_error?(result)
      # TODO: Make simple_format work (a message error says that the method
      # doesn't) exists.
      # [1, simple_format(`cat #{filename}-compile_errors | tail -n +5 | sed -e 's/^#{id}-response.pas//'`)]
      [1, `cat #{filename}-compile_errors | tail -n +5 | sed -e 's/^#{id}-response.pas//'`]
    else
      [0,"#{filename[0..-5]}"]
    end
  end


  # AUXILIARY METHODS

  # Search by 'error' word (case-insensitive). Result is and error or
  # 0 (no error).
  def self.has_error?(result)
    !result.scan(/(?i)error/).empty?
  end

  def self.save_source_code(filename, source_code)
    File.open(filename, 'w') { |f| f.write(source_code) }
  end
end
