<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="metricDefinitionList.title"/></title>
<!--     <meta name="menu" content="Metrics"/> -->
</head>

<c:if test="{'$'}{not empty searchError}">
    <div class="alert alert-danger alert-dismissable">
        <a href="#" data-dismiss="alert" class="close">&times;</a>
        <c:out value="{'$'}{searchError}"/>
    </div>
</c:if>

<div class="col-sm-10">

	<h2><fmt:message key="metricDefinitionList.help.heading"/></h2>
	
	<form method="post" action="${ctx}/help/metrics" id="searchForm" class="form-inline">
		<div id="search" class="text-right">
		    <span class="col-sm-9">
		        <input type="text" size="20" name="q" id="query" value="${param.q}"
		               placeholder="<fmt:message key="search.enterTerms"/>" class="form-control input-sm"/>
		    </span>
		    <button id="button.search" class="btn btn-default btn-sm" type="submit">
		        <i class="icon-search"></i> <fmt:message key="button.search"/>
		    </button>
		</div>
	
		<p><fmt:message key="metricDefinitionList.help.message"/></p>
		
		<div class="row">
			<div class="form-group">
				<label for="functionalArea" class="col-sm-4 control-label"><fmt:message key="metricDefinition.functionalArea"/></label>
	<!-- 		    <select class="form-control" id="functionalArea" name="functionalArea" onchange="this.form.submit();"> -->
	<%-- 		    	<c:forEach items="${functionalAreas}" var="functionalArea"> --%>
	<%-- 			    	<option label="${functionalArea}" value="${functionalArea}" /> --%>
	<%-- 		    	</c:forEach> --%>
	<!-- 		    </select> -->
				<div class="col-sm-6">	
				    <select class="form-control" id="functionalArea" name="functionalArea" onchange="this.form.submit();">
						<c:forEach items="${functionalAreas}" var="fa">
							<option value="${fa.value}" ${functionalArea == fa.value ? 'selected' : ''}>${fa.label}</option>
						</c:forEach>
				    </select>
			    </div>
			    
		    </div>
	    </div>

		<div class="row row-buffer-20">
			<display:table name="metricDefinitionList" class="table table-condensed table-striped table-hover" requestURI="" id="metricDefinitionList" export="false" pagesize="500">
	
	<%-- 			<display:column titleKey="metricDefinition.open" > --%>
	<%-- 				<a href="/help/metricDefinitionFrom/${metricDefinitionList.id}"><i class="fa fa-folder-open fa-1x"></i></a> --%>
	<%-- 			</display:column> --%>
				
<%-- 			    <display:column property="functionalArea" sortable="true" titleKey="metricDefinition.functionalArea"/> --%>
			    <display:column property="category" sortable="true" titleKey="metricDefinition.category"/>
			    <display:column property="subCategory" sortable="true" titleKey="metricDefinition.subCategory"/>
			    <display:column property="label" sortable="true" titleKey="metricDefinition.metricName"/>
			    <display:column property="definition" sortable="true" titleKey="metricDefinition.definition" />
			    <display:column property="collectionFrequency" sortable="true" titleKey="metricDefinition.collectionFrequency" />
			    		
			    <display:setProperty name="paging.banner.item_name"><fmt:message key="metricDefinitionList.metricDefinition"/></display:setProperty>
			    <display:setProperty name="paging.banner.items_name"><fmt:message key="metricDefinitionList.metricDefinitions"/></display:setProperty>
			
			</display:table>
		</div>

	</form>

</div>

<script type="text/javascript">
    $(document).ready(function() {
        $('#functionalArea').change(function() { 
        	$('#query').val("");
        	this.form.submit();
        });            
    });
    
        
</script>
