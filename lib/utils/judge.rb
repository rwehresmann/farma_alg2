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
      # doesn't exists).
      # [1, simple_format(`cat #{filename}-compile_errors | tail -n +5 | sed -e 's/^#{id}-response.pas//'`)]
      { status: 1, message: `cat #{filename}-compile_errors | tail -n +5 | sed -e 's/^#{id}-response.pas//'` }
    else
      { status: 0, message: "#{filename[0..-5]}" }
    end
  end

  def self.test(lang, filename, test_cases, id)
    test_cases.each do |tc|
      input = t.input.split(CASE_TEST_END)
      output = t.output.split(CASE_TEST_END)

      for i in 0...input.length
        input_file = "/tmp/#{id}-input-#{tc.id}-#{i}.dat"
        output_response_file = "/tmp/#{id}-output_response-#{tc.id}-#{i}.dat"

        # Inside a test case, get the "ors"
        output_tmp = output[i].split(OUTPUT_OR)

        File.open(input_file, 'w') {|f| f.write(input[i]) }


      end
    end
  end

  def self.exec_file(filename, lang, timeout, input_file, output_file)
    if lang == "rb"
      filename = "ruby " + filename
    end

    command = "bin/exec_#{Rails.env}.sh #{timeout} #{filename} #{input_file} #{output_file}"

    Rails.logger.info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    `#{command}`
    Rails.logger.info command
    Rails.logger.info $?.exitstatus

    # run ok
    if $?.exitstatus == 0 || $?.exitstatus == 255 || ($?.exitstatus != 143 && $?.exitstatus != 141 && lang == "c")
      result = 1
    # run fail
    else
      result = $?.exitstatus
    end

    # Q: Maybe here is not the best place to put that.
    if Rails.env == "production"
      `sudo pkill -9 -f #{filename}`
    end

    result
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
