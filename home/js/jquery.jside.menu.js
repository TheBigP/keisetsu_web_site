/*  Plugin: jSide Menu (Responsive Side Menu) 
 *   Frameworks: jQuery 3.3.1 & Material Design Iconic Font 2.0
 *   Author: Asif Mughal
 *   GitHub: https://github.com/CodeHimBlog
 *   URL: https://www.codehim.com
 *   License: MIT License
 *   Copyright (c) 2018 - Asif Mughal
 */
/* File: jquery.jside.menu.js */
(function ($) {
  $.fn.jSideMenu = function (options) {
    var setting = $.extend({
      jSidePosition: "position-left", //possible options position-left or position-right 
      jSideSticky: true, // menubar will be fixed on top, false to set static
      jSideSkin: "default-skin", // to apply custom skin, just put its name in this string

    }, options);

    return this.each(function () {
      var target, $headHeight,
        $devHeight,
        jSide,
        arrow,
        dimBackground;
      target = $(this);

      /* Accessing DOM */
      jSide = $(".menu-container, .menu-head");
      $devHeight = $(window).height();
      $headHeight = $(".menu-head").height();
      arrow = document.createElement("i");
      dimBackground = $(".dim-overlay");
      // Set the height of side menu according to the available height of device
      // $(target).css({
      //   'height': $devHeight - $headHeight,

      // });

      if (setting.jSideSticky == true) {
        $(".menubar").addClass("sticky");
      } else {
        $(".menubar").removeClass("sticky");
      }

      $(".menubar").addClass(setting.jSideSkin);
      $(jSide).addClass(setting.jSideSkin).addClass(setting.jSidePosition);

      if ($(jSide).hasClass("position-left")) {
        $(".menu-trigger").addClass("left").removeClass("right");
      }
      else {
        $(".menu-trigger").removeClass("left").addClass("right");
      }

      //Dropdown Arrow
      $(arrow).addClass("zmdi zmdi-chevron-down arrow").appendTo(".dropdown-heading");

      //Dropdowns
      $(".dropdown-heading").click(function () {
        var key = [];
        var tmp = 0;
        $(".has-sub").find("span:hover + ul").each(function () {
          $(this).find('li').each(function () {
            tmp = tmp + $(this).outerHeight();
            key.push($(this).outerHeight());
          });
          console.log("key+++    " + key);
        });
        //遍历该数组可以获取所有值
        //  for (var i = 0 ; i < key.length; i++) {
        //       //todo
        //  }

        // var n=0;
        // var h=0;
        // var n = $(".has-sub").find("span:hover + ul li").length;
        // var h = $(".has-sub").find("span:hover + ul li").outerHeight();
        // console.log("n+++   " + n);
        // console.log("h+++   " + h);
        // var dropdown = h*n;
        // console.log("dropdown+++   " + dropdown);
        var todrop = $(".has-sub").find("span:hover + ul");
        var nodrop = $(".has-sub ul");
        console.log("tmp++++    " + tmp);
        $(todrop).animate({ "height": tmp }, 100);
        $(this).find("i").toggleClass("arrowdown");
        // console.log("$(todrop).height() ++++    " + $(todrop).height());
        if ($(todrop).height() == tmp || $(todrop).height() == (tmp + 1)) {
          $(todrop).animate({ "height": 0 }, 100);
        }
        // console.log("$(nodrop).height(dropdown) +++   " + $(nodrop).height(dropdown))
        // console.log("$(nodrop).height() +++   " + $(nodrop).height())
        if ($(nodrop).height(tmp)) {
          $(nodrop).not(todrop).height(0); $(".dropdown-heading").not(this).find("i").removeClass("arrowdown");
        }
      });

      $(".menu-trigger").click(function () {
        $(jSide).toggleClass("open");
        $(dimBackground).show();
      });

      //close menu if user click outside of it
      $('div').click(function (e) {
        // alert("dianjile");
        if ($(e.target).closest('.menu-trigger').length) {
          console.log("++++++" + $(e.target).closest('.menu-trigger').length);
          // alert("+++    " + $(e.target).closest('.menu-trigger').length);
          return;
        }
        if ($(e.target).closest(jSide).length) {
          console.log("------" + $(e.target).closest(jSide).length);
          return;
        }
        // alert("+++    " + $(e.target).closest('.menu-trigger').length);
        $(jSide).removeClass("open");
        if (!$(jSide).hasClass("open")) {
          $(dimBackground).hide();
        }
      });
    });
  };

})(jQuery);
/*   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */