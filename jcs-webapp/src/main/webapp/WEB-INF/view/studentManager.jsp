<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>学生信息管理</title>
    <link rel="stylesheet" type="text/css" href="../../js/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/locale/easyui-lang-zh_CN.js">
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
</head>
<script type="text/javascript">
    function openEdit(selectedUser){
        if(selectedUser){
            $('#edit_id').val(selectedUser.id);
            $('#edit_username').textbox('setText',selectedUser.userName);
            $('#edit_password').textbox('setText',selectedUser.password);
            $('#edit_sex').textbox('setText',selectedUser.sex);
            $('#edit_phone').textbox('setText',selectedUser.mobile);
            $('#edit_pic1').textbox('setText',selectedUser.pic1);
            $('#edit_answer').textbox('setText',selectedUser.answer);
            $('#edit_quick').textbox('setText',selectedUser.quick);
        } else {
            $('#edit_id').val(null);
            $('#edit_username').textbox('setText',null);
            $('#edit_password').textbox('setText',null);
            $('#edit_sex').textbox('setText',null);
            $('#edit_phone').textbox('setText',null);
            $('#edit_pic1').textbox('setText',null);
            $('#edit_answer').textbox('setText',null);
            $('#edit_quick').textbox('setText',null);
        }
        $('#goodsEdit').dialog('open');
    }
    function clearGoodsCondition(){
        $('#query_username').textbox('setText',null);
        $('#query_phone').textbox('setText',null);
    }
    function closeEdit(){
        $('#goodsEdit').dialog('close');
    }
    function save(u){
        var user;
        if( u != null) {
            user = u;
        } else {
            user = {};
            user.id = $('#edit_id').val();
            user.userName=$('#edit_username').textbox('getText');
            user.password=$('#edit_password').textbox('getText');
            user.sex=$('#edit_sex').textbox('getText');
            user.mobile=$('#edit_phone').textbox('getText');
            user.pic1=$('#edit_pic1').textbox('getText');
            user.answer=$('#edit_answer').textbox('getText');
            user.quick=$('#edit_quick').textbox('getText');
        }
        $.post('UserManageServlet.servlet?method=save', user, function(data){
            if(data.indexOf('成功！')>0){
                $.messager.show({
                    title:'消息提示（消息将在2秒后关闭）',
                    msg:data,
                    timeout:2000,
                    showType:'slide',
                    style:{
                        right:'',
                        top:document.body.scrollTop+document.documentElement.scrollTop,
                        bottom:''
                    }
                });

                $('#goods_dg').datagrid('reload');
                $('#goodsEdit').dialog('close');
            } else {
                $.messager.alert('错误提示',data);
            }
        });
    }
    function upOrDown(u){
        var user;
        if( u != null) {
            $.messager.confirm('确认对话框', '请确认要删除该用户吗？', function(r){
                if (r){
                    user = u;
                    $.post('UserManageServlet.servlet?method=delete', user, function(data){
                        if(data.indexOf('成功！')>0){
                            $.messager.show({
                                title:'消息提示（消息将在2秒后关闭）',
                                msg:data,
                                timeout:2000,
                                showType:'slide',
                                style:{
                                    right:'',
                                    top:document.body.scrollTop+document.documentElement.scrollTop,
                                    bottom:''
                                }
                            });

                            $('#goods_dg').datagrid('reload');
                            $('#goodsEdit').dialog('close');
                        } else {
                            $.messager.alert('错误提示',data);
                        }
                    });
                }
            });
        } else {
            $.messager.alert('错误提示','请选择删除用户');
        }
    }
    function queryGoods(){
        var data = {};
        data.userName = $('#query_username').textbox('getText');
        data.mobile = $('#query_phone').textbox('getText');

        $('#goods_dg').datagrid('reload',data);

    }
    function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
    function myparser(s){
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    }
</script>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
<div data-options="region:'north',title:'查询条件'" style="height:110px;padding: 10px">
    <table width="100%">
        <tr>
            <td width="70px" align="right">用户名：</td>
            <td width="100px"><input id="query_username" type="text"  class="easyui-textbox"></input></td>
            <td width="70px" align="right">手机号：</td>
            <td width="100px"><input id="query_phone" type="text"  class="easyui-textbox"></input></td>
            <td style="padding-left: 30px" rowspan="2">
                <a id="btn" href="javascript:queryGoods();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>&nbsp;&nbsp;
                <a id="btn1" href="javascript:clearGoodsCondition();" class="easyui-linkbutton" data-options="iconCls:'icon-undo'">重置条件</a>
            </td>
        </tr>
    </table>
</div>

<div data-options="region:'center',title:'查询结果'">
    <table id="goods_dg" class="easyui-datagrid" style="width:100%;fit:true"
           data-options="singleSelect:true,pagination:true"
           url="UserManageServlet.servlet?method=query"
           toolbar="#goods_tb">
        <thead>
        <tr>
            <th field="id" align="center" width="200px">id号</th>
            <th field="userName" align="center" width="200px">用户名称</th>
            <th field="sex" align="center" width="100px">身份</th>
        </tr>
        </thead>
    </table>
    <div id="goods_tb">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:openEdit()">新增用户</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:openEdit($('#goods_dg').datagrid('getSelected'))">修改信息</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:upOrDown($('#goods_dg').datagrid('getSelected'))">删除用户</a>
    </div>
</div>

<!-- 商品编辑窗口 -->
<div id="goodsEdit" class="easyui-window" title="用户编辑"
     data-options="modal:true,closed:true,iconCls:'icon-save'"
     style="width:800px;height:400px;padding:10px;">
    <div style="margin:20px">
        <input id="edit_id" type="hidden"/>
        <table width="100%">
            <tr>
                <td width="60px">用户名：</td>
                <td>
                    <input id="edit_username" class="easyui-textbox" style="width:250px;height:25px"/>
                </td>
                <td width="60px" style="padding-left:20px">手机号：</td>
                <td>
                    <input id="edit_phone" class="easyui-textbox" style="width:250px;height:25px"/>
                </td>
            </tr>
            <td width="60px">性别：</td>
            <td>
                <input class="easyui-textbox" id="edit_sex" style="width:250px;height:25px"
                />
            </td>
            <td width="60px" style="padding-left:20px">密码：</td>
            <td>
                <input class="easyui-textbox" id="edit_password" style="width:250px;height:25px"
                />
            </td>
            <tr>
                <td width="60px">密保问题：</td>
                <td>
                    <input class="easyui-textbox" id="edit_answer" style="width:250px;height:25px"
                    />
                </td>
                <td width="60px" style="padding-left:20px">密保答案：</td>
                <td>
                    <input class="easyui-textbox" id="edit_quick" style="width:250px;height:25px"
                    />
                </td>
            </tr>
            <td width="60px">图片1：</td>
            <td colspan="3">
                <input id="edit_pic1" class="easyui-textbox" style="width:620px;height:25px"/>
            </td>
            </tr>

        </table>
    </div>
    <div align="center">
        <a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;height:32px" onclick="javascript:save()">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px;height:32px" onclick="javascript:closeEdit()">放弃</a>
    </div>
</div>
<!--// 商品编辑窗口 -->
</body>
</html>
