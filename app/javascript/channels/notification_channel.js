import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("Connected to NotificationChannel");
  },

  disconnected() {
    console.log("Disconnected from NotificationChannel");
  },

  received(data) {
    console.log("Received data: ", data); // You can replace this with code to update the UI
  }
});
