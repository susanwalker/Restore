require 'net/sftp'
require './src/config.rb'

CONFIG = Config.new_from_config

def backup
  CONFIG.source_destination_pairs.each do |source, destination|
    upload(source, destination)
  end
end

def restore
  CONFIG.source_destination_pairs.each do |source, destination|
    download(destination, source)
  end
end

private

def upload(local_source, remote_destination)
  Net::SFTP.start(CONFIG.host, CONFIG.username, password: CONFIG.password) do |sftp|
    # remove the folder if it already exists
    sftp.session.exec!("rm -rf #{remote_destination}")

    sftp.upload!(local_source, remote_destination, mkdir: true)
  end
end

def download(remote_source, local_destination)
  Net::SFTP.start(CONFIG.host, CONFIG.username, password: CONFIG.password) do |sftp|
    if sftp.file.directory?(remote_source)
      sftp.download(remote_source, local_destination, recursive: true)
    else
      sftp.download(remote_source, local_destination)
    end
  end
end

command = ARGV[0]

if command == "backup"
  backup
elsif command == "restore"
  restore
else
  puts "Bad command #{command}. Expected backup or restore"
end
