# Public: Require all ruby files that match the path specification
class LoadApp
  def initialize(env: 'dev')
    require 'rubygems'
    require 'bundler/setup'
    require 'mail'

    require_path 'sys/*.rb'
    require_path 'actions/*.rb'

    if env == 'test'
      require_path 'spec/*.rb'
      require_path 'spec/*/*.rb'
    end
  end

  private

  # Internal: require all files that match the path pattern
  def require_path(path)
    Dir.glob(path).each do |file|
      require_relative "../#{file}"
    end
  end
end
