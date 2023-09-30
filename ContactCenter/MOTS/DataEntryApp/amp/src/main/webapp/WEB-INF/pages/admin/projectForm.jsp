<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="projectDetail.title"/></title>
    <meta name="menu" content="AdminMenu"/>
    <meta name="heading" content="<fmt:message key='projectDetail.heading'/>"/>
    <link href="/styles/multiple-select.css" rel="stylesheet"/>
    <style>
    	.multi-select-ext {
    		display: block;
    		width: 100%;
    		border-radius: 4px;
    		border-top-color: rgb(204, 204, 204);
    		box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
    	}
    </style>
</head>

<%--
<c:set var="delObject" scope="request"><fmt:message key="projectList.metric"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>
 --%>


	<div class="col-sm-10">
	    <h2><fmt:message key="projectDetail.heading"/></h2>
	    <fmt:message key="projectDetail.message"/>
	
	
		<div class="row row-buffer-20">

			<ul class="nav nav-tabs" role="tablist">
			  <li role="presentation" class="active"><a role="tab" aria-controls="info" data-toggle="tab" href="#info">Project Info</a></li>
			  <li><a role="tab" aria-controls="metrics" data-toggle="tab" href="#metrics">Project Metrics</a></li>
			  <li><a role="tab" aria-controls="users" data-toggle="tab" href="#users">Project Users</a></li>
			</ul>

			<form:errors path="*" cssClass="alert alert-danger alert-dismissable" element="div"/>
			<form:form commandName="project" method="post" action="/admin/project" cssClass="well"
			           id="projectForm" onsubmit="return validateProject(this)">
			           
				<form:hidden path="id"/>
				
				<div class="tab-content">
					<div role="tabpanel" id="info" class="tab-pane in active">
						<div class="row">
						    <spring:bind path="project.projectName">
						    <div class="col-sm-12 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="project.projectName" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="projectName" id="projectName"  maxlength="50"/>
						        <form:errors path="projectName" cssClass="help-block"/>
						    </div>
						    
					    </div>
						
						<div class="row">
						
						    <spring:bind path="project.division">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="project.division" styleClass="control-label"/>
						        <form:select cssClass="form-control" items="${divisions}" path="division" itemValue="id" itemLabel="name"/>
						        <form:errors path="division" cssClass="help-block"/>
						    </div>
						    
					    </div>
					    

					    
					    <div class="row">
					        <div class="form-group col-sm-4">
					            <label for="programSelect" class="control-label"><fmt:message key="project.programs"/></label>
					            <select select="multiple" id="programSelect" name="programSelect" multiple="true" class="multi-select multi-select-ext">
					                <c:forEach items="${programs}" var="program">
					                	<c:set var="prgSelected" value="" />
										<c:forEach items="${project.programs}" var="prg">
										  <c:if test="${prg.programName eq program.programName}">
										  	<c:set var="prgSelected" value="selected" />
										  </c:if>
										</c:forEach>
					                	<option value="${program.id}" <c:out value="${prgSelected}" />>${program.programName}</option>
					                </c:forEach>
					            </select>
					        </div>
							<div class="form-group">
								
								<div class="col-sm-4">
									<label for="programName" class="control-label"><fmt:message key="project.addNewProgram"/></label>
									<input id="programName" name="programName" class="form-control" />
						        </div>
						        <div class="col-sm-2">
							        <div style="height:25px"><label for="addProgram">&nbsp;</label></div>
							        <button type="submit" class="btn btn-primary" id="addProgram" name="addProgram" onclick="bCancel=false; return validateProgram();" disabled="true">
							            <fmt:message key="button.add"/>
							        </button>
						        </div>
						    </div>
				        </div>
				        <div class="row">
				        
				        	<div class="form-group col-sm-4">
					            <label for="geographySelect" class="control-label"><fmt:message key="project.geographyMasters"/></label>
					            <select id="geographySelect" name="geographySelect" multiple="true" class="multi-select multi-select-ext">
					                <c:forEach items="${geographyMasters}" var="geographyMaster">
					                	<c:set var="geoSelected" value="" />
										<c:forEach items="${project.geographyMasters}" var="geo">
										  <c:if test="${geo.geographyName eq geographyMaster.geographyName}">
										  	<c:set var="geoSelected" value="selected" />
										  </c:if>
										</c:forEach>
					                	<option value="${geographyMaster.id}" ${geoSelected}>${geographyMaster.geographyName}</option>
					                </c:forEach>
					            </select>
					        </div>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-4">
										<label for="geographyName" class="control-label"><fmt:message key="project.addGeography"/></label>
										<input id="geographyName" name="geographyName" class="form-control" />								
						        	</div>
	<!-- 							<div class="row"> -->
	<%-- 								<label for="countryName" class="control-label"><fmt:message key="geographyMaster.countryName"/></label> --%>
	<!-- 								<input id="countryName" name="countryName" class="form-control" /> -->
	<!-- 					        </div> -->
	<!-- 							<div class="row"> -->
	<%-- 								<label for="stateName" class="control-label"><fmt:message key="geographyMaster.stateName"/></label> --%>
	<!-- 								<input id="stateName" name="stateName" class="form-control" /> -->
	<!-- 					        </div> -->
	<!-- 							<div class="row"> -->
	<%-- 								<label for="regionName" class="control-label"><fmt:message key="geographyMaster.regionName"/></label> --%>
	<!-- 								<input id="regionName" name="regionName" class="form-control" /> -->
	<!-- 					        </div> -->
	<!-- 							<div class="row"> -->
	<%-- 								<label for="provinceName" class="control-label"><fmt:message key="geographyMaster.provinceName"/></label> --%>
	<!-- 								<input id="provinceName" name="provinceName" class="form-control" /> -->
	<!-- 					        </div> -->
	<!-- 							<div class="row"> -->
	<%-- 								<label for="districtName" class="control-label"><fmt:message key="geographyMaster.districtName"/></label> --%>
	<!-- 								<input id="districtName" name="districtName" class="form-control" /> -->
	<!-- 					        </div> -->	
								
							     	<div class="col-sm-2">
								        <div style="height:25px"><label for="addProgram">&nbsp;</label></div>
								        <button type="submit" class="btn btn-primary" id="addGeography" name="addGeography" onclick="bCancel=false; return validateGeography();" disabled="true">
								            <fmt:message key="button.add"/>
								        </button>
							        </div>
						        </div>		
					        </div>
						</div>
					</div>
					
					<div role="tabpanel" id="metrics" class="tab-pane">
				    
				    	<div class="row row-buffer-10">
					   		<appfuse:label key="project.projectName" styleClass="col-sm-4 control-label"/>
					   		<c:out value="${project.projectName}" />
						</div>	
						<div class="row row-buffer-10">
							<div class="form-group">
						        <button type="submit" class="btn btn-primary" id="addMetricProject" name="addMetricProject" onclick="bCancel=false">
						            <i class="icon-ok icon-white"></i> <fmt:message key="metricProject.addMetricProject"/>
						        </button>
						    </div>
						    
							<display:table id="metricProject" name="metricProjects" defaultsort="2"
								requestURI="" export="false" pagesize="50" class="table table-condensed table-striped table-hover">
							 
								<display:column titleKey="metricProject.open">
									<a href="/admin/metricProject/edit/${metricProject.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
								</display:column>
								
								<display:column property="metricDefinition.label" sortable="true" titleKey="metricDefinition.metricName" />
								<display:column property="program.programName" sortable="true" titleKey="program.programName" />
								<display:column property="geographyMaster.geographyName" sortable="true" titleKey="geographyMaster.geographyName" />
							    <display:column property="actualValueProvidedBy" sortable="true" titleKey="metricProject.actualValueProvidedBy" />
							    <display:column property="forecastValueProvidedBy" sortable="true" titleKey="metricProject.forecastValueProvidedBy" />
							    <display:column sortable="true" titleKey="metricProject.actualEffDate">
							    	<fmt:formatDate pattern="MM/dd/yyyy" value="${metricProject.actualEffDate}" />
							    </display:column>
							    <display:column sortable="true" titleKey="metricProject.forecastEffDate">
							    	<fmt:formatDate pattern="MM/dd/yyyy" value="${metricProject.forecastEffDate}" />
							    </display:column>
								<display:column sortable="true" titleKey="metricProject.recordEndDate">
							    	<fmt:formatDate pattern="MM/dd/yyyy" value="${metricProject.recordEndDate}" />
							    </display:column>
							    
							    <display:setProperty name="paging.banner.item_name"><fmt:message key="pagingBannerItemName"/></display:setProperty>
							    <display:setProperty name="paging.banner.items_name"><fmt:message key="pagingBannerItemName"/></display:setProperty>
								
								
							</display:table>
						</div>
					</div>
					<div role="tabpanel" id="users" class="tab-pane">
				    	<div class="row row-buffer-10">
					   		<appfuse:label key="project.projectName" styleClass="col-sm-4 control-label"/>
					   		<c:out value="${project.projectName}" />
						</div>	
						<div class="row row-buffer-10">
					
							<div class="form-group">
						        <button type="submit" class="btn btn-primary" id="addProjectUser" name="addProjectUser" onclick="bCancel=false">
						            <i class="icon-ok icon-white"></i> <fmt:message key="projectUser.addProjectUser"/>
						        </button>
						    </div>
					
							<display:table id="projectUser" name="project.projectUsers" defaultsort="2"
									requestURI="" export="false" pagesize="50" class="table table-condensed table-striped table-hover">							 
								
								<display:column titleKey="projectUser.open">
									<a href="/admin/projectUser/edit/${projectUser.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
								</display:column>
								<display:column property="user.username" sortable="true" titleKey="user.username" />
								<display:column property="functionalArea" sortable="true" titleKey="metricDefinition.functionalArea" />
								<display:column property="role.name" sortable="true" titleKey="projectUser.role" />
								<display:column property="isActiveFlag" sortable="true" titleKey="projectUser.isActiveFlag" />
															    
							    <display:setProperty name="paging.banner.item_name"><fmt:message key="pagingBannerItemName"/></display:setProperty>
							    <display:setProperty name="paging.banner.items_name"><fmt:message key="pagingBannerItemName"/></display:setProperty>
							</display:table>
						</div>
					</div>
					
				</div>
				
				<div class="row row-buffer-20">
				    <div class="form-group">
				        <button type="submit" class="btn btn-primary" id="save" name="save" onclick="bCancel=false">
				            <i class="icon-ok icon-white"></i> <fmt:message key="button.save"/>
				        </button>			
				        <button type="submit" class="btn btn-default" id="cancel" name="cancel" onclick="bCancel=true">
				            <i class="icon-remove"></i> <fmt:message key="button.cancel"/>
				        </button>
				    </div>
			   	</div>
			</form:form>
		</div>
		
	</div>


 

<v:javascript formName="project" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery.multiple.select.js'/>"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("input[type='text']:visible:enabled:first", document.forms['projectForm']).focus();
        
        $('#myTabs a').click(function (e) {
        	  e.preventDefault()
        	  $(this).tab('show')
        	})
        	
        $('.multi-select').multipleSelect();
        
        $('#programName').blur(function() {
			toggleAddButton("#programName", "#addProgram");     	
        });
        
        $('#geographyName').blur(function() {
			toggleAddButton("#geographyName", "#addGeography");     	
        });
        
    });
    
    function toggleAddButton(inputId, buttonId){
    	if ($(inputId).val().replace(/\s{1,}/g, "").length == 0) {
            $(buttonId).attr('disabled', 'disabled');
        } else {
        	$(buttonId).removeAttr('disabled');
        }
    }
    
    function validateProgram() {
    	if($('#programName').val()=="") { return false; }
    	return true;
    }
    
    function validateGeography() {
    	if($('#geographyName').val()=="") { return false; }
    	return true;
    }
</script>
