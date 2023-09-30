<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="projectList.title"/></title>
    <meta name="menu" content="AdminMenu"/>
</head>

<c:if test="{'$'}{not empty searchError}">
    <div class="alert alert-danger alert-dismissable">
        <a href="#" data-dismiss="alert" class="close">&times;</a>
        <c:out value="{'$'}{searchError}"/>
    </div>
</c:if>

<h2><fmt:message key="projectList.heading"/></h2>

<form method="get" action="${ctx}/admin/projects" id="searchForm" class="form-inline">
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

<p><fmt:message key="projectList.message"/></p>

<div class="col-sm-10">

	<div id="actions" class="btn-group">
	    <a href='<c:url value="/admin/project/add"/>' class="btn btn-primary">
	        <i class="icon-plus icon-white"></i> <fmt:message key="button.add"/></a>
	    <a href='<c:url value="/home"/>' class="btn btn-default"><i class="icon-ok"></i> <fmt:message key="button.done"/></a>
	</div>


	<display:table name="projectList" class="table table-condensed table-striped table-hover" requestURI="" id="projectList" export="false" pagesize="25">
	    
	<%--     <display:column property="id" sortable="true" href="projectForm" media="html" --%>
	<%--         paramId="id" paramProperty="id" titleKey="project.id"/> --%>
	        
		<display:column titleKey="projectList.open" class="col-sm-1">
			<a href="project/edit/${projectList.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
		</display:column>
	    <display:column property="projectName" sortable="true" titleKey="project.projectName" />
	 
	    <display:setProperty name="paging.banner.item_name"><fmt:message key="projectList.project"/></display:setProperty>
	    <display:setProperty name="paging.banner.items_name"><fmt:message key="projectList.projects"/></display:setProperty>
	
	    <display:setProperty name="export.excel.filename"><fmt:message key="projectList.title"/>.xls</display:setProperty>
	    <display:setProperty name="export.csv.filename"><fmt:message key="projectList.title"/>.csv</display:setProperty>
	    <display:setProperty name="export.pdf.filename"><fmt:message key="projectList.title"/>.pdf</display:setProperty>
	</display:table>
</div>
