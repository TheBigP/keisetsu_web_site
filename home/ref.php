<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta content="index,follow" name="robots">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="x-rim-auto-match" content="none">
<meta name="Description" content="京設工業株式会社はソフトウェア開発/検証・機械設計・電気設計・エンジニア派遣・DTPデザインの５つの部門からお客様の多様なニーズに応え続けています。">
<meta name="keyword" content="京設工業,ソフトウェア,開発,検証,電気,電子,機械,設計,システム,エンジニア,技術者,採用,人材派遣,転職,求人,プラスチック容器,デザイン,DTP">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--放大界面问题-->
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<!--双击放大-->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- InstanceBeginEditable name="doctitle" -->
<title>ソフトウェア開発/検証・機械設計・電気設計・エンジニア派遣・DTPデザインの京設工業株式会社－ごあいさつ－/システムエンジニア/技術者/人材派遣/転職/プラスチック容器</title>

<!-- InstanceEndEditable -->
<link rel="index" href="http://www.keisetsu.co.jp/">
<link href="./layout.css" rel="stylesheet" type="text/css">
<link href="./keisetsu.css" rel="stylesheet" type="text/css">
<link href="./menu.css" rel="stylesheet" type="text/css">
<link href="./tatemenu.css" rel="stylesheet" type="text/css">
<!--<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>-->
<!-- jQuery CDN - Slim version (=without AJAX) -->
<script src="./js/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
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
<script defer src="./js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="./js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
<!-- Popper.JS -->
<script src="./js/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<!-- jQuery Custom Scroller CDN -->
<script src="./js/jquery.mCustomScrollbar.concat.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("#sidebar").mCustomScrollbar({
            theme: "minimal"
        });

        $('#dismiss, .container').on('click', function() {
            $('#sidebar').removeClass('active');
            $('.container').removeClass('active');
            $('#sidebarCollapse').addClass('menu-content');
            $('#sidebarCollapse').removeClass('menu-content-change');
        });

        $('#sidebarCollapse').on('click', function() {
            var sidebar_menu = $("#sidebar");

            if (sidebar_menu.hasClass("active")) {
                $('#sidebar').removeClass('active');
                $('.container').removeClass('active');
                $('#sidebarCollapse').addClass('menu-content');
                $('#sidebarCollapse').removeClass('menu-content-change');
            } else {
                $('#sidebar').addClass('active');
                $('.container').addClass('active');
                $('.collapse.in').toggleClass('in');
                $('a[aria-expanded=true]').attr('aria-expanded', 'false');
                $('#sidebarCollapse').removeClass('menu-content');
                $('#sidebarCollapse').addClass('menu-content-change');
            }
        });
        loadFacebook();
        $("#frmFacebook").data("last_width", $("iframe").width());
        window.addEventListener('resize', () => {
            if (window.innerWidth - $("#frmFacebook").data("last_width") > 40) {
                loadFacebook();
            }
        });

        function loadFacebook() {
            var src = "https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%25E4%25BA%25AC%25E8%25A8%25AD%25E5%25B7%25A5%25E6%25A5%25AD%25E6%25A0%25AA%25E5%25BC%258F%25E4%25BC%259A%25E7%25A4%25BE-893386934127550%2F&tabs=timeline&&small_header=true&adapt_container_width=true&hide_cover=false&show_facepile=false&appId&width=" + (window.innerWidth - 30);
            // alert(src);
            $("#frmFacebook").attr("src", src);
        }
    });
    $(document).ready(function(e) {
        window.addEventListener('pageshow', function(event) {
            //event.persisted属性为true时，表示当前文档是从往返缓存中获取
            if (event.persisted) location.reload();
        });
    });
</script>
<style>
    .container {
        max-width: 540px;
        margin-top: 18px;
    }

    input::-webkit-input-placeholder {
        vertical-align: baseline;
        font-size: 14px;
    }
</style>