App.cable.subscriptions.create({
    channel: 'MessageChannel',
}, {
    received(data) {
        console.log(data)
    }
})