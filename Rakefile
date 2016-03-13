# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

# code for managing .mrconfig
namespace :mr do
  desc 'update the mrconfig file'
  task :config do
    dir = File.expand_path(File.dirname(__FILE__)+'/..')
    puts "dir: #{dir}"
    cfg = <<-EOF
# THIS FILE IS UPDATED WITH A COMMAND
# update this file with:
# > rake mr:config
#
# to setup use of mrconfig:
# get the mr tool with:
# > brew install mr
#
# then, create the ~/.mrconfig and ~/.mrsetup files
# > rake mr:setup
# *** if the files exist, it will print the output instead
    EOF
    list = Dir["#{dir}/slnky-*"] - ["#{dir}/slnky-server"]
    list.sort.each do |d|
      n = d.split('/').last
      r = `cd #{d} && git remote -v | head -1 | awk '{print $2}'`.chomp.gsub(/\.git$/, '')
      puts "- #{n}: #{d}: #{r}"
      cfg << "[../#{n}]\n"
      cfg << "checkout = git clone '#{r}' '#{n}'\n"
      cfg << "\n"
    end
    File.open('.mrconfig', 'w+') { |f| f.write(cfg) }
  end

  desc 'setup the mrconfig and mrtrust files'
  task :setup do
    dir = File.expand_path(File.dirname(__FILE__))
    n = dir.split('/').last
    r = `git remote -v | head -1 | awk '{print $2}'`.chomp
    home = ENV['HOME']
    rel = dir.gsub(/^#{home}\//, '')
    cfg = <<-EOF
[#{rel}]
checkout = git clone '#{r}' '#{n}'
chain = true
    EOF
    trust = <<-EOF
#{dir}/.mrconfig
    EOF
    if File.exists?("#{home}/.mrconfig")
      puts <<-EOF
config file exists, printing instead:
---
#{cfg}
---
      EOF
    else
      File.open("#{ENV['HOME']}/.mrconfig", 'w+') {|f| f.write cfg}
    end
    if File.exists?("#{home}/.mrtrust")
      puts <<-EOF
trust file exists, printing instead:
---
#{trust}
---
      EOF
    else
      File.open("#{ENV['HOME']}/.mrtrust", 'w+') {|f| f.write trust}
    end
  end
end
