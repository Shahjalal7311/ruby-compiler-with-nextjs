# app/commands/ruby.rb

module Command
  class Ruby
    def self.execute(code)
      filename = "temp_code.rb"
      File.write(filename, code)  # Write the code to a temporary file

      start_time = Time.now
      output = `ruby #{filename} 2>&1`
      duration = Time.now - start_time

      status = $?.success? ? 'success' : 'failed'
      [output, status, duration.round(2)]
    end
  end
end
