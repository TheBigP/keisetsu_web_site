<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta content="index,follow" name="robots">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="x-rim-auto-match" content="none">
<meta name="Description" content="京設工業株式会社はソフトウェア開発/検証・機械設計・電気設計・エンジニア派遣・DTPデザインの５つの部門からお客様の多様なニーズに応え続けています。">
<meta name="keyword" content="京設工業,ソフトウェア,開発,検証,電気,電子,機械,設計,システム,エンジニア,技術者,採用,人材派遣,転職,求人,プラスチック容器,デザイン,DTP">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- InstanceBeginEditable name="doctitle" -->
<title>ソフトウェア開発/検証・機械設計・電気設計・エンジニア派遣・DTPデザインの京設工業株式会社－ごあいさつ－/システムエンジニア/技術者/人材派遣/転職/プラスチック容器</title>

<!-- InstanceEndEditable -->
<link rel="index" href="http://www.keisetsu.co.jp/">
<link href="./layout.css" rel="stylesheet" type="text/css">
<link href="./keisetsu.css" rel="stylesheet" type="text/css">
<link href="./menu.css" rel="stylesheet" type="text/css">
<link href="./tatemenu.css" rel="stylesheet" type="text/css">
<!--<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>-->
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./material-design/css/material-design-iconic-font.css" />
<link rel="stylesheet" href="./css/jside-menu.css" />
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->

<!-- 新增内容 -->
<!-- Our Custom CSS -->
<link rel="stylesheet" href="style3.css">
<!-- Scrollbar Custom CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">

<!-- Font Awesome JS -->
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ"
        crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY"
        crossorigin="anonymous"></script>
<!-- jQuery CDN - Slim version (=without AJAX) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<!-- Popper.JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
        crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>
<!-- jQuery Custom Scroller CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#sidebar").mCustomScrollbar({
            theme: "minimal"
        });

        $('#dismiss, .container').on('click', function () {
            $('#sidebar').removeClass('active');
            $('.container').removeClass('active');
        });

        $('#sidebarCollapse').on('click', function () {
            $('#sidebar').addClass('active');
            $('.container').addClass('active');
            $('.collapse.in').toggleClass('in');
            $('a[aria-expanded=true]').attr('aria-expanded', 'false');
        });
    });
    $(function(){
        pushHistory();
        var state;
        window.addEventListener("hashchange", function(e) {
            // alert("我监听到了浏览器的返回按钮事件啦" + e.oldURL + "    " + e.newURL);//根据自己的需求实现自己的功能
            var num = e.newURL.indexOf('#');
            var str = e.newURL.substring(num);
            if(window.location.hash){
                $('#sidebar').removeClass('active');
                $('.container').removeClass('active');
                return;
            }
            history.go(-1);
        }, false);
        function pushHistory() {
            state = {
                title: "title",
                url: ""
            };
            window.history.pushState(state, "title", "#");
        }
    });
</script>
<style>
    .container {
        max-width: 540px;
    }
</style>