App.cable.subscriptions.create({
    channel: 'MessageChannel',

}, {
    received(data) {
        switch (data.type) {
            case 2:// when some one comment to you
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
                break;
            case 3:// when someone chat with you
                (new PNotify({
                    title: data.msg.title,
                    text: data.msg.text,
                    type: data.msg.type,
                    hide: false,
                    confirm: {
                        prompt: true,
                        prompt_multi_line: true,
                    },
                    buttons: {
                        closer: false,
                        sticker: false
                    },
                })).get().on('pnotify.confirm', function (e, notice, input) {
                    $.ajax({
                        url: '/send_message',
                        method: 'post',
                        data: {
                            target: data.id,
                            content: input
                        },
                        success() {
                            notice.cancelRemove().update({
                                title: 'Message sent!',
                                icon: true,
                                type: 'success',
                                hide: true,

                            });
                        }
                    })
                })
                break;

            case 1:
                if (data.msg) {
                    new PNotify({
                        title: data.msg.title,
                        text: data.msg.text,
                        type: data.msg.type,
                    });
                }
                break;

        }

    }
})