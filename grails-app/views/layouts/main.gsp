<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <g:layoutHead/>
    <r:require module="bootstrap"/>
    <g:javascript library="application"/>
    <r:layoutResources />
    <style>
    .mainBody{
    %{--background: url("${resource(dir: 'images',file: 'slide10_bg.jpg')}");--}%
    }
    #top {
        font-family:Arial, Helvetica, sans-serif;
        font-size:12px;
        color:#fafafa;
        background: #e1f8e1;
        padding:6px 10px;
        position:fixed;
        bottom:60px;
        right:20px;
        display:none;
        cursor: context-menu;
        z-index: 100000;
        background: transparent;
    }
    </style>
</head>
<body>
<g:render template="/templates/navBar"/>
<section>
    <div class="container">
        <div class="row">
            <div class="col-md-12 container-fluid">
                <g:layoutBody/>
            </div>
        </div>
    </div>
</section>
<g:render template="/templates/footer"/>
<r:script>
    $(function() {
        $(window).scroll(function() {
            if($(this).scrollTop() != 0) {
                $('#top').fadeIn();
            } else {
                $('#top').fadeOut();
            }
        });

        $('#top').click(function() {
            $('body,html').animate({scrollTop:0},500);
        });
    });
</r:script>
<r:layoutResources />
</body>
</html>
