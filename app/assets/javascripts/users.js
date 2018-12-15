;(function () {
    $(() => {
        $(document).on('click', '.follow[data-id]', function () {
            let userId = $(this).data('id');
            let follow_status = $(this).data('follow');
            if (follow_status) {
                $.ajax({
                    url: 'unfollow/' + userId,
                    method: 'delete',
                    success: () => {
                        $(this).html('Follow');
                    }
                })
            } else {
                $.ajax({
                    url: 'follow/' + userId,
                    method: 'post',
                    success: () => {
                        $(this).html('Unfollow');
                    }
                })
            }
        })
    })
})()