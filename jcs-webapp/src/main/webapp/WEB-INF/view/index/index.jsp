<%--
  Created by IntelliJ IDEA.
  User: pc-20171224
  Date: 2018/2/28
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="js/locale/easyui-lang-zh_CN.js">
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
</head>
<script type="application/javascript">
    $(function () {
        //动态菜单数据
        var treeData = [{
            text : "系统菜单",
            "iconCls":"icon-more",
            children : [{
                text : "学生管理",
                "iconCls":"icon-man",
                attributes : {
                    url : "view/studentManager.jsp"
                }
            }, {
                text : "作业管理",
                "iconCls":"icon-pencil",
                attributes : {
                    url : "view/workManager.jsp"
                }

            },
                {
                    text:"上传作业",
                    "iconCls":"icon-redo",
                    attributes : {
                        url : "view/uploadWork.jsp"
                    }
                },
                {
                    text:"回答作业",
                    "iconCls":"icon-edit",
                    attributes : {
                        url : "view/doWork.jsp"
                    }
                },
            {
                text : "成绩管理",
                "iconCls":"icon-filter",
                state : "closed",
                "children":[
                    {
                        text : "所有成绩",
                        "iconCls":"icon-sum",
                        attributes : {
                            url : "view/allResult.jsp"
                        }
                    }
                ]
            }
            ]
        }
        ];

        //实例化树形菜单
        $("#tree").tree({
            data : treeData,
            lines : true,
            onClick : function (node) {
                if (node.attributes) {
                    Open(node.text, node.attributes.url);
                }
            }
        });
        //在右边center区域打开菜单，新增tab
        function Open(text, url) {
            if ($("#tabs").tabs('exists', text)) {
                $('#tabs').tabs('select', text);
            } else {
                var content="<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%;' src="+url+"></iframe>";
                $('#tabs').tabs('add', {
                    title : text,
                    closable : true,
                    content : content
                });
            }
        }

        //绑定tabs的右键菜单
        $("#tabs").tabs({
            onContextMenu : function (e, title) {
                e.preventDefault();
                $('#tabsMenu').menu('show', {
                    left : e.pageX,
                    top : e.pageY
                }).data("tabTitle", title);
            }
        });

        //实例化menu的onClick事件
        $("#tabsMenu").menu({
            onClick : function (item) {
                CloseTab(this, item.name);
            }
        });

        //几个关闭事件的实现
        function CloseTab(menu, type) {
            var curTabTitle = $(menu).data("tabTitle");
            var tabs = $("#tabs");

            if (type === "close") {
                tabs.tabs("close", curTabTitle);
                return;
            }

            var allTabs = tabs.tabs("tabs");
            var closeTabsTitle = [];

            $.each(allTabs, function () {
                var opt = $(this).panel("options");
                if (opt.closable && opt.title != curTabTitle && type === "Other") {
                    closeTabsTitle.push(opt.title);
                } else if (opt.closable && type === "All") {
                    closeTabsTitle.push(opt.title);
                }
            });

            for (var i = 0; i < closeTabsTitle.length; i++) {
                tabs.tabs("close", closeTabsTitle[i]);
            }
        }
    });
</script>
<style>
    article, aside, figure, footer, header, hgroup,
    menu, nav, section { display: block; }
    .west{
        width:200px;
        padding:10px;
    }
    .north{
        height:100px;
    }
</style>
</head>
<body class="easyui-layout">
<%--<div region="north" class="north">--%>
    <%--<h1>最简单的左右结构实现，及tab的右键菜单实现，右键查看源码</h1>--%>
<%--</div>--%>
<div region="center" title="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页"></div>
    </div>
</div>
<div region="west" class="west" title="menu">
    <ul id="tree"></ul>
</div>

<div id="tabsMenu" class="easyui-menu" style="width:120px;">
    <div name="close">关闭</div>
    <div name="Other">关闭其他</div>
    <div name="All">关闭所有</div>
</div>
</body>
</html>
