<%@ include file="/common/taglibs.jsp"%>


<head>	
    <title><fmt:message key="projectReportList.title"><fmt:param value="${typeMsg}"/></fmt:message></title>
    <meta name="heading" content="<fmt:message key='projectList.title'><fmt:param value="${typeMsg}"/></fmt:message>"/>
</head>

<c:if test="{'$'}{not empty searchError}">
    <div class="alert alert-danger alert-dismissable">
        <a href="#" data-dismiss="alert" class="close">&times;</a>
        <c:out value="{'$'}{searchError}"/>
    </div>
</c:if>

<h2><fmt:message key="projectReportList.heading"><fmt:param value="${typeMsg}"/></fmt:message></h2>

<%--
<form method="get" action="${ctx}/projectReports" id="searchForm" class="form-inline">
<div id="search" class="text-right">
    <span class="col-sm-9">
        <input type="text" size="20" name="q" id="query" value="${param.q}"
               placeholder="<fmt:message key="search.enterTerms"/>" class="form-control input-sm"/>
    </span>
    <button id="button.search" class="btn btn-default btn-sm" type="submit">
        <i class="icon-search"></i> <fmt:message key="button.search"/>
    </button>
</div>
</form>
 --%>
 
<p><fmt:message key="projectReportList.message"><fmt:param value="${typeMsg}"/></fmt:message></p>

<div class="btn-group">
    <a href='<c:url value="/report/add/${type}"/>' class="btn btn-primary">
        <i class="icon-plus icon-white"></i> <fmt:message key="button.add"/>
    </a>
</div>
<div class="btn-group">
    <a href='<c:url value="/home"/>' class="btn btn-default"><i class="icon-ok"></i> <fmt:message key="button.done"/></a>
</div>


<p><fmt:message key="projectReportList.tableHeader"><fmt:param value="${typeMsg}"/></fmt:message></p>

<display:table name="projectReportList" class="table table-condensed table-striped table-hover" 
	requestURI="" id="projectReport" export="false" pagesize="25">

<%--
    <display:column titleKey="projectReport.view">
    	<a href="/report/view/${type}/${projectReport.id}"><i class="fa fa-search-plus fa-1x"></i></a>
    </display:column>
 --%>
 
	<display:column titleKey="projectReport.open">
		<a href="/report/edit/${type}/${projectReport.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
	</display:column>
	
    <display:column property="project.projectName" sortable="true" titleKey="projectReport.projectName" />

    <display:column property="program.programName" sortable="true" titleKey="projectReport.programName"/>
    <display:column property="reportingPeriod.type" sortable="true" titleKey="projectReport.reportingPeriodType"/>
    <display:column property="functionalArea" sortable="true" titleKey="projectReport.functionalArea"/>
    <display:column property="reportingPeriod.formattedEndDate" sortable="true" titleKey="projectReport.reportingPeriodEndDate"/>
    <display:column sortable="true" titleKey="projectReport.status">
    	<fmt:message key="projectReport.status.${projectReport.status}" />
    </display:column>

    <display:setProperty name="paging.banner.item_name"><fmt:message key="projectReportList.pagingBannerItemName"/></display:setProperty>
    <display:setProperty name="paging.banner.items_name"><fmt:message key="projectReportList.pagingBannerItemName"/></display:setProperty>

</display:table>
  