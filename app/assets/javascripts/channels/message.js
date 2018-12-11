App.cable.subscriptions.create({
    channel: 'MessageChannel',

}, {
    received(data) {
        if (data.type == 2) {// need to show poster
            new PNotify({
                title: data.msg.title,
                text: data.msg.text,
                type: data.msg.type
            });
            return
        }
        if (data.msg) {
            new PNotify({
                title: data.msg.title,
                text: data.msg.text,
                type: data.msg.type,
            });
        }
    }
})