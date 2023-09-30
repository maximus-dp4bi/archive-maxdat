<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="projectUserDetail.title"/></title>
    <meta name="menu" content="MetricMenu"/>
    <meta name="heading" content="<fmt:message key='projectUserDetail.heading'/>"/>
</head>


<c:set var="delObject" scope="request"><fmt:message key="projectUserList.projectUser"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>
 

<div class="row">

	<div class="col-sm-12">
	    <h2><fmt:message key="projectUserDetail.heading"/></h2>
	    <fmt:message key="projectUserDetail.message"/>
	
		<div class="row row-buffer-10">
	   		<appfuse:label key="project.projectName" styleClass="col-sm-4 control-label"/>
	   		<div class="col-sm-2"><c:out value="${projectUser.project.projectName}" /></div>
		</div>	
	
		<div class="row row-buffer-20">


			<form:errors path="*" cssClass="alert alert-danger alert-dismissable" element="div"/>
			<form:form commandName="projectUser" method="post" action="/admin/projectUser" cssClass="well"
			           id="projectUserForm" onsubmit="return validateProjectUser(this)">
  
				<form:hidden path="id"/>
				<form:hidden path="project.id" id="projectId" />
	         				
				<div class="row">
				    
					<div class="row">
					
					
						<spring:bind path="projectUser.functionalArea">
					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="projectUser.functionalArea" styleClass="control-label"/>
					        <form:select cssClass="form-control" path="functionalArea">
					        	<form:option value="" label="Select a Functional Area .. " />
					        	<form:options items="${functionalAreas}" itemValue="value" itemLabel="label" />
					        </form:select>
					        <form:errors path="functionalArea" cssClass="help-block"/>
					    </div>
					
						<spring:bind path="projectUser.role">
					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="projectUser.role" styleClass="control-label"/>
							<form:select cssClass="form-control" path="role.id" id="roleId">
				            	<form:option value="" label="Select a Role .. " />
				            	<form:options items="${roles}" itemValue="value" itemLabel="label" />
								
				            </form:select>
					        <form:errors path="role" cssClass="help-block"/>
					    </div>
					    
						<spring:bind path="projectUser.user">
					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="projectUser.user" styleClass="control-label"/>
							<form:select cssClass="form-control" path="user" id="userId">
				            	<form:option value="" label="Select a User .. " />
				            	<form:options items="${users}" itemValue="value" itemLabel="label" />
								
				            </form:select>
					        <form:errors path="user" cssClass="help-block"/>
					    </div>

						<spring:bind path="projectUser.isActiveFlag">
					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="projectUser.isActiveFlag" styleClass="control-label"/>
							<form:select cssClass="form-control" path="isActiveFlag">
				            	<form:option value="Y" label="Yes" />
				            	<form:option value="N" label="No" />
								
				            </form:select>
					        <form:errors path="isActiveFlag" cssClass="help-block"/>
					    </div>


					</div>
				    <div class="form-group">
				        <button type="submit" class="btn btn-primary" id="save" name="save" onclick="bCancel=false">
				            <fmt:message key="button.save"/>
				        </button>			
				        <c:if test="${not empty projectUser.id}">
					        <button type="submit" class="btn btn-danger" id="delete" name="delete" onclick="bCancel=false;return confirmMessage(msgDelConfirm)">
					            <fmt:message key="button.delete"/>
					        </button>			
				        </c:if>
				        <button type="submit" class="btn btn-default" id="cancel" name="cancel" onclick="bCancel=true">
				            <fmt:message key="button.cancel"/>
				        </button>
				    </div>

			   	</div>
			
			</form:form>
			
		</div>
		
	</div>
</div>

 

<v:javascript formName="projectUser" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<c:url var="getMetricsURL" value="/admin/projectUser/metrics" />
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("input[type='text']:visible:enabled:first", document.forms['projectUserForm']).focus();

    });
        
</script>
