# Upload a file to a backup IP host: 10.0.0.135
  # user:susan, password:kitties!
  # /home/susan/Documents/backup
require 'net/sftp'

def upload(local_source, remote_destination)
  Net::SFTP.start('10.0.0.135', 'susan', password: 'kitties!') do |sftp|
    sftp.upload!(local_source, remote_destination)
  end
end

def download(remote_source, local_destination)
  Net::SFTP.start('10.0.0.135', 'susan', password: 'kitties!') do |sftp|
    sftp.download!(remote_source, local_destination)
  end
end

# Iterate through all files in a folder
