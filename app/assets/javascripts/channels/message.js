App.cable.subscriptions.create({
    channel: 'MessageChannel',

}, {
    received(data) {
        if (data.msg) {
            new PNotify({
                title: data.msg.title,
                text: data.msg.text
            });
        }
    }
})