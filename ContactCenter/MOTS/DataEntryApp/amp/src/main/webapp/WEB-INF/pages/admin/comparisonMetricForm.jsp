<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="comparisonMetric.title"/></title>
    <meta name="menu" content="MetricMenu"/>
    <meta name="heading" content="<fmt:message key='comparisonMetric.heading'/>"/>
</head>

<c:set var="delObject" scope="request"><fmt:message key="comparisonMetricList.comparisonMetric"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>

<div class="row">

	<div class="col-sm-10">
	    <h2><fmt:message key="comparisonMetric.heading"/></h2>
	    <fmt:message key="comparisonMetric.message"/>
	
		<div class="row row-buffer-10">
	   		<appfuse:label key="validationRule.ruleName" styleClass="col-sm-4 control-label"/>
	   		<div class="col-sm-8"><c:out value="${comparisonMetric.metricValidationRule.ruleName}" /></div>
		</div>	
	
		<div class="row row-buffer-20">


			<form:errors path="*" cssClass="alert alert-danger alert-dismissable" element="div"/>
			<form:form commandName="comparisonMetric" method="post" action="/admin/comparisonMetric" cssClass="well"
			           id="comparisonMetricForm" onsubmit="return validateProject(this)">
			           
				<form:hidden path="id"/>
				<form:hidden path="metricValidationRule.id"/>
				
				<div class="row">
				    <spring:bind path="comparisonMetric.compMetricDefinition">
				    <div class="col-sm-10 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				    </spring:bind>
				        <appfuse:label key="comparisonMetric.compMetricDefinition" styleClass="control-label"/>
			            <form:select cssClass="form-control" path="compMetricDefinition" id="compMetricDefinitionId">
			            	<form:option value="" label="Select a comparison metric .. " />
			            	<form:options items="${metricDefinitions}" itemValue="value" itemLabel="label" />
			            </form:select>
				        <form:errors path="compMetricDefinition.id" cssClass="help-block"/>
				    </div>
				</div>
				<div class="row">
			        <spring:bind path="comparisonMetric.compMetricValueLocation">
			        <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
			        </spring:bind>
			            <appfuse:label styleClass="control-label" key="comparisonMetric.compMetricValueLocation"/>
			            <form:select cssClass="form-control" path="compMetricValueLocation" >
			            	<form:option value="" label="Select a metric location .. " />
			            	<form:options items="${metricValueLocations}" itemValue="value" itemLabel="label" />
							
			            </form:select>
			            <form:errors path="compMetricValueLocation" cssClass="help-block"/>
			        </div>			
				</div>
				<div class="row">
			        <spring:bind path="comparisonMetric.alias">
			        <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
			        </spring:bind>
			            <appfuse:label styleClass="control-label" key="comparisonMetric.alias"/>
			            <form:input cssClass="form-control" path="alias" id="alias"  maxlength="50"/>
			            <form:errors path="alias" cssClass="help-block"/>
			        </div>

					</div>
				    <div class="form-group">
				        <button type="submit" class="btn btn-primary" id="save" name="save" onclick="bCancel=false">
				            <i class="icon-ok icon-white"></i> <fmt:message key="button.save"/>
				        </button>			
				        <c:if test="${comparisonMetric.id != null}">
					        <button type="submit" class="btn btn-danger" id="delete" name="delete" onclick="bCancel=false;return confirmMessage(msgDelConfirm)">
					            <fmt:message key="button.delete"/>
					        </button>
					    </c:if>	
				        <button type="submit" class="btn btn-default" id="cancel" name="cancel" onclick="bCancel=true">
				            <i class="icon-remove"></i> <fmt:message key="button.cancel"/>
				        </button>
				    </div>

			   	</div>
			</form:form>
		</div>
		
	</div>
</div>

 

<v:javascript formName="comparisonMetric" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<c:url var="getMetricsURL" value="/admin/comparisonMetric/metrics" />
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("input[type='text']:visible:enabled:first", document.forms['comparisonMetricForm']).focus();
                
    });
    
        
</script>
