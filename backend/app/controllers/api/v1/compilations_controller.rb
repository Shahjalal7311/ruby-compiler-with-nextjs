class Api::V1::CompilationsController < ApplicationController
  include ActionController::Live
	skip_before_action :verify_authenticity_token
	
  def create
    # Syntax Validation
    syntax_check = validate_syntax(compilation_params[:language], compilation_params[:code])
    if syntax_check != true
      return render json: compilation_params, status: :unprocessable_entity
    end

    # Execution and Time Tracking
    output, status, execution_time = run_code(compilation_params[:language], compilation_params[:code])
    render json: { output: output, execution_time: execution_time, status: status }, status: :created
  end

  def show
    # compilation = Compilation.find(params[:id])
    # render json: compilation
  end

  def history
    # compilation = Compilation.find(params[:id])
    # history = compilation.compilation_histories.order(version: :desc)
    # render json: history
  end

  private

  def compilation_params
    params.require(:compilation).permit(:language, :code, :code_file)
  end

  def validate_syntax(language, code)
    case language.downcase
    when 'ruby'
      begin
        RubyParser.new.parse(code)
        true
      rescue Racc::ParseError => e
        e.message
      end
		when 'php'
			filename = "temp_syntax_check.php"
			File.write(filename, code)
			output = `php -l #{filename} 2>&1`
			File.delete(filename) if File.exist?(filename)
			output.include?("No syntax errors detected") ? true : output
		when 'javascript'
			filename = "temp_syntax_check.js"
			File.write(filename, code)
			output = `node --check #{filename} 2>&1`
			File.delete(filename) if File.exist?(filename)
			output.empty? ? true : output
		when 'python'
			filename = "temp_syntax_check.py"
			File.write(filename, code)
			output = `python3 -m py_compile #{filename} 2>&1`
			File.delete(filename) if File.exist?(filename)
			output.empty? ? true : output
    else
      "Syntax validation not supported for this language"
    end
  end

  def run_code(language, code)
    case language.downcase
    when 'ruby'
			require_relative '../../../commands/ruby'
      output = Command::Ruby.execute(code)
    when 'javascript'
			require_relative '../../../commands/javascript'
      output = Command::Javascript.execute(code)
		when 'php'
			require_relative '../../../commands/php'
      output = Command::Php.execute(code)
		when 'python'
			require_relative '../../../commands/python'
      output = Command::Python.execute(code)
    else
      return ["Language not supported", "failed", 0]
    end
  end
end
