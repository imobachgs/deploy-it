# Represents the status of a {Deployment}
#
# * Pending: the deploy hasn't started.
# * Running: configuration is being deployed.
# * Success: successful deployment.
# * Failed:  failed deployment.
# * Unknown: something went wrong and the status cannot be determined
#            (e.g. the connection went down).
class DeploymentStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Pending' },
    { id: 2, name: 'Running' },
    { id: 3, name: 'Success' },
    { id: 4, name: 'Failed' },
    { id: 5, name: 'Unknown' }
  ]
end
