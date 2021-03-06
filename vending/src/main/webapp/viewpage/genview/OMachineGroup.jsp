<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="<c:url value='/resources/js/firmGroup.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/machine.js'/>" type="text/javascript"></script>
<title>Machine Group</title>
</head>
<body>
	<%@include file="../topmenu.jsp"%>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<ul class="breadcrumb">
					<li><a href="<c:url value="/home"/>">主页</a></li>
					<li class="active">售货机分组</li>
				</ul>
			</div>
		</div>
		<div>
		<div>
			<a href="#" class="btn btn-primary"  data-toggle="modal" data-target="#addGroup"> 
			<span class="glyphicon glyphicon-plus"></span>添加售货机组
			</a>
		</div>
			<table class="table">
				<tr>
					<th>售货机组名</th>
					<th>分组类型</th>
					<th>描述信息</th>
					<th>公司</th>
					<th>公司名称</th>
					<th>操作者</th>
					<th>操作日期</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${machineGroupInfos}" var="groupInfo">
					<tr>
						<td>${groupInfo.groupName}</td>
						<td>${groupInfo.groupType}</td>
						<td>${groupInfo.groupDesc}</td>
						<td>${groupInfo.firmInfo.firmId}</td>
						<td>${groupInfo.firmInfo.firmName}</td>
						<td>${groupInfo.operateId}</td>
						<td>${groupInfo.operateDate}</td>
						<td>
							<a href="<c:url value="/machine/machineGroupDetialInfos"/>?groupId=${groupInfo.groupId}" class="btn default"> <span class="glyphicon glyphicon-info-sign" title="详情"></span>
							</a>
							<a href="<c:url value="/machine/machinegroupInfo"/>?groupId=${groupInfo.groupId}" class="btn default"> <span class="glyphicon glyphicon-edit" title="编辑"></span>
							</a>
							<a onclick="getAssignToUsers(${groupInfo.groupId})" class="btn default" data-toggle="modal" data-target="#assignMachineGroup"> <span class="glyphicon glyphicon-link" title="分配"></span>
							</a>
							<a href="<c:url value="/machine/machinegroupDelete"/>?groupId=${groupInfo.groupId}" class="btn default"> <span class="glyphicon glyphicon-trash" title="删除"></span>
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="modal fade" id="addGroup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">添加分组</h4>
		      </div>
		      <div class="modal-body" style="width:500px">
		        	<form  method="post" id="addGroupForm" action="<c:url value="/machine/machineGroupCreate"/>">
		        		<div class="form-group">
		        			<label for="groupName">组名:</label>
		        			<input type="text" class="form-control" id="groupName" name="groupName" placeholder="输入组名" required="required">
		        		</div>
		        		<div class="form-group">
		        			<label for="groupDesc">描述:</label>
		        			<textarea class="form-control" id="groupDesc" placeholder="输入描述" name="groupDesc"></textarea>
		        		</div>
		        		<input type="hidden" name="groupType" value="2">
		        	</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" onclick="addGroup()" class="btn btn-primary" data-dismiss="modal">提交</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
	
	<div class="modal fade" id="assignMachineGroup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">选择用户</h4>
				</div>
				<div class="modal-body" style="width: 80%; padding-left: 30px">
					<form class="form" id="assignMachineGroupToUserForm">
					<input type="hidden" name="groupId" id="Id">
					<input type="hidden" name="operateId" value="${user.userId }">
						<div id="selectUserToAssign"></div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onclick="assignMachineGroupToUser()" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>