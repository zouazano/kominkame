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
//= require jquery3
//= require popper
//= require bootstrap-sprockets

$(function(){
        $('.carousel').carousel();
        $('.carousel').on('touchstart', touchStart);
        $('.carousel').on('touchmove' , touchMove);

        function touchStart(e) {
            var pos = position(e);
            carousel.attr('data-touchpos',pos.x);
        }
        function touchMove(e) {
            var pos = position(e);
            if( pos.x < $('.carousel').attr('data-touchpos') ){
                $('.carousel').carousel('next');
            }else{
                $('.carousel').carousel('prev');
            }
        }
        function position(e){
            var x = e.originalEvent.touches[0].pageX;
            var y = e.originalEvent.touches[0].pageY;
            x = Math.floor(x);
            y = Math.floor(y);
            var pos = {'x':x , 'y':y};
            return pos;
        }
    });