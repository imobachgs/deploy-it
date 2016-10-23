App.deployer = App.cable.subscriptions.create("DeployerChannel", {
  connected: function() { },
  disconected: function() { },
  received: function(data) {
    // Show content on the dashboard
    // $('.deploy_content').prepend(data['content']);
  }
});
