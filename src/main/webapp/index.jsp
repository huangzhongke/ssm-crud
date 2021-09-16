<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hzk
  Date: 2021/9/14
  Time: 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <script src="${APP_PATH}/static/js/jquery-3.6.0.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"
            integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
          integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <style>
        .error {
            color: red;
            font-size: medium;

        }
    </style>
</head>
<body>
<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_input_up"
                                   placeholder="email@qq.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" checked="checked" value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_select_up">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="empName" id="empName_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_input" checked="checked" value="男"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender0_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary " id="emp_add">新增</button>
            <button class="btn btn-danger" id="emp_deleteAll">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_All"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav">
        </div>
    </div>
    <script type="text/javascript">
        var totalRecord;
        var currentPage;
        $(function () {
            to_Page(1);
        });

        function to_Page(pn) {
            $.ajax({
                url: "${APP_PATH}/emp",
                data: "pn=" + pn,
                type: "GET",
                success: function (event) {
                    build_emps_table(event);
                    build_page_info(event);
                    build_page_nav(event)
                }
            });
        }

        //显示表格信息
        function build_emps_table(result) {
            $("#emp_table tbody").empty();
            var emp = result.obj.page.list;
            $.each(emp, function (index, item) {
                var checkboxItem = $("<td><input type='checkbox' class='check_item'/></td>")
                var empId = $("<td></td>").append(item.empId);
                var empName = $("<td></td>").append(item.empName);
                var gender = $("<td></td>").append(item.gender);
                var email = $("<td></td>").append(item.email);
                var deptName = $("<td></td>").append(item.department.deptName);

                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm update_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil  aria-hidden=true").append("编辑"))
                    .attr("edit_id", item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash  aria-hidden=true").append("删除"))
                    .attr("delete_id", item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></td>")
                    .append(checkboxItem)
                    .append(empId)
                    .append(empName)
                    .append(gender)
                    .append(email)
                    .append(deptName).append(btnTd).appendTo($("#emp_table tbody"));
            })
        }

        //显示分页条
        function build_page_info(result) {
            $("#page_info").empty();
            $("#page_info").append("当前"
                + result.obj.page.pageNum + "页,总"
                + result.obj.page.pages + "页，总"
                + result.obj.page.total + "条记录数");
            totalRecord = result.obj.page.total;
            currentPage = result.obj.page.pageNum;
        }

        //显示分页信息
        function build_page_nav(result) {
            $("#page_nav").empty();
            var ul = $("<ul></ul>").addClass("pagination")
            var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.obj.page.hasPreviousPage == false) {
                firstPage.addClass("disabled");
                prePage.addClass("disabled");
            } else {

                firstPage.click(function () {
                    to_Page(1)
                })
                prePage.click(function () {
                    to_Page(result.obj.page.pageNum - 1)
                })
            }
            var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"))
            var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"))
            if (result.obj.page.hasNextPage == false) {
                nextPage.addClass("disabled")
                lastPage.addClass("disabled")
            } else {

                nextPage.click(function () {
                    to_Page(result.obj.page.pageNum + 1)
                })
                lastPage.click(function () {
                    to_Page(result.obj.page.pages)
                })
            }
            ul.append(firstPage).append(prePage);
            $.each(result.obj.page.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if (result.obj.page.pageNum == item) {
                    numLi.addClass("active")
                }
                numLi.click(function () {
                    to_Page(item)
                });
                ul.append(numLi)
            })
            ul.append(nextPage).append(lastPage);
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo($("#page_nav"))
        }

        function clear_form(ele) {
            //清空表单数据
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //点击新增开启模态框
        $("#emp_add").click(function () {
            //清除表单数据和样式
            clear_form("#empAddModal form");
            //查询部门表，吧数据放进下拉条
            getDepts("#empAddModal select");
            $("#empAddModal").modal({
                //点击模态框外不会消失
                backdrop: "static"
            })
        })

        //获取部门信息 并添加到下拉条
        function getDepts(ele) {
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success: function (result) {
                    $.each(result.obj.depts, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo($(ele));
                    });
                }
            })
        }

        //提示验证信息
        function show_validate_msg(el, status, msg) {
            $(el).parent().removeClass("has-error has-success");
            $(el).next(" span").text("");
            if ("success" == status) {
                $(el).parent().addClass("has-success");
                $(el).next(" span").text(msg)

            } else if ("error" == status) {
                $(el).parent().addClass("has-error");
                $(el).next(" span").text(msg);

            }
        }

        //验证表单
        function validate_emp() {
            var empName = $("#empName_input").val();
            var regName = /(^[A-Za-z0-9_-]{6,16}$)|(^[\u4e00-\u9fa5]{2,5}$)/;
            //校验姓名
            if (!regName.test(empName)) {
                show_validate_msg("#empName_input", "error", "用户名需要为 中文长度为2-5 或 以英文、数字,下划线组成6-16为的组合");
                return false;
            } else {
                show_validate_msg("#empName_input", "success", "");
            }
            var email = $("#email_input").val()
            var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            //校验邮箱
            if (!regEmail.test(email)) {
                show_validate_msg("#email_input", "error", "邮箱不合法");
                //如果不合法不能提交表单
                return false;

            } else {
                show_validate_msg("#email_input", "success", "");
            }
            return true;
        }

        //验证用户名是否重复
        $("#empName_input").change(function () {
            var empName = this.value;
            $.ajax({
                url: "${APP_PATH}/checkUser",
                type: "GET",
                data: "empName=" + empName,
                success: function (result) {
                    if (result.code == 1) {
                        $("#emp_save").attr("ajax-va", "error");
                        show_validate_msg("#empName_input", "error", result.obj.va_msg);

                    } else if (result.code == 0) {
                        $("#emp_save").attr("ajax-va", "success");
                        show_validate_msg("#empName_input", "success", "用户名可用");
                    }
                }
            })
        })
        $("#emp_save").click(function () {
            //对表单进行验证
            //前端校验
            if (!validate_emp()) {
                return false;
            }
            if ($("#emp_save").attr("ajax-va") == "error") {
                show_validate_msg("#empName_input", "error", "用户名已存在");
                return false;
            }
            $.ajax({
                url: "${APP_PATH}/employee",
                type: "POST",
                data: $("#empAddModal form").serialize(),
                success: function (result) {
                    if (result.code == 0) {
                        //关闭模态框
                        $("#empAddModal").modal("hide");
                        to_Page(totalRecord)
                    } else {
                        //防止有人跳过前端校验，还需要进行后端校验
                        if (undefined != result.obj.errorFields.email) {
                            //如果有错误信息
                            show_validate_msg("#email_input", "error", result.obj.errorFields.email);
                        }
                        if (undefined != result.obj.errorFields.empName) {
                            show_validate_msg("#empName_input", "error", result.obj.errorFields.empName);
                        }

                        console.log(result);
                    }

                }
            })
        })
        //给删除按钮帮上单击事件
        $(document).on("click", ".delete_btn", function () {
            var empName = $(this).parents(" tr").find("td:eq(1)").text();
            var id = $(this).attr("delete_id");
            if (confirm("你确认要删除【" + empName + "】吗")) {
                //发送ajax请求删除
                $.ajax({
                    url: "${APP_PATH}/employee/" + id,
                    type: "DELETE",
                    success: function (result) {
                        to_Page(currentPage)
                    }
                })
            } else {
                return false;
            }

        })
        //给编辑按钮绑上单机事件
        $(document).on("click", ".update_btn", function () {
            //获取 邮箱 性别，用户名信息
            getEmp($(this).attr("edit_id"));
            //获取部门信息
            getDepts("#empUpdateModal select");
            //吧员工id传递给更新按钮
            $("#emp_update").attr("edit_id", $(this).attr("edit_id"));
            //显示模态框
            $("#empUpdateModal").modal({
                //点击模态框外不会消失
                backdrop: "static"
            })
        })

        function getEmp(id) {
            $.ajax({
                url: "${APP_PATH}/employee/" + id,
                type: "GET",
                success: function (result) {
                    //把数据回显到对象的地方
                    console.log(result);
                    var data = result.obj.emp;
                    $("#empName_update").text(data.empName);
                    $("#email_input_up").val(data.email);
                    $("#empUpdateModal input[name=gender]").val([data.gender]);
                    $("#empUpdateModal select").val([data.dId])
                }
            })

        }

        //模态框里的更新按钮
        $("#emp_update").click(function () {

            var email = $("#email_input_up").val();
            var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            //校验邮箱
            if (!regEmail.test(email)) {
                show_validate_msg("#emp_update", "error", "邮箱不合法");
                //如果不合法不能提交表单
                return false;

            } else {
                show_validate_msg("#emp_update", "success", "");
            }
            var id = $("#emp_update").attr("edit_id");
            $.ajax({
                url: "${APP_PATH}/employee/" + id,
                type: "PUT",
                //FormContentFilter
                // 将请求体重的数据解析包装成Map,
                // request被重新包装，request.getParameter()被重写，然后就从自己封装的map中取出数据
                data: $("#empUpdateModal form").serialize(),//+"&_method=PUT",
                success: function (result) {
                    if (result.code == 0) {
                        $("#empUpdateModal").modal("hide");
                        to_Page(currentPage)
                    } else {

                    }
                }
            })
        })
        //全选，全不选
        $("#check_All").click(function () {
            $(".check_item").prop("checked", $(this).prop("checked"));
        })

        $(document).on("click", ".check_item", function () {
            var flag = (($(".check_item:checked").length) == ($(".check_item").length))
            $("#check_All").prop("checked", flag);
        })
        //批量删除
        $("#emp_deleteAll").click(function () {
            var strName = "";
            var del_idstr = "";
            $.each($(".check_item:checked"), function () {
                strName += $(this).parents("tr").find("td:eq(2)").text() + ","
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-"
            })
            strName = strName.substring(0, strName.length - 1);
            del_idstr = del_idstr.substring(0, del_idstr.length - 1);
            if (confirm("你确定要删除【" + strName + "吗】")) {
                $.ajax({
                    url: "${APP_PATH}/employee/" + del_idstr,
                    type: "DELETE",
                    success: function (result) {
                        alert("删除成功")
                        to_Page(currentPage)
                    }
                })
            }
        })
    </script>
</body>
</html>
