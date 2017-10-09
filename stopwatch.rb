class Stopwatch
  def initialize
    @start = Time.now.to_f
  end

  def elapsed_time
    now = Time.now.to_f
    elapsed = (now - @start)

    # If less than 1 second
    if elapsed.round(3) == 0.0
      return "#{(elapsed * 1000).round(4)} milliseconds"
    else
      # If greater than 1 minute
      if elapsed.round(3) > 60
        min, sec = (elapsed.round(3) / 60).to_s.split('.')
        sec = sec.insert(2, '.') if sec.size > 2 # add a decimal
        sec = sprintf('%.2f', sec) # trim it to 2 decimal places
        return "#{min} minute(s) #{sec} seconds"
      end
      # If within 1 minute
      return "#{elapsed.round(3)} seconds"
    end
  end
end
