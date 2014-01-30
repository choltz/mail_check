# Public: fake logger object that looks like the logger but does nothing
# It helps avoid nil? checks
class NoLogger
  def debug(message); end
  def error(message); end
  def info(message);  end
end
