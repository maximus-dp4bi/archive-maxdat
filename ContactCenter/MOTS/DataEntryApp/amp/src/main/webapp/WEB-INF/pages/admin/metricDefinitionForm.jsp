<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="metricDefinitionDetail.title"/></title>
    <meta name="menu" content="AdminMenu"/>
    <meta name="heading" content="<fmt:message key='metricDefinitionDetail.heading'/>"/>
</head>

<c:set var="delObject" scope="request"><fmt:message key="metricDefinitionList.metric"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>



	<div class="col-sm-10">
	    <h2><fmt:message key="metricDefinitionDetail.heading"/></h2>
	    <fmt:message key="metricDefinitionDetail.message"/>
	
	
		<div class="row row-buffer-20">

			<ul class="nav nav-tabs" role="tablist">
			  <li role="presentation" class="active"><a role="tab" aria-controls="info" data-toggle="tab" href="#info">Metric Info</a></li>
			  <li><a role="tab" aria-controls="validation" data-toggle="tab" href="#validation">Validation Rules</a></li>
			</ul>

			<form:errors path="*" cssClass="alert alert-danger alert-dismissable" element="div"/>
			<form:form commandName="metricDefinition" method="post" action="/admin/metricDefinitionForm" cssClass="well"
			           id="metricDefinitionForm" onsubmit="return validateMetric(this)">
			           
				<form:hidden path="id"/>
				<div class="tab-content">
					<div role="tabpanel" id="info" class="tab-pane in active">
						<div class="row">
						    <spring:bind path="metricDefinition.metricName">
						    <div class="col-sm-6 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.metricName" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="metricName" id="metricName"  maxlength="100"/>
						        <form:errors path="metricName" cssClass="help-block"/>
						    </div>
						
						    <spring:bind path="metricDefinition.label">
						    <div class="col-sm-6 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.label" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="label" id="label"  maxlength="100"/>
						        <form:errors path="label" cssClass="help-block"/>
						    </div>
					    </div>
						
						<div class="row">
						
<%-- 						    <spring:bind path="metricDefinition.metricType"> --%>
<%-- 						    <div class="col-sm-6 form-group${(not empty status.errorMessage) ? ' has-error' : ''}"> --%>
<%-- 						    </spring:bind> --%>
<%-- 						        <appfuse:label key="metricDefinition.metricType" styleClass="control-label"/> --%>
<%-- 						        <form:select cssClass="form-control" path="metricType.id" items="${metricTypeMap}" id="metricType.id" /> --%>
<%-- 						        <form:errors path="metricType" cssClass="help-block"/> --%>
<%--  						    </div> --%>
						    
						    <spring:bind path="metricDefinition.functionalArea">
						    <div class="col-sm-5 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.functionalArea" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="functionalArea" />
