// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery.raty
//= require cropper
//= require lodash
//= require echarts
//= require pnotify.custom
//= require html2canvas
//= require users

$(function () {
    $('[data-toggle="tooltip"]').tooltip()

    $(document).on('turbolinks:before-cache', function () {
        // don't cache any pnotify elements, just let them pass
        PNotify.removeAll()
    })

    /*PNotify.defaults.styling='bootstrap4'
    PNotify.defaults.icons='bootstrap4'*/


    // binding all image upload dom
    $(document).on("change", "[data-file-refresh]", function (e) {
        $(this).next().html(e.currentTarget.files[0].name)
    }).on("change", "[data-image-push-to]", function (e) {
        let target = e.currentTarget
        let $target = $(target)
        let file = target.files[0];
        let id = $target.data('image-push-to');
        let dom = document.getElementById(id);
        let reader = new FileReader();
        reader.addEventListener('load', () => {
            if (dom.cropper) {
                dom.cropper.replace(reader.result)
            } else {
                dom.src = reader.result
                let cropper = new Cropper(document.getElementById(id), {
                    aspectRatio: $target.data('ratio') ? $target.data('ratio') : NaN,
                })
                dom.cropper = cropper
            }
        })
        reader.readAsDataURL(file)
    })


    window.showPosterInModal = function (arg) {
        var posterModal = $('#posterModal')
        if ($.contains(posterModal[0], this)) {// if already in the modal
            let comment_submit = posterModal.find('.comment_submit')
            comment_submit[0].scrollIntoView({
                behavior: 'smooth',
            })
            comment_submit.parent().prev().focus()
            return
        }
        let id = isNaN(arg) ? $(this).parent().data('id') : arg
        window.posterModalRefresh = () => {
            $.ajax({
                url: '/activities/' + id,
                data: {show_comment: true},
                method: 'get',
                success: (data) => {
                    posterModal.find('.modal-body').html(data)
                    posterModal.modal('show')
                    if (!isNaN(arg)) {
                        // make sure we scroll to the bottom
                        // by clicking the comment button
                        posterModal.one('shown.bs.modal', function () {
                            setTimeout(() => {
                                posterModal.find('.poster .comment').click()
                            }, 200)
                        })
                    }
                }
            })
        }
        posterModalRefresh()
    }
    $(document).on('click', '.poster .comment', showPosterInModal)

    $(document).on('show.bs.dropdown mouseover', '[data-avatar-pop]', function () {
        if ($(this).children('.dropdown-menu').data('loading')) {
            return
        }
        $(this).children('.dropdown-menu').data('loading', true)
        $.ajax({
            url: '/users/' + $(this).data('avatar-pop'),
            method: 'get',
            success: (data) => {
                $(this).children('.dropdown-menu').html(data)
            }
        })
    })
    /*$(document).popover({
        selector: '[data-avatar-pop]',
        content() {
            if ($(this).data('data-content')) return
            $.ajax({
                url: '/users/' + $(this).data('avatar-pop'),
                success: (data) => {
                    $(this).attr('data-content', data)
                    $(this).popover('hide')
                    $(this).popover('show')
                }
            })
            return 'loading...'
        },
        template: '<div class="popover avatar-pop" role="tooltip">' +
            '<div class="arrow"></div>' +
            '<div class="popover-body"></div>' +
            '</div>',
        trigger: 'click',
        html: true
    })*/

    $(document).on('click', '.poster .like', function () {
        let url = ''
        if ($(this).hasClass('fa')) {// means already liked
            url = '/unlike_activity'
        } else {
            url = '/like_activity'
        }
        $.ajax({
            url: url,
            method: 'post',
            data: {
                activity_id: $(this).parent().data('id')
            },
        })
    }).on('click', '.poster .comment_submit', function () {
        let $this = $(this)
        if ($this.attr('disabled')) return
        let textArea = $this.parent().prev()
        if (textArea.val().length === 0) {
            new PNotify({
                text: 'Comment cannot be empty!',
                type: 'error'
            })
            return
        }
        $this.attr('disabled', true)
        $.ajax({
            url: '/comments',
            dataType: 'script',
            data: {
                comment: {
                    activity_id: $this.data('id'),
                    content: textArea.val(),
                }
            },
            method: 'post',
        })
    })
    $(document).on('click', '.poster [data-upload-picture]', function () {
        let $this = $(this)
        let id = $this.data('upload-picture')
        $.ajax({
            url: '/photos/new',
            method: 'get',
            success(data) {
                $('#upload_picture_modal').modal('show')
                    .find('.modal-body').html(data)
                $('#upload_picture_modal').data('activity_id', id)
            }
        })

    }).on('click', '#upload_picture_modal .submit', function (e) {
        e.preventDefault();
        let picModal = $('#upload_picture_modal')
        document.getElementById('photo_upload_preview').cropper.getCroppedCanvas().toBlob((blob) => {
            let formData = new FormData()
            formData.append('photo', blob)
            formData.append('activity_id', picModal.data('activity_id'))
            $.ajax({
                url: '/photos',
                method: 'post',
                data: formData,
                contentType: false,
                dataType: 'json',
                processData: false,
                success: () => {
                    picModal.modal('hide')
                    // refresh data here if needed
                }
            })
        })
    })
    $(document).on('click', 'a[data-chat],img.avatar[data-chat]', function () {
        let $this = $(this)
        let id = $this.data('chat')
        let modal = $('#send_message_modal')
        $.ajax({
            url: '/send_message/' + id,
            method: 'get',
            success(data) {
                modal.children().children().html(data)
                modal.modal('show')
            }
        })
    }).on('click', '#send_message_modal .submit', function () {
        let $this = $(this)
        $.ajax({
            url: '/send_message',
            method: 'post',
            data: {
                target: $this.data('id'),
                content: $this.parent().prev().children().val()
            },
            success() {
                new PNotify({
                    title: '<i class="fas fa-check-circle"></i> Message sent',
                    type: 'success',
                    delay: 2000
                });
                $('#send_message_modal').modal('hide')
            }
        })
    })

    $(document).on('click', '#post_display_container_joined .page-item-num,' +
        ' #post_display_container_started .page-item-num', function () {
        let $this = $(this)
        $this.parent().children('.active').removeClass('active')
        $this.addClass('active')
        refreshPosts()
    })

    $(document).on('click', '.show_follows', function () {
        let $this = $(this)
        setTimeout(()=>{
            refreshPosts(true)
        },0)
    })

    $(document).on('click', '.poster_type', function () {
        let $this = $(this)
        $this.toggleClass('active')
        refreshPosts(true)
    })

})

function dataURItoBlob(dataURI) {
// convert base64/URLEncoded data component to raw binary data held in a string
    var byteString;
    if (dataURI.split(',')[0].indexOf('base64') >= 0)
        byteString = atob(dataURI.split(',')[1]);
    else
        byteString = unescape(dataURI.split(',')[1]);
// separate out the mime component
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
// write the bytes of the string to a typed array
    var u8a = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        u8a[i] = byteString.charCodeAt(i);
    }
    return new Blob([u8a], {type: mimeString});
}

window.ratyAll = _.throttle(() => {
    $('[data-raty]').each(function () {
        $(this).raty({
            starType: 'i',
            score: $(this).data('score') || 0,
            click(param) {
                $.ajax({
                    method: 'put',
                    url: `/activity_participants/${$(this).data('id')}.json`,
                    data: {
                        activity_participant: {
                            rating: param
                        }
                    },
                    success(data) {
                        if (data.id) {
                            new PNotify({
                                title: '<i class="fas fa-check-circle"></i> Activity Rated',
                                text: 'Thanks for your feedback',
                                type: 'success',
                                delay: 2000
                            });
                        }
                    }
                })
            }
        }).removeAttr('data-raty')
    })
}, 300)
