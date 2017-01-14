$.fn.drakeify = function() {

    var drakeImages = ['img/drake1.png', 'img/drake2.png', 'img/drake3.png', 'img/drake4.png'];

    for (var i = 0; i < drakeImages.length; i++) {
        var drake = '<div class="drake"><div class="drake' + i + '"><img src="' + drakeImages[i] + '">';

        $('body').append(drake);
    }

    return this;

}