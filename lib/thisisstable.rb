require 'thisisstable/version'
require 'fileutils'
module ThisIsStable
  extend self

  def vouch(gem)
    puts "Vouching gem: #{gem}"

    children = []
    5.times do
      children << fork do
        path = "./#{$$}-#{gem}/"
        Dir.mkdir(path) unless Dir.exists?(path)
        trap (:INT) { FileUtils.rm_rf(path); exit 0 }

        loop do
          %x[gem install --install-dir #{path} #{gem}]
          puts "[#{$$}] Installed #{gem}"
          %x[rm -r #{path}]
        end
      end
    end

    trap (:INT) { children.each {|pid| Process.kill("INT", pid)} ; exit 0 }
    Process.waitall
  end
end
