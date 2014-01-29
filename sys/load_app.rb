# Public: Require all ruby files that match the path specification
class LoadApp
  def initialize(env: "dev")
    require_path "sys/*.rb"
    require_path "actions/*.rb"

    if env == "spec"
      require_path "spec/*.rb"
      require_path "spec/*/*.rb"
    end
  end

  def require_path(path)
    Dir.glob(path).each do |file|
      require_relative "../#{file}"
    end
  end
end
