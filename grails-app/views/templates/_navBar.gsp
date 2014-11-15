<%
    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService = grailsApplication.mainContext.getBean("springSecurityService");
    def utilityService = grailsApplication.mainContext.getBean("utilityService");
%>
<style>
.logo{
    letter-spacing: -10px;
    font-size: xx-large;
    text-decoration: line-through overline;
    
}
</style>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <b><a class="navbar-brand"  href="#"><span class="logo">E$</span></a></b>
    </div>
    <p class="navbar-text"> <span style="text-transform:capitalize;color: #e5f55e">
        %{--${springSecurityService.getCurrentUser()?.firstName +" "+ springSecurityService.getCurrentUser()?.lastName}--}%
    </span></p>
    <div class="container">

        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><g:link class="home" controller="user" action="dashboard">Home</g:link></li>
                <li><g:link class="list" controller="topic" action="index">Topics</g:link></li>

                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Resources <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><g:link class="list" controller="documentResource" action="index">Documents</g:link></li>
                        <li><g:link class="list" controller="linkResource" action="index">Links</g:link></li>
                        <li><g:link class="list" controller="question" action="dashboard">Questions</g:link></li>
                    </ul>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Invites <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><g:link class="list" controller="invites" action="sent">Invites Sent</g:link></li>
                        <li><g:link class="list" controller="invites" action="received">Invites Received</g:link></li>
                        %{--<li class="divider"></li>--}%
                        %{--<li class="dropdown-header">Nav header</li>
                        <li><a href="#">Separated link</a></li>
                        <li><a href="#">One more separated link</a></li>--}%
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <div class="input-group">
                        <input type="text" class="input-large search-query " name="searchText" placeholder="Search..."" value="" style="height:28px;margin-top: 8px;"/>

                    </div>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img height="25px" width="25px" src="${resource(dir: 'images',file: 'Settings-icon.png')}" title="Settings"/><span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li class="dropdown-header"><img height="15px" width="15px" src="${resource(dir: 'images',file: 'securitySetting.png')}"/>&nbsp;Administration</li>
                        <li><g:link class="list" controller="user" action="administration"><img height="15px" width="15px" src="${resource(dir: 'images',file: 'user-settings-icon.png')}"/>&nbsp;User Settings</g:link></li>
                        <li><g:link class="list" controller="invites" action="sent"><img height="15px" width="15px" src="${resource(dir: 'images',file: 'color_settings.png')}"/>&nbsp;Change Options</g:link></li>
                        <li><g:link class="list" controller="invites" action="sent"><img height="15px" width="15px" src="${resource(dir: 'images',file: 'options.png')}"/>&nbsp;Change Theme</g:link></li>
                        <li class="divider"></li>
                        <li class="dropdown-header"> Configuration</li>
                        <li><a href="#"><img height="15px" width="15px" src="${resource(dir: 'images',file: 'home-icon.png')}"/> Home</a></li>
                        <li><a href="#">Pending</a></li>
                    </ul>

                </li>
                <sec:ifLoggedIn>
                    <li><g:link  controller="logout" type="POST">Logout</g:link></li>
                </sec:ifLoggedIn>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>