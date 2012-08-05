require 'thisisstable/version'
require 'fileutils'
module ThisIsStable
  extend self

  def vouch(gem)
    puts "Vouching gem: #{gem}"
    3.times do
      fork do
        path = "./#{$$}-#{gem}/"
        Dir.mkdir(path) unless Dir.exists?(path)
        trap (:INT) { FileUtils.rm_rf(path); exit 0 }

        loop do
          %x[gem install --install-dir #{path} #{gem}]
          puts "[#{$$}] Installed #{gem}"
          %x[gem uninstall -x -q --install-dir #{path} #{gem}]
        end
      end
    end
    Process.waitall
  end
end
