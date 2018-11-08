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

//= require cropper
$(function () {
    $(document).on("change", "[data-file-refresh]", function (e) {
        $(this).next().html(e.currentTarget.files[0].name)
    })

    $(document).on("change", "[data-image-push-to]", function (e) {
        var file = e.currentTarget.files[0]
        var id = $(e.currentTarget).data('image-push-to')
        var dom = document.getElementById(id)
        var reader = new FileReader()
        reader.addEventListener('load', () => {
            if (dom.cropper) {
                dom.cropper.replace(reader.result)
            } else {
                dom.src = reader.result
                var cropper = new Cropper(document.getElementById(id), {
                    aspectRatio: 1,
                    cropend() {
                        var canvas = cropper.getCroppedCanvas('image/jpeg')
                        var dataUrl = canvas.toDataURL()
                        var file = dataURItoBlob(dataUrl)
                        e.currentTarget.files[0] = file
                        console.log(dataUrl)
                    }
                })
            }
            //document.getElementById(id).style.display='none'
        })
        reader.readAsDataURL(file)
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
    var ia = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }
    return new Blob([ia], {type: mimeString});
}