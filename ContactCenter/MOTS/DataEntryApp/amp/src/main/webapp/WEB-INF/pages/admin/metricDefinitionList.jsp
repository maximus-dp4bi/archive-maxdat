<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="metricDefinitionList.title"/></title>
    <meta name="menu" content="AdminMenu"/>
</head>

<c:if test="{'$'}{not empty searchError}">
    <div class="alert alert-danger alert-dismissable">
        <a href="#" data-dismiss="alert" class="close">&times;</a>
        <c:out value="{'$'}{searchError}"/>
    </div>
</c:if>

<h2><fmt:message key="metricDefinitionList.admin.heading"/></h2>

<form method="get" action="${ctx}/admin/metrics" id="searchForm" class="form-inline">
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

<p><fmt:message key="metricDefinitionList.admin.message"/></p>

<div class="col-sm-10">
	<div id="actions" class="btn-group">
	    <a href='<c:url value="/admin/metricDefinitionForm/add"/>' class="btn btn-primary">
	        <i class="icon-plus icon-white"></i> <fmt:message key="button.add"/></a>
	    <a href='<c:url value="/home"/>' class="btn btn-default"><i class="icon-ok"></i> <fmt:message key="button.done"/></a>
	</div>
	
	<display:table name="metricDefinitionList" defaultsort="5" class="table table-condensed table-striped table-hover" requestURI="" id="metricDefinitionList" export="true" pagesize="500">
	    
	<%--     <display:column property="id" sortable="true" href="metricDefinitionForm" media="html" --%>
	<%--         paramId="id" paramProperty="id" titleKey="metricDefinition.id"/> --%>
	        
		<display:column titleKey="metricDefinition.open" >
			<a href="metricDefinitionForm/edit/${metricDefinitionList.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
		</display:column>
	        
	    <display:column property="id" media="csv excel xml pdf" titleKey="metricDefinition.id"/>
<%-- 	    <display:column property="metricType.metricTypeName" sortable="true" titleKey="metricDefinition.metricType"/> --%>
		<display:column property="functionalArea" sortable="true" titleKey="metricDefinition.functionalArea"/>
	    <display:column property="category" sortable="true" titleKey="metricDefinition.category"/>
	    <display:column property="subCategory" sortable="true" titleKey="metricDefinition.subCategory"/>
	    <display:column property="label" sortable="true" titleKey="metricDefinition.label"/>
	    <display:column property="metricDescription" sortable="true" titleKey="metricDefinition.metricDescription" />
	    
	
	    <display:setProperty name="paging.banner.item_name"><fmt:message key="metricDefinitionList.metricDefinition"/></display:setProperty>
	    <display:setProperty name="paging.banner.items_name"><fmt:message key="metricDefinitionList.metricDefinitions"/></display:setProperty>
	
	    <display:setProperty name="export.excel.filename"><fmt:message key="metricDefinitionList.title"/>.xls</display:setProperty>
	    <display:setProperty name="export.csv.filename"><fmt:message key="metricDefinitionList.title"/>.csv</display:setProperty>
	    <display:setProperty name="export.pdf.filename"><fmt:message key="metricDefinitionList.title"/>.pdf</display:setProperty>
	</display:table>
</div>