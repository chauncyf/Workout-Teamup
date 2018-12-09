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
////= require pnotify.custom

$(function () {

    /*PNotify.defaults.styling='bootstrap4'
    PNotify.defaults.icons='bootstrap4'*/
    // binding all image upload dom
    $(document).on("change", "[data-file-refresh]", function (e) {
        $(this).next().html(e.currentTarget.files[0].name)
    })

    $(document).on("change", "[data-image-push-to]", function (e) {
        let file = e.currentTarget.files[0];
        let id = $(e.currentTarget).data('image-push-to');
        let dom = document.getElementById(id);
        let reader = new FileReader();
        reader.addEventListener('load', () => {
            if (dom.cropper) {
                dom.cropper.replace(reader.result)
            } else {
                dom.src = reader.result
                let cropper = new Cropper(document.getElementById(id), {
                    aspectRatio: 1,
                })
                dom.cropper = cropper
            }
        })
        reader.readAsDataURL(file)
    })
    var posterModal = $('#posterModal')
    $(document).on('click', '.poster .comment', function () {
        let id = $(this).parent().data('id')
        $.ajax({
            url: '/activities/' + id,
            data: {show_comment: true},
            method: 'get',
            success: (data) => {
                posterModal.find('.modal-body').html(data)
                posterModal.modal('show')
            }
        })
    })

    $(document).on('show.bs.dropdown mouseover', '[data-avatar-pop]', function () {
        if ($(this).children('.dropdown-menu').data('loading')) {
            return
        }
        $(this).children('.dropdown-menu').data('loading', 'true')
        $.ajax({
            url: '/users/' + $(this).data('avatar-pop'),
            method: 'get',
            success: (data) => {
                $(this).children('.dropdown-menu').html(data)
            }
        })
        return
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
        let url=''
        if($(this).hasc)
        $.ajax({
            url: '/like_activity',
            method: 'post',
            data: {
                activity_id: $(this).parent().data('id')
            },

        })
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