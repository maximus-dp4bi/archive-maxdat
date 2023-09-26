<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="validationRule.title"/></title>
    <meta name="menu" content="MetricMenu"/>
    <meta name="heading" content="<fmt:message key='validationRule.heading'/>"/>
</head>

<c:set var="delObject" scope="request"><fmt:message key="validationRuleList.validationRule"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>
 
 
<div class="row">

	<div class="col-sm-12">
	    <h2><fmt:message key="validationRule.heading"/></h2>
	    <fmt:message key="validationRule.message"/>
	

		<div class="row row-buffer-10">
	   		<appfuse:label key="validationRule.metricDefinition.metricName" styleClass="col-sm-4 control-label"/>
	   		<div class="col-sm-2"><c:out value="${validationRule.metricDefinition.metricName}" /></div>
		</div>	

		<div class="row row-buffer-20">


			<form:errors path="*" cssClass="alert alert-danger alert-dismissable" element="div"/>
			<form:form commandName="validationRule" method="post" action="/admin/validationRule" cssClass="well"
			           id="validationRuleForm" onsubmit="return validateMetric(this)">
			           
				<form:hidden path="id"/>
				<form:hidden path="metricDefinition.id" />

			    <spring:bind path="validationRule.ruleName">
			    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
			    </spring:bind>
			        <appfuse:label key="validationRule.ruleName" styleClass="control-label"/>
			        <form:input cssClass="form-control" path="ruleName" id="ruleName"  maxlength="250"/>
			        <form:errors path="ruleName" cssClass="help-block"/>
			    </div>

				<div class="row">
				
					<spring:bind path="validationRule.metricValueType">
				    <div class="col-sm-3 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				    </spring:bind>
				        <appfuse:label key="validationRule.metricValueType" styleClass="control-label"/>
				        <form:select cssClass="form-control" path="metricValueType" id="metricValueType">
				        	<form:option value="Actuals" />
				        	<form:option value="Forecasts" />
				        </form:select>
				        <form:errors path="metricValueType" cssClass="help-block"/>
				    </div>
				
				    <spring:bind path="validationRule.ruleValidationType">
				    <div class="col-sm-3 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				    </spring:bind>
				        <appfuse:label key="validationRule.ruleValidationType" styleClass="control-label"/>
				        <form:select cssClass="form-control" path="ruleValidationType" id="ruleValidationType">
				        	<form:option value="ERROR" />
				        	<form:option value="WARNING" />
				        </form:select>
				        <form:errors path="ruleValidationType" cssClass="help-block"/>
				    </div>
				    
				    <spring:bind path="validationRule.preventSubmit">
				    <div class="col-sm-3 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				    </spring:bind>
				        <appfuse:label key="validationRule.preventSubmit" styleClass="control-label"/>
				        <form:select cssClass="form-control" path="preventSubmit" id="preventSubmit">
				        	<form:option value="true" label="Y" />
				        	<form:option value="false" label="N" />
				        </form:select>
				        <form:errors path="preventSubmit" cssClass="help-block"/>
				    </div>
				    
				    <spring:bind path="validationRule.allowIgnoreWithComment">
				    <div class="col-sm-3 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				    </spring:bind>
				        <appfuse:label key="validationRule.allowIgnoreWithComment" styleClass="control-label"/>
				        <form:select cssClass="form-control" path="allowIgnoreWithComment" id="allowIgnoreWithComment">
				        	<form:option value="true" label="Y" />
				        	<form:option value="false" label="N" />
				        </form:select>
				        <form:errors path="allowIgnoreWithComment" cssClass="help-block"/>
				    </div>
				    						    
				</div>

			    <spring:bind path="validationRule.ruleMessage">
			    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
			    </spring:bind>
			        <appfuse:label key="validationRule.ruleMessage" styleClass="control-label"/>
			        <form:input cssClass="form-control" path="ruleMessage" id="ruleMessage"  maxlength="250"/>
			        <form:errors path="ruleMessage" cssClass="help-block"/>
			    </div>

			    <spring:bind path="validationRule.ruleDescription">
			    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
			    </spring:bind>
			        <appfuse:label key="validationRule.ruleDescription" styleClass="control-label"/>
			        <form:textarea cssClass="form-control" path="ruleDescription" id="ruleDescription" rows="3" maxlength="4000"/>
			        <form:errors path="ruleDescription" cssClass="help-block"/>
			    </div>
				
			    <spring:bind path="validationRule.ruleExpression">
			    <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
			    </spring:bind>
			        <appfuse:label key="validationRule.ruleExpression" styleClass="control-label"/>
			        <form:input cssClass="form-control" path="ruleExpression" id="ruleExpression"  />
			        <form:errors path="ruleExpression" cssClass="help-block"/>
			    </div>
				

				<div class="row">
					<div class="form-group">
				        <button type="submit" class="btn btn-primary" id="addComparisonMetric" name="addComparisonMetric" onclick="bCancel=false">
				            <i class="icon-ok icon-white"></i> <fmt:message key="validationRule.addComparisonMetric"/>
				        </button>
				    </div>
				    
					<display:table id="comparisonMetric" name="validationRule.comparisonMetricSet"  
						requestURI="" export="false" pagesize="25" class="table table-condensed table-striped table-hover">
					 
						<display:column titleKey="comparisonMetric.open">
							<a href="/admin/comparisonMetric/edit/${comparisonMetric.id}"><i class="fa fa-pencil-square-o fa-1x"></i></a>
						</display:column>
						
						<display:column property="compMetricDefinition.metricName" sortable="true" titleKey="comparisonMetric.compMetricDefinition" />
						<display:column property="compMetricValueLocation" sortable="true" titleKey="comparisonMetric.compMetricValueLocation" />
					    <display:column property="alias" sortable="true" titleKey="comparisonMetric.alias" />
					    
					    <%--
					    <display:setProperty name="paging.banner.item_name"><fmt:message key="comparisonMetricSet.pagingBannerItemName"/></display:setProperty>
					    <display:setProperty name="paging.banner.items_name"><fmt:message key="comparisonMetricSet.pagingBannerItemName"/></display:setProperty>
						 --%>
						
					</display:table>
				</div>

				<div class="row">
				    <div class="form-group">
				        <button type="submit" class="btn btn-primary" id="save" name="save" onclick="bCancel=false">
				            <i class="icon-ok icon-white"></i> <fmt:message key="button.save"/>
				        </button>
				        <c:if test="${not empty validationRule.id}">
				            <button type="submit" class="btn btn-danger" id="delete" name="delete" onclick="bCancel=true;return confirmMessage(msgDelConfirm)">
				                <i class="icon-trash icon-white"></i> <fmt:message key="button.delete"/>
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

<v:javascript formName="validationRule" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("input[type='text']:visible:enabled:first", document.forms['validationRuleForm']).focus();
    });
</script>
