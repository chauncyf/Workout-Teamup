App.cable.subscriptions.create({
    channel: 'MessageChannel',

}, {
    received(data) {
        new PNotify({
            title: data.msg.title,
            text: data.msg.text
        });
    }
})