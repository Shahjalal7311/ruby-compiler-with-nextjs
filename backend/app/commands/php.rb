# app/commands/php.rb
module Command
  class Php
    def self.execute(code)
      filename = "temp_code.php"
      File.write(filename, code)  # Write the code to a temporary file

      start_time = Time.now
      output = `php #{filename} 2>&1`

      duration = Time.now - start_time
      status = $?.success? ? 'success' : 'failed'
      [output, status, duration.round(2)]
    rescue => e
      puts "Error executing PHP: #{e.message}"
      ["Execution error: #{e.message}", "failed", 0]
    end
  end
end
