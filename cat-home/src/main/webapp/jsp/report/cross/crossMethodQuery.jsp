<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<jsp:useBean id="ctx" type="com.dianping.cat.report.page.cross.Context" scope="request" />
<jsp:useBean id="payload"  	type="com.dianping.cat.report.page.cross.Payload" scope="request" />
<jsp:useBean id="model" type="com.dianping.cat.report.page.cross.Model" scope="request" />

<a:report title="Cross Report"
	navUrlPrefix="ip=${model.ipAddress}&domain=${model.domain}">
	<jsp:attribute name="subtitle">From ${w:format(model.report.startTime,'yyyy-MM-dd HH:mm:ss')} to ${w:format(model.report.endTime,'yyyy-MM-dd HH:mm:ss')}</jsp:attribute>
	<jsp:body>
<res:useCss value='${res.css.local.table_css}' target="head-css" />

<res:useJs value="${res.js.local['jquery.dataTables.min.js']}" target="head-js"/>
<script type="text/javascript">
	$(document).ready(function() {
		$('#contents').dataTable({
			"sPaginationType": "full_numbers",
			'iDisplayLength': 100,
			"oLanguage": {
	            "sProcessing": "正在加载中......",
	            "sLengthMenu": "每页显示 _MENU_ 条记录",
	            "sZeroRecords": "对不起，查询不到相关数据！",
	            "sEmptyTable": "表中无数据存在！",
	            "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
	            "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
	            "sSearch": "搜索",
	            "oPaginate": {
	                "sFirst": "首页",
	                "sPrevious": "上一页",
	                "sNext": "下一页",
	                "sLast": "末页"
	            }
	        }
		});
	});
</script>
<%@ include file="crossQuery.jsp" %>
</br>
<table id="contents" width="100%">
	<thead>
	<tr>
		<th>类型</th>
		<th>项目</th>
		<th>IP</th>
		<th>方法名</th>
		<th>Total</th>
		<th>Failure</th>
		<th>Failure%</th>
		<th>Avg(ms)</th>
	</tr></thead><tbody>
	<c:forEach var="item" items="${model.info.items}" varStatus="status">
		<tr class="${status.index mod 2 != 0 ? 'odd' : 'even'}">
			<td>${item.type}</td>
			<td>${item.domain}</td>
			<td>${item.ip}</td>
			<td>${item.method}</td>
			 <td>${item.totalCount}</td>
		     <td>${w:format(item.failureCount,'#,###,###,###,##0')}</td>
		     <td>${w:format(item.failurePercent,'0.0000%')}</td>
		     <td>${w:format(item.avg,'0.00')}</td>
		</tr>
	</c:forEach></tbody>
</table>
</br>
</jsp:body>
</a:report>
