# Create, provision and destroy virtual servers for these examples at Amazon EC2
# ==============================================================================

require 'fog'

STDOUT.sync = true

ACCESS_KEY_ID     = ENV['AWS_ACCESS_KEY_ID']
SECRET_ACCESS_KEY = ENV['AWS_SECRET_ACCESS_KEY']

unless ACCESS_KEY_ID && SECRET_ACCESS_KEY
  puts "[!] Error: Please provide your AWS credentials as environment variables for the script to continue...",
       "export AWS_ACCESS_KEY_ID=<Your AWS access key>",
       "export AWS_SECRET_ACCESS_KEY=<Your AWS secret access key>"
  exit(1)
end

# Create connection to EC2
#
EC2 = Fog::Compute.new provider:              'AWS',
                       region:                'us-east-1',
                       aws_access_key_id:     ACCESS_KEY_ID,
                       aws_secret_access_key: SECRET_ACCESS_KEY


task :default => ['ec2:launch', 'ec2:provision']

namespace :ec2 do

  desc "Launch and provision new large instance via the Amazon Elastic Computing service"
  task :launch do
    print "Launching new server instance at EC2..."

    # Create new instance...
    #
    s = EC2.servers.create image_id:   'ami-ad36fbc4',
                           flavor_id:  'm1.large',
                           key_name:   'micro',
                           tags:       { Name: 'TestDeployment' }

    # ... and wait until it's started.
    #
    s.start
    s.wait_for do
      STDOUT.print '.'
      ready?
    end

    puts "", "Started instance '#{s.id}' (#{s.flavor_id}) at #{s.dns_name}", '-'*80
  end

  desc "Terminate all servers tagged 'TestDeployment'"
  task :terminate do
    # Select all instances with the proper tag
    #
    servers = EC2.servers.select { |s| s.tags["Name"] == "TestDeployment" && s.state == "running" }

    if servers.size < 1
      puts "No servers running for testing deployment, exiting...", '-'*80
      exit
    end

    puts "Terminating #{servers.size} running servers...", '-'*80
    servers.each do |s|
      puts "* #{s.id} (#{s.flavor.name})"
      s.destroy
    end
  end

  desc "Provision new server with Sprinkle"
  task :provision do
    # Select all instances with the proper tag
    #
    servers = EC2.servers.select { |s| s.tags["Name"] == "TestDeployment" && s.state == "running" }
    
    ENV['DEMO_DEPLOY_HOSTNAME'] = servers.first.dns_name
    exec "time RECIPE='deploy.ec2' sprinkle --script=3-rails-stack-passenger.rb --verbose"
  end

end
