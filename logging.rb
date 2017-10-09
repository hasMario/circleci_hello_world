class Logging
  def initialize(logger_level, current_ruby_file)
    @logger = Logger.new(STDOUT)
    @logger.level = logger_level
    @logger.progname = current_ruby_file
    @logger.formatter = proc do |severity, time, progname, msg|
      "#{severity.ljust(7)} [#{time}] [#{progname}] -- #{String === msg ? msg : msg.inspect}\n"
    end
  end

  def return_logger
    return @logger
  end
end
