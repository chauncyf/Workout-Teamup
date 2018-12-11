App.cable.subscriptions.create({
    channel: 'MessageChannel',

}, {
    received(data) {
        if (data.type == 2) {// need to show poster
            (new PNotify({
                title: data.msg.title,
                text: data.msg.text,
                type: data.msg.type,
                hide: false,
                confirm: {
                    confirm: true
                },
                buttons: {
                    closer: false,
                    sticker: false
                },
            })).get().on('pnotify.confirm', function () {
                showPosterInModal(data.id)
            }).on('pnotify.cancel', function () {
                // do nothing
            })
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