require 'etude_for_aws'
load 'etude_for_aws/tasks/vpc.rake'
load 'etude_for_aws/tasks/ec2.rake'

#http://www.chrisjmendez.com/2017/04/24/aws-using-rake-tasks-to-ssh-into-ec2/
namespace :aws do
  desc %Q{ ›› SSH into an EC2 instance. rake aws:ssh[pem,ami,00.00.00.00] }
  task :ssh, [:pem, :os, :ip] do |task, args|
    aws_pem       = args.pem
    aws_user      = user(args.os)
    aws_ip_or_url = args.ip

    sh %{ ssh -i #{aws_pem} #{aws_user}@#{aws_ip_or_url} }
  end

  desc %Q{ ›› SCP files to EC2 Instance. }
  task :upload, [:pem, :os, :ip, :local, :dest] do |task, args|
    assets_dir    = args.local || "/path/to/local/files/you/want/to/upload/*"
    aws_pem       = args.pem
    aws_user      = user(args.os)
    aws_ip_or_url = args.ip
    aws_dir       = args.dest  || "/path/to/destination/directory"
    sh %{ scp -i #{aws_pem} #{assets_dir} #{aws_user}@#{aws_ip_or_url}:#{aws_dir} }
  end

  desc %Q{ ›› Fix PEM permissions. }
  task :fix_pem, [:pem] do |task, args|
    aws_pem = args.pem || "/path/to/aws/file.pem"
    sh %{ chmod -R 600 #{aws_pem} }
  end

  desc %Q{ ›› Get External IP }
  task :external_ip do
    sh %{ curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g' }
  end
end


private

def user(os)
  user = case os
           when "ubuntu" then "ubuntu"
           when "ams"    then "amsadmin"
           when "fms"    then "fmsadmin"
           when "ami"    then "ec2-user"
           when "debian" then "admin"
           when "redhat" then "ec2-user"
           when "fedora" then "fedora"
           when "centos" then "centos"
           when "bitnami" then "bitnami"
           when "freebsd" then "ec2-user"
           else "ec2-user"
         end
  return user
end