<%-- 						        <form:select cssClass="form-control" path="functionalArea" > --%>
<%-- 						        	<form:option value="Back Office" /> --%>
<%-- 						        	<form:option value="Contact Center" /> --%>
<%-- 						        </form:select> --%>
						        <form:errors path="functionalArea" cssClass="help-block"/>
						    </div>
						    
						    <spring:bind path="metricDefinition.type">
						    <div class="col-sm-5 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.type" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="type" />
						        <form:errors path="type" cssClass="help-block"/>
						    </div>
						    
					    </div>
						
						<div class="row">
						    
						    <spring:bind path="metricDefinition.category">
						    <div class="col-sm-5 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.category" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="category"  />
						        <form:errors path="category" cssClass="help-block"/>
						    </div>
						    
						    <spring:bind path="metricDefinition.subCategory">
						    <div class="col-sm-5 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.subCategory" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="subCategory" />
						        <form:errors path="subCategory" cssClass="help-block"/>
						    </div>		

					    </div>
					    
					    <spring:bind path="metricDefinition.metricDescription">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.metricDescription" styleClass="control-label"/>
					        <form:textarea cssClass="form-control" path="metricDescription" id="metricDescription" rows="5" maxlength="4000"/>
					        <form:errors path="metricDescription" cssClass="help-block"/>
					    </div>
					
					    <spring:bind path="metricDefinition.helpfulInfo">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.helpfulInfo" styleClass="control-label"/>
					        <form:textarea cssClass="form-control" path="helpfulInfo" id="helpfulInfo" rows="2" maxlength="4000"/>
					        <form:errors path="helpfulInfo" cssClass="help-block"/>
					    </div>
					
					    <spring:bind path="metricDefinition.dataSource">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.dataSource" styleClass="control-label"/>
					        <form:input cssClass="form-control" path="dataSource" id="dataSource" maxlength="250" />
					        <form:errors path="dataSource" cssClass="help-block"/>
					    </div>
					
					    <spring:bind path="metricDefinition.formula">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.formula" styleClass="control-label"/>
					        <form:input cssClass="form-control" path="formula" id="formula" maxlength="250" />
					        <form:errors path="formula" cssClass="help-block"/>
					    </div>
					    
					    <spring:bind path="metricDefinition.example">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.example" styleClass="control-label"/>
					        <form:input cssClass="form-control" path="example" />
					        <form:errors path="example" cssClass="help-block"/>
					    </div>
						
						<div class="row">
						    <spring:bind path="metricDefinition.sortOrder">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.sortOrder" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="sortOrder" id="sortOrder"  maxlength="50"/>
						        <form:errors path="sortOrder" cssClass="help-block"/>
						    </div>
						    
						    <spring:bind path="metricDefinition.isWeekly">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.isWeekly" styleClass="control-label"/>
						        <form:select cssClass="form-control" path="isWeekly" id="isWeekly">
						        	<form:option value="Y" />
						        	<form:option value="N" />
						        </form:select>
						        <form:errors path="isWeekly" cssClass="help-block"/>
						    </div>
						    
						    <spring:bind path="metricDefinition.isMonthly">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.isMonthly" styleClass="control-label"/>
						        <form:select cssClass="form-control" path="isMonthly" id="isMonthly">
						        	<form:option value="Y" />
						        	<form:option value="N" />
						        </form:select>
						        <form:errors path="isMonthly" cssClass="help-block"/>
						    </div>
						    
						</div>
		
					    <spring:bind path="metricDefinition.displayFormat">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.displayFormat" styleClass="control-label"/>
					        <form:input cssClass="form-control" path="displayFormat" id="displayFormat"  maxlength="50"/>
					        <form:errors path="displayFormat" cssClass="help-block"/>
					    </div>
					
					    <%--
					    <spring:bind path="metricDefinition.status">
					    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricDefinition.status" styleClass="control-label"/>
					        <form:select cssClass="form-control" path="status" id="status">
					        	<form:option value="Active" />
					        	<form:option value="Inactive" />
					        </form:select>
					        <form:errors path="status" cssClass="help-block"/>
					    </div>
					     --%>
								

					</div>
					<div role="tabpanel" id="validation" class="tab-pane">
						<div class="row">

						    <spring:bind path="metricDefinition.lowerBound">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.lowerBound" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="lowerBound" id="lowerBound"  maxlength="50"/>
						        <form:errors path="lowerBound" cssClass="help-block"/>
						    </div>
						    
						    <spring:bind path="metricDefinition.upperBound">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.upperBound" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="upperBound" id="upperBound" />
						        <form:errors path="upperBound" cssClass="help-block"/>
						    </div>

						</div>
						
						<div class="row">
							<div class="form-group">
						        <button type="submit" class="btn btn-primary" id="addValidationRule" name="addValidationRule" onclick="bCancel=false">
						            <i class="icon-ok icon-white"></i> <fmt:message key="metricDefinitionDetail.addValidationRule"/>
						        </button>
						    </div>
							<display:table id="rule" name="metricDefinition.validationRules"  
								requestURI="" export="false" pagesize="10" class="table table-condensed table-striped table-hover">
							 
								<display:column titleKey="projectReport.open">
									<a href="/admin/validationRule/edit/${rule.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
								</display:column>
								
							    <display:column property="ruleName" sortable="true" titleKey="validationRule.ruleName" />
							    <display:column property="ruleValidationType" sortable="true" titleKey="validationRule.ruleValidationType" />
							    <display:column property="preventSubmit" sortable="true" titleKey="validationRule.preventSubmit" />
							    <display:column property="allowIgnoreWithComment" sortable="true" titleKey="validationRule.allowIgnoreWithComment" />
								
							</display:table>
						</div>
					</div>
				</div>
				<div class="row">
				    <div class="form-group">
				        <button type="submit" class="btn btn-primary" id="save" name="save" onclick="bCancel=false">
				            <i class="icon-ok icon-white"></i> <fmt:message key="button.save"/>
				        </button>
				<%--
				        <c:if test="${not empty metricDefinition.id}">
				            <button type="submit" class="btn btn-danger" id="delete" name="delete" onclick="bCancel=true;return confirmMessage(msgDelConfirm)">
				                <i class="icon-trash icon-white"></i> <fmt:message key="button.delete"/>
				            </button>
				        </c:if>
				--%>
				
				        <button type="submit" class="btn btn-default" id="cancel" name="cancel" onclick="bCancel=true">
				            <i class="icon-remove"></i> <fmt:message key="button.cancel"/>
				        </button>
				    </div>
			   	</div>
			</form:form>
		</div>
	</div>


<v:javascript formName="metricDefinition" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("input[type='text']:visible:enabled:first", document.forms['metricDefinitionForm']).focus();
        
        $('#myTabs a').click(function (e) {
      	  e.preventDefault()
      	  $(this).tab('show')
      	})
        
    });
</script>
