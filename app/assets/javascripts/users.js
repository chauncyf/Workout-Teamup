;(function () {
    $(document).on('click', '#upload_avatar_button', function () {
        $.ajax({
            url: '<%= edit_avatar_path(user.id) %>',
            method: 'get',
            success: function (data) {
                let avatarModal = $('#upload_avatar_modal');
                let modalBody = avatarModal.find('.modal-body');
                modalBody.html(data);
                avatarModal.modal('show')
            }
        })
    }).on('click', '#upload_avatar_modal #submit_avatar', function (e) {
        e.preventDefault();
        document.getElementById('cropper').cropper.getCroppedCanvas().toBlob((blob) => {
            let formData = new FormData()
            formData.append('avatar', blob)
            $.ajax({
                url: '<%= upload_avatar_path(user.id) %>',
                type: 'post',
                data: formData,
                contentType: false,
                processData: false,
                success: () => {
                    avatarModal.modal('hide')
                    $.ajax({
                        url: '<%= user_avatar_url_path(user.id) %>',
                        type: 'get',
                        success: (data) => {
                            $('.avatar').attr('src', data)
                        }
                    })
                }
            })
        })
    })
})()