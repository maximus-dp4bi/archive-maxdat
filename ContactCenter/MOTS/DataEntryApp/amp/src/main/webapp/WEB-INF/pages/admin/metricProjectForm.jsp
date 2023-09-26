<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="metricProjectDetail.title"/></title>
    <meta name="menu" content="MetricMenu"/>
    <meta name="heading" content="<fmt:message key='metricProjectDetail.heading'/>"/>
</head>

<%--
<c:set var="delObject" scope="request"><fmt:message key="metricProjectList.metric"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>
 --%>

<div class="row">

	<div class="col-sm-12">
	    <h2><fmt:message key="metricProjectDetail.heading"/></h2>
	    <fmt:message key="metricProjectDetail.message"/>
	
		<div class="row row-buffer-10">
	   		<appfuse:label key="project.projectName" styleClass="col-sm-4 control-label"/>
	   		<div class="col-sm-2"><c:out value="${metricProject.project.projectName}" /></div>
		</div>	
		
		<c:if test="${metricProject.id!=0}">
			<div class="row row-buffer-10">
		   		<appfuse:label key="program.programName" styleClass="col-sm-4 control-label"/>
		   		<div class="col-sm-2"><c:out value="${metricProject.program.programName}" /></div>
			</div>	
			<div class="row row-buffer-10">
		   		<appfuse:label key="geographyMaster.geographyName" styleClass="col-sm-4 control-label"/>
		   		<div class="col-sm-2"><c:out value="${metricProject.geographyMaster.geographyName}" /></div>
			</div>	
			<div class="row row-buffer-10">
		   		<appfuse:label key="metricDefinition.metricName" styleClass="col-sm-4 control-label"/>
		   		<div class="col-sm-2"><c:out value="${metricProject.metricDefinition.label}" /></div>
			</div>
		</c:if>
	
	
		<div class="row row-buffer-20">


			<form:errors path="*" cssClass="alert alert-danger alert-dismissable" element="div"/>
			<form:form commandName="metricProject" method="post" action="/admin/metricProject" cssClass="well"
			           id="metricProjectForm" onsubmit="return validateMetricProject(this)">
			           
				<form:hidden path="id"/>
				<form:hidden path="project.id" id="projectId" />
				
				<div class="row">
				    
				    <c:if test="${metricProject.id==0}">

				        <spring:bind path="metricProject.program">
				        <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				        </spring:bind>
				            <appfuse:label styleClass="control-label" key="program.programName"/>
				            <form:select cssClass="form-control" path="program.id" id="programId">
				            	<form:option value="" label="Select a Program .. " />
				            	<form:options items="${programMap}" itemValue="value" itemLabel="label" />
								
				            </form:select>
				            <form:errors path="program" cssClass="help-block"/>
				        </div>			
				        
				        <spring:bind path="metricProject.geographyMaster">
				        <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
				        </spring:bind>
				            <appfuse:label styleClass="control-label" key="geographyMaster.geographyName"/>
				            <form:select cssClass="form-control" path="geographyMaster.id" id="geographyMasterId">
								<form:option value="" label="Select a Geography .. " />
				            	<form:options items="${geographyMasterMap}" itemValue="value" itemLabel="label" />
								
				            </form:select>
				            <form:errors path="geographyMaster" cssClass="help-block"/>
				        </div>
	
						<div class="row">
						
						    <spring:bind path="metricProject.metricDefinition">
						    <div class="col-sm-12 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						    </spring:bind>
						        <appfuse:label key="metricDefinition.label" styleClass="control-label"/>
						        <form:select cssClass="form-control" path="metricDefinition.id" id="metricDefinitionId">
									<form:option value="" label="Select a Metric .. " />
					            	<form:options items="${metrics}" itemValue="value" itemLabel="label" />
						        </form:select>
						        <form:errors path="metricDefinition" cssClass="help-block"/>
						    </div>
						
						</div>
					</c:if>
					<div class="row">
					
