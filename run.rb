d = Deployment.first
deployer = Deployer.new("172.28.128.4", User.first, d.configuration, ["database,rails"])
deployer.deploy

