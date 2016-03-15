<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="scripts/jquery-1.7.2.js"></script>
<script type="text/javascript">
    $(function() {
        $(":input[name=lastName]").change(function() {
            var $this = $(this);
            var lastName = $this.val();
            lastName = $.trim(lastName);
            
            var url = "emp-validateLastName";
            var args = { "lastName": lastName, "time": new Date() };
            
            if (lastName != "") {
                
                $this.nextAll("font").remove();
                
                $.post(url, args, function(data) {
                    if (data == "0") {
                        $this.after("&nbsp;<font color='green'>该用户名可用</font>");
                    } else if (data == "1") {
                        $this.after("&nbsp;<font color='red'>该用户名不可用!</font>");
                    } else {
                        alert("Server Error!");
                    }
                });
            } else {
                alert("LastName 不能为空");
                $(this).val("");
                $this.focus();
            }
        });
    });
</script>
</head>
<body>

  <h4>Employee Editing Page</h4>

  <s:form action="emp-save" method="post">
    <s:if test="id != null">
      <s:textfield name="lastName" label="LAST NAME" disabled="true"></s:textfield>
      <%-- 不要忘了把 edit 带过来的 id 带过去，否则在 Action 类里面永远是创建新记录，而非修改记录 --%>
      <s:hidden name="id"></s:hidden>
    </s:if>
    <s:else>
      <s:textfield name="lastName" label="LAST NAME"></s:textfield>
    </s:else>
    <s:textfield name="email" label="EMAIL"></s:textfield>
    <s:textfield name="birth" label="BIRTH"></s:textfield>
    <%-- 这里整理日期格式需要配置 Struts2 的日期转换器，即字符串和日期类型的相互转换 --%>

    <s:select list="#request.departments" listKey="id" listValue="departmentName" name="department.id"
      label="Departments"></s:select>
    <%-- listKey 对应具体生成的 HTML 属性里的 value，listValue 对应显示的内容，name 对应表单提交的属性名 --%>

    <s:submit></s:submit>
  </s:form>

  <s:debug></s:debug>

</body>
</html>