<%-- 						<spring:bind path="metricProject.isAutoLoad"> --%>
<%-- 					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}"> --%>
<%-- 					    </spring:bind> --%>
<%-- 					        <appfuse:label key="metricProject.isAutoLoad" styleClass="control-label"/> --%>
<%-- 					        <form:select cssClass="form-control" path="isAutoLoad" id="isAutoLoad"> --%>
<%-- 					        	<form:option value="N" /> --%>
<%-- 					        	<form:option value="Y" /> --%>
<%-- 					        </form:select> --%>
<%-- 					        <form:errors path="isAutoLoad" cssClass="help-block"/> --%>
<!-- 					    </div> -->
						
						<spring:bind path="metricProject.trendIndicatorCalculation">
					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricProject.trendIndicatorCalculation" styleClass="control-label"/>
					        <form:select cssClass="form-control" path="trendIndicatorCalculation">
					        	<form:option value="CONTROL CHART" />
					        	<form:option value="DELTA" />
					        	<form:option value="NO TREND" />
					        </form:select>
					        <form:errors path="trendIndicatorCalculation" cssClass="help-block"/>
					    </div>

						<spring:bind path="metricProject.calculateControlChartInd">
					    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
					    </spring:bind>
					        <appfuse:label key="metricProject.calculateControlChartInd" styleClass="control-label"/>
					        <form:select cssClass="form-control" path="calculateControlChartInd">
					        	<form:option value="N" />
					        	<form:option value="Y" />
					        </form:select>
					        <form:errors path="calculateControlChartInd" cssClass="help-block"/>
					    </div>
					    
					</div>
					<div class="row">
					
						<spring:bind path="metricProject.actualValueProvidedBy">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						        <appfuse:label key="metricProject.actualValueProvidedBy" styleClass="control-label"/>
						    	<form:select cssClass="form-control" path="actualValueProvidedBy">
						        	<form:option value="MAXDAT" />
						        	<form:option value="Template" />
						        	<form:option value="Web" />
						        </form:select>
					        	<div class="help-block">
									<c:forEach var="error" items="${status.errorMessages}">
					                    <c:out value="${error}" escapeXml="false"/><br/>
					                </c:forEach>
					            </div>	
						    </div>
					    </spring:bind>
					    
						<spring:bind path="metricProject.forecastValueProvidedBy">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">						    
						        <appfuse:label key="metricProject.forecastValueProvidedBy" styleClass="control-label"/>
						        <form:select cssClass="form-control" path="forecastValueProvidedBy">
						        	<form:option value="MAXDAT" />
						        	<form:option value="Template" />
						        	<form:option value="Web" />
						        </form:select>
					        	<div class="help-block">
									<c:forEach var="error" items="${status.errorMessages}">
					                    <c:out value="${error}" escapeXml="false"/><br/>
					                </c:forEach>
					            </div>	
						    </div>
					    </spring:bind>
					    
					</div>
					<div class="row">
						<spring:bind path="metricProject.actualEffDate">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
						        <appfuse:label key="metricProject.actualEffDate.mask" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="actualEffDate" maxlength="50" />
					        	<div class="help-block">
									<c:forEach var="error" items="${status.errorMessages}">
					                    <c:out value="${error}" escapeXml="false"/><br/>
					                </c:forEach>
					            </div>	
						    </div>
					    </spring:bind>
					    
						<spring:bind path="metricProject.forecastEffDate">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">						    
						        <appfuse:label key="metricProject.forecastEffDate.mask" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="forecastEffDate" maxlength="50" />
					        	<div class="help-block">
									<c:forEach var="error" items="${status.errorMessages}">
					                    <c:out value="${error}" escapeXml="false"/><br/>
					                </c:forEach>
					            </div>	
						    </div>
					    </spring:bind>
					    
						<spring:bind path="metricProject.recordEndDate">
						    <div class="col-sm-4 form-group${(not empty status.errorMessage) ? ' has-error' : ''}">						    
						        <appfuse:label key="metricProject.recordEndDate.mask" styleClass="control-label"/>
						        <form:input cssClass="form-control" path="recordEndDate" maxlength="50" />
								<div class="help-block">
									<c:forEach var="error" items="${status.errorMessages}">
					                    <c:out value="${error}" escapeXml="false"/><br/>
					                </c:forEach>
					            </div>	
						    </div>
					    </spring:bind>
					    
					</div>

					</div>
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
</div>

 

<v:javascript formName="metricProject" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<c:url var="getMetricsURL" value="/admin/metricProject/metrics" />
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("input[type='text']:visible:enabled:first", document.forms['metricProjectForm']).focus();
    		
   		$('#programId').change(function() { refreshMetrics(); });
   		$('#geographyMasterId').change(function() { refreshMetrics(); });
   		
   	 	refreshMetrics();
                
    });
    
    function refreshMetrics() {
    	var programId = $('#programId').val();
    	var geographyMasterId = $('#geographyMasterId').val();
    	var projectId = $(':hidden#projectId').val();
    	
    	if(programId != '' && geographyMasterId != '') {
    		
    		$('#metricDefinitionId').prop("disabled", true);
    		
    		$.getJSON('${getMetricsURL}', {
    			projectId : projectId,
    			programId : programId,
    			geographyMasterId : geographyMasterId,
    			ajax : 'true'
    		}, function(data) {

    			setOptions('#metricDefinitionId', data);
    		
    			$('#metricDefinitionId').prop("disabled", false);
    			$('#save').prop("disabled", false);
    			
    		});
    		
    	} else {
    		
    		$('#metricDefinitionId').val('');
    		$('#metricDefinitionId').prop("disabled", true);
    		$('#save').prop("disabled", true);
    		
    	}
    	


    }
    
    function setOptions(selectId, options) {
    	var html = '';
    	var len = options.length;
    	for (var i = 0; i < len; i++) {
    		html += '<option value="' + options[i].value + '">'
    				+ options[i].label + '</option>';
    	}
    	html += '</option>';

    	$(selectId).html(html);	
    }
    
    function validateMetricProject(form) {
    	
    	if (bCancel) return true;
    	
    	var bValid = true;
    	
    	bValid = validateDateMMDDYYYY($('#actualEffDate'));
    	bValid = validateDateMMDDYYYY($('#forecastEffDate')) && bValid;
    	bValid = validateDateMMDDYYYY($('#recordEndDate')) && bValid;
        
        return bValid;
    	
    }
    
    function validateDateMMDDYYYY(date) {
    	
    	var bValid = true;
    	
    	if (date.val() != "") {
	    	
	    	var dateArray = date.val().match("^(1[0-2]|0[1-9])/(3[01]|[12][0-9]|0[1-9])/[0-9]{4}$");
	    	if(dateArray== null || dateArray.length != 3) {
	    		bValid = false;
	    	} else {
		    	var mm = parseInt(dateArray[0], 10),
		    		dd = parseInt(dateArray[1], 10),
					yyyy = parseInt(dateArray[2], 10);
		    	
		    	try {
		    		var d = new Date(yyyy, mm - 1, dd);
		    		if (isNaN(d.getTime())) bValid = false;
		    	} catch (err) {
		    		bValid = false;
		    	}
    		}
    	}
 	
        if (!bValid) {
            date.parent().addClass("has-error");
            date.siblings(".help-block").html("* A valid date must be provided in the format MM/DD/YYYY.");
            date.focus();
        } else {
        	date.parent().removeClass("has-error");
        	date.siblings(".help-block").html("");
        }
        
        return bValid;
    }
    
</script>
