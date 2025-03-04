# app/commands/javascript.rb

module Command
  class Javascript
    def self.execute(code)
      filename = "temp_code.js"
      File.write(filename, code) 

			start_time = Time.now
      output = `node #{filename}.js 2>&1`
      duration = Time.now - start_time

      status = $?.success? ? 'success' : 'failed'
      [output, status, duration.round(2)]
    end
  end
end
