# app/commands/Python.rb

module Command
  class Python
    def self.execute(code)
      filename = "temp_code.py"
      File.write(filename, code) 

			start_time = Time.now
      output = `python3 #{filename} 2>&1`
      duration = Time.now - start_time

      status = $?.success? ? 'success' : 'failed'
      [output, status, duration.round(2)]
    end
  end
end
