;(function () {
    let messages = []
    let loadFlag = false
    App.messageChannel = App.cable.subscriptions.create({
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
                    if (loadFlag) {
                        showMessage(data)
                    } else {
                        messages.push(data)
                    }
                    // send message back so it will be marked as read
                    /*App.cable.MessageChannel.send({
                        id: data.chat_id,
                        type: 3// confrim message received
                    })*/
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

        },

    })

    $(document).on('turbolinks:load', function () {
        loadFlag = true
        messages.forEach((value, index) => {
            showMessage(value)
        })
        messages.length = 0
    })

    function showMessage(data) {
        console.log('showMessage', data)
        setTimeout(() => {
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
                            text: input,
                            icon: true,
                            type: 'success',
                            hide: true,

                        });
                    }
                })
            })
            // send message back so it will be marked as read
            App.messageChannel.send({
                id: data.chat_id,
                type: 3// confrim message received
            })
        }, 300)
    }
})()