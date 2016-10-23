App.deployment = App.cable.subscriptions.create('DeploymentChannel', {
  connected: function() {
    console.log("Connected!");
  },
  disconnected: function() {
    console.log("Disconnected!");
  },
  received: function(data) {
    $('div.deployment-status').html("<span class=\"is-" + data.status.toLowerCase() + "\">" + data.status + "</span>")
  }
});
