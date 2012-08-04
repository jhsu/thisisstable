require 'thisisstable/version'
require 'fileutils'
module ThisIsStable
  extend self

  def popularize(gem)
    3.times do
      fork do
        puts "Popularizing '#{gem}'"
        path = "./#{$$}-#{gem}/"
        Dir.mkdir(path) unless Dir.exists?(path)
        trap (:INT) { FileUtils.rm_rf(path); exit 0 }

        loop do
          %x[gem install --install-dir #{path} #{gem}]
          puts "[#{$$}] Installed #{gem}"
          %[gem uninstall --install-dir #{path}]
        end
      end
    end
    Process.waitall
    exit 0
  end
end
