<%@ include file="/common/taglibs.jsp"%>

<c:set var="projectReportTypeMsg" scope="request"><fmt:message key="projectReport.type.${projectReport.type}"/></c:set>
<head>
    <title><fmt:message key="projectReportForm.title"><fmt:param value="${projectReportTypeMsg}"/></fmt:message></title>
</head>

<c:set var="delObject" scope="request"><fmt:message key="projectReportList.projectReport"/></c:set>
<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>

<c:set var="projectReportType" scope="request"><fmt:message key="${projectReport.type}"/></c:set>

<script type="text/javascript">var msgDelConfirm =
   "<fmt:message key="delete.confirm"><fmt:param value="${delObject}"/></fmt:message>";
</script>

<div class="row">
		
		<div class="col-sm-12">
		    <h2><fmt:message key="projectReportForm.heading"><fmt:param value="${projectReportTypeMsg}"/></fmt:message></h2>
		    <p><fmt:message key="projectReportForm.message"><fmt:param value="${projectReportTypeMsg}"/></fmt:message></p>

		    <spring:bind path="projectReport.*">
		        <c:if test="${not empty status.errorMessages}">
		            <div class="alert alert-danger alert-dismissable">
		                <a href="#" data-dismiss="alert" class="close">&times;</a>
		                <c:forEach var="error" items="${status.errorMessages}">
		                    <c:out value="${error}" escapeXml="false"/><br/>
		                </c:forEach>
		            </div>
		        </c:if>
		    </spring:bind>
		
			<div class="row>">
			
				<div id="projectReportHeader" class="row">
					<div class="col-sm-6">
						<div class="row row-buffer-10">
					    	<appfuse:label key="projectReport.projectName" styleClass="col-sm-3 control-label"/>
					    	<div class="col-sm-3">
					    		<c:out value="${projectReport.project.projectName}" />
					    	</div>
						</div>
						<div class="row row-buffer-10">
				    		<appfuse:label key="projectReport.programName" styleClass="col-sm-3 control-label"/>
					    	<div class="col-sm-3"><c:out value="${projectReport.program.programName}" /></div>
						</div>					
						<div class="row row-buffer-10">
				    		<appfuse:label key="projectReport.geographyName" styleClass="col-sm-3 control-label"/>
				    		<div class="col-sm-3"><c:out value="${projectReport.geographyMaster.geographyName}" /></div>
						</div>
						<div class="row row-buffer-10">
				    		<appfuse:label key="projectReport.status" styleClass="col-sm-3 control-label"/>
				    		<div class="col-sm-4"><fmt:message key="projectReport.status.${projectReport.status}" /></div>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="row row-buffer-10">
				    		<appfuse:label key="projectReport.reportingPeriodType" styleClass="col-sm-4 control-label"/>
				    		<div class="col-sm-2"><c:out value="${projectReport.reportingPeriod.type}" /></div>
						</div>
						<div class="row row-buffer-10">
				    		<appfuse:label key="projectReport.reportingPeriod" styleClass="col-sm-4 control-label"/>
				    		<div class="col-sm-2"><c:out value="${projectReport.reportingPeriod.formattedEndDate}" /></div>
						</div>
						<div class="row row-buffer-10">
				    		<appfuse:label key="projectReport.functionalArea" styleClass="col-sm-4 control-label"/>
				    		<div class="col-sm-2"><c:out value="${projectReport.functionalArea}" /></div>
						</div>
						
					</div>
				</div>	
				
				<div class="row row-buffer-20" />		
				
				<form:errors path="*" cssClass="alert alert-danger alert-dismissable" htmlEscape="false" element="div"/>
				<form:form modelAttribute="projectReport" method="post" action="submit" cssClass="well" onsubmit="return validateProjectReport(this)">
					<form:hidden path="id" />
					<form:hidden path="type" />
					<form:hidden path="functionalArea" />
					<form:hidden path="reportingPeriod.id" id="reportingPeriodId"/>
					<%--
					<form:hidden path="reportingPeriod.type" id="reportingPeriodType"/>
					<form:hidden path="reportingPeriod.startDate" id="reportingPeriodStartDate"/>
					<form:hidden path="reportingPeriod.endDate" id="reportingPeriodEndDate"/>
					 --%>
					<form:hidden path="project.id" id="projectId"/>
					<form:hidden path="program.id" id="programId"/>
					<form:hidden path="geographyMaster.id" id="geographyMasterId"/>

					<div id="projectReportTable" class="row row-buffer-20">					 
						<div class="row col-sm-12">
							<div class="row">
								<div class="col-sm-2"><appfuse:label key="projectReport.category" styleClass="control-label"/></div>
								<div class="col-sm-3"><appfuse:label key="projectReport.metric" styleClass="control-label"/></div>
								<div class="col-sm-1"><appfuse:label key="${projectReportType == 'actuals' ? 'projectReport.actualValue' :  'projectReport.forecastValue'}" styleClass="control-label"/></div>
								<div class="col-sm-3 col-sm-offset-1"><appfuse:label key="projectReport.comments" styleClass="control-label"/></div>
								<div class="col-sm-1"><appfuse:label key="projectReport.notSupplied" styleClass="control-label"/></div>
							</div>
<%-- 							<c:set var="metrics" value="${projectReport.metrics}" /> --%>							
							<c:forEach items="${projectReport.sortedMetrics}" var="entry" varStatus="status">
								<c:set var="metric" scope="request" value="${entry.value}" />
								
							    <div class="row row-buffer-10">
									<div class="col-sm-2">
										<c:if test="${metric.metricDefinition.subCategory != subCategory}">
											<b>${metric.metricDefinition.subCategory}</b>
										</c:if>
									</div>
									<div class="col-sm-3">
										<a id="popoverOption${metric.metricDefinition.id}" role="button" data-toggle="popover" data-trigger="focus" data-placement="right" tabindex="0"
											data-original-title="${metric.metricDefinition.label}" 
											data-content="${metric.metricDefinition.definition}"
											data-html="true" 
											class="info-popover">
											<i class="fa fa-info-circle"></i></a>
										${metric.metricDefinition.label}
									</div>
									<c:choose>
										<c:when test="${projectReportType == 'actuals'}">
									        <spring:bind path="metrics['${entry.key}'].actualValue">
										        <div class="form-group col-sm-2 ${(not empty status.errorMessages) ? 'has-error' : ''}">
													<form:input path="metrics['${entry.key}'].actualValue" cssClass="form-control metricValue" readonly="${readonly}" />
													<!-- CODEREVIEW:  help-block would be more aptly named "validation-results" -->
													<div class="help-block">
														<c:forEach var="error" items="${status.errorMessages}">
										                    <c:out value="${error}" escapeXml="false"/><br/>
										                </c:forEach>
										            </div>										            
												</div>
											</spring:bind>
											<div class="col-sm-3"><form:textarea path="metrics['${entry.key}'].actualComments" cssClass="form-control" readonly="${readonly}"/></div>
											<div class="col-sm-1 text-center checkbox">
												<c:choose>
													<c:when test="${!readonly}">
														<input type="checkbox" name="metrics['${entry.key}'].actualValueNotSupplied" id="metrics['${entry.key}'].actualValueNotSupplied" <c:if test="${metric.actualValueNotSupplied == 'Y'}">checked="checked"</c:if> /> 
													</c:when>
													<c:otherwise>
														<input disabled type="checkbox" name="metrics['${entry.key}'].actualValueNotSupplied" id="metrics['${entry.key}'].actualValueNotSupplied" <c:if test="${metric.actualValueNotSupplied == 'Y'}">checked="checked"</c:if> />
														<form:hidden path="metrics['${entry.key}'].actualValueNotSupplied" />
													</c:otherwise>
												</c:choose>
											</div>
								     	</c:when>
										<c:when test="${projectReportType=='forecasts'}">
									        <spring:bind path="projectReport.metrics['${entry.key}'].forecastValue">
										        <div class="form-group col-sm-2 ${(not empty status.errorMessages) ? 'has-error' : ''}">
													<form:input path="metrics['${entry.key}'].forecastValue" cssClass="form-control metricValue" readonly="${readonly}" />
													<div class="help-block">
														<c:forEach var="error" items="${status.errorMessages}">
										                    <c:out value="${error}" escapeXml="false"/><br/>
										                </c:forEach>
										            </div>
												</div>
											</spring:bind>
											<div class="col-sm-3"><form:textarea path="metrics['${entry.key}'].forecastComments" cssClass="form-control" readonly="${readonly}" /></div>
											<div class="col-sm-1 text-center checkbox">
												<c:choose>
													<c:when test="${!readonly}">
														<input type="checkbox" name="metrics['${entry.key}'].forecastValueNotSupplied" id="metrics['${entry.key}'].forecastValueNotSupplied" <c:if test="${metric.forecastValueNotSupplied == 'Y'}">checked="checked"</c:if> /> 
													</c:when>
													<c:otherwise>
														<input disabled type="checkbox" name="metrics['${entry.key}'].forecastValueNotSupplied" id="metrics['${entry.key}'].forecastValueNotSupplied" <c:if test="${metric.forecastValueNotSupplied == 'Y'}">checked="checked"</c:if> />
														<form:hidden path="metrics['${entry.key}'].forecastValueNotSupplied" />
													</c:otherwise>
												</c:choose>
											</div>
								     	</c:when>
							     	</c:choose>
							     </div>
							     
							     <c:set	var="subCategory" value="${metric.metricDefinition.subCategory}" />

						     </c:forEach>
						      
						</div>
					</div>
					 
					<div id="projectReportButtons" class="row">
					    <security:authorize access="${isProjectReportApprover}" var="isProjectReportApprover" />
					    
					    <div class="col-sm-6">
							<c:choose>
								<c:when test="${projectReport.status == 'Pending'}">
							        <button type="submit" class="btn btn-info" id="confirm" name="confirm" onclick="bCancel=false;bConfirm=true;">
							            <fmt:message key="button.submitForReview"/>
							        </button>
							        <button type="submit" class="btn btn-primary left-buffer-20" id="save" name="save" onclick="bCancel=false;bConfirm=false;">
							            <fmt:message key="button.saveAndClose"/>
							        </button>
								</c:when>
								<c:when test="${projectReport.status == 'Confirmed'}">
									<c:if test="${isProjectReportApprover}">
								        <button type="submit" class="btn btn-info" id="approve" name="approve" onclick="bCancel=false;bConfirm=false;">
								            <fmt:message key="button.approve"/>
								        </button>
							        </c:if>
							        <button type="submit" class="btn btn-primary left-buffer-20" id="reEdit" name="reEdit" onclick="bCancel=false;bConfirm=false;">
							            <fmt:message key="button.reEdit"/>
							        </button>
								</c:when>
								<c:when test="${projectReport.status == 'Approved'}">
									<c:if test="${isProjectReportApprover}">
								        <button type="submit" class="btn btn-primary left-buffer-20" id="reEdit" name="reEdit" onclick="bCancel=false;bConfirm=false;">
								            <fmt:message key="button.reEdit"/>
								        </button>
							        </c:if>
								</c:when>
							</c:choose>		    					        
					        <button type="submit" class="btn btn-default" id="cancel" name="cancel" onclick="bCancel=true;bConfirm=false;">
					            <fmt:message key="button.cancel"/>
					        </button>
						</div>
						<div class="col-sm-1 col-sm-offset-4">
					      	<c:if test="${(projectReport.status == 'Pending') && (not empty projectReport.id) && (empty projectReport.approvedDate)}">
					            <button type="submit" class="btn btn-danger" id="delete" name="delete" onclick="bCancel=true;return confirmMessage(msgDelConfirm)">
					                <fmt:message key="button.delete"/>
					            </button>
					        </c:if>			
					    </div>
				    </div>
			
				</form:form>
			</div>
		</div>
	
</div>

<div id="dialog" />

<v:javascript formName="projectReport" cdata="false" dynamicJavascript="true" staticJavascript="false"/>
<script type="text/javascript" src="<c:url value='/scripts/validator.jsp'/>"></script>

<c:url var="onActualValueChangeURL" value="/report/validateActualValue" />
<script type="text/javascript">
    $(document).ready(function() {
    	
    	<c:if test="${!readonly}">
	    	$("[id$='Value']").each(function(){
	    		setNotSuppliedDisabled(this);
	    	});
	    	
	    	$(':checkbox').each(function(){
	    		setMetricValueReadonly(this);
	    	});
    	
	    	$("input[type='text']:visible:enabled:first", document.forms['projectReportForm']).focus();
	    </c:if>
    	
    	
        
    	$("[id$='Value']").change(function() {
        			
        			setNotSuppliedDisabled(this);
        			
        			$(this).parent().removeClass('has-error');
        			$(this).parent().removeClass('has-warning');
        			$(this).siblings(".help-block").html("");
        			
					validateAJAX();
        			
   				});
    	
    	$(':checkbox').change(function() {

        			setMetricValueReadonly(this);
        			
        			$(this).parent().removeClass('has-error');
        			$(this).parent().removeClass('has-warning');
        			$(this).siblings(".help-block").html("");
        			
					validateAJAX();
        			
   				});
    	
    	$('[data-toggle="popover"]').popover();
    	
    	//Press Enter in INPUT moves cursor to next INPUT
    	$('#projectReport').find('.form-control').keypress(function(e){
    	    if ( e.which == 13 ) // Enter key = keycode 13
    	    {
    	        $(this).next().focus();  //Use whatever selector necessary to focus the 'next' input
    	        return false;
    	    }
    	});
    	
    });

    
    function setNotSuppliedDisabled(metricValue) {
		var id = metricValue.id
		var metricDefId = id.substring(id.indexOf("'")+1, id.lastIndexOf("'"));
		var notSupplied = $("input[id*='\\'"+metricDefId+"\\'\]'][id*='ValueNotSupplied']")[0];
		
		if($(metricValue).val() == '') {
        	$(notSupplied).attr('disabled', false);
        	$(notSupplied).removeClass('disabled');
		} else {
        	$(notSupplied).attr('disabled', true);
        	$(notSupplied).addClass('disabled');
		}

    }
    
    function setMetricValueReadonly(notSupplied){
		var id = notSupplied.id
		var metricDefId = id.substring(id.indexOf("'")+1, id.lastIndexOf("'"));
		var value = $("input[id*='\\'"+metricDefId+"\\'.'][id$='Value']")[0];
		
		if(notSupplied.checked) {
			$(value).attr('readonly','readonly');
		} else {
			$(value).removeAttr('readonly');
		}
    }
    
    function processValidationResults(data) {
    	if(!data.isValid) {
			var cssClass;
			if (data.hasError) {
				cssClass = 'has-error';
			} else {
				cssClass = 'has-warning';
			}
			
			var metricDefId = data.field.substring(data.field.indexOf("'")+1, data.field.lastIndexOf("'"));
			var actualValue = $("input[id*='\\'"+metricDefId+"\\'.'][id$='Value']")[0];
			
            $(actualValue).parent().addClass(cssClass);
            var html = "";
            jQuery.each(data.messages, function(index, message) {
            	html += "* " + message + "<br />";
            });
            
            $(actualValue).siblings(".help-block").html(html);
		}  
	}
    
    function validateAJAX() {
    	
    	if(!validateNumeric()) { return false; }
    	
		var id = $("#id").val();
		var type = $("#type").val();
		var fieldPrefix = (type=='actuals' ? 'actual' : 'forecast');
		var reportingPeriodId = $('#reportingPeriodId').val();
		<%--
			commenting out due to issue deserializing dates
		var reportingPeriodType = $('#reportingPeriodType').val();
		var startDate = $('#reportingPeriodStartDate').val();
		var endDate = $('#reportingPeriodEndDate').val();
		--%>
		var projectId = $('#projectId').val();
		var programId = $('#programId').val();
		var geographyMasterId = $('#geographyMasterId').val();
		var functionalArea = $('#functionalArea').val();
		
		/*
			create a json representation of the form and its input values
		*/
		// var projectReportJSON = JSON.stringify($("#projectReport").serializeArray()); 
		var projectReportJSON = '{\r\n';
		projectReportJSON += '"id":"' + id + '",\r\n';
		projectReportJSON += '"type":"' + type + '",\r\n';
		projectReportJSON += '"functionalArea":"' + functionalArea + '",\r\n';
		projectReportJSON += '"reportingPeriod":{ "id":"' + reportingPeriodId + '"},\r\n'; //", "type":"'+ reportingPeriodType +'", "startDate":"'+ startDate +'", "endDate":"'+ endDate +'"},\r\n';
		projectReportJSON += '"project":{ "id":"' + projectId + '"},\r\n';
		projectReportJSON += '"program":{ "id":"' + programId + '"},\r\n';
		projectReportJSON += '"geographyMaster":{ "id":"' + geographyMasterId + '"},\r\n';
		
		var metrics = '"metrics": {\r\n';
		$(".metricValue").each(function() {
			

			var metricDefId = this.id.substring(this.id.indexOf("'")+1, this.id.lastIndexOf("'"));
			var comments = $("textarea[id*='\\'"+metricDefId+"\\'.'][id*='Comments']")[0].value; 
			var notSupplied = $("input[id*='\\'"+metricDefId+"\\'\]'][id*='ValueNotSupplied']")[0].checked;
			
			metrics += '"'+ metricDefId +'":{'
				+ '"' + fieldPrefix+'Value":"'+ this.value + '",' 
				+ '"' + fieldPrefix+'Comments":"'+ comments + '",'
				+ '"' + fieldPrefix+'ValueNotSupplied":"'+ notSupplied + '"'
				+'}';
				
			metrics += '\r\n,';
			
			
		});
		
		metrics = metrics.slice(0,-1);
		metrics += '}\r\n';
		
		projectReportJSON += metrics;
		projectReportJSON += '}';
		
		$.ajax({
			url: '${onActualValueChangeURL}',
			type:"POST",
			data: projectReportJSON,
			contentType: "application/json; charset=utf-8",
			dataType:"json",
			success: function(data) {
				$(data).each(function() {
					var cssClass = "";
					var messageHtml = "";
					var metricDefId = this.field.substring(this.field.indexOf("'")+1, this.field.lastIndexOf("'"));
					var metricValue = $("input[id*='\\'"+metricDefId+"\\'.'][id$='Value']")[0]
					
					$(metricValue).parent().removeClass("has-error has-warning");
					
					if(this.hasError) {
						cssClass = "has-error";
					} else {
						cssClass = "has-warning";
					}
					
					$(this.messages).each(function(){
						messageHtml += "* " + this.value + "<br />";	
					});

					$(metricValue).parent().addClass(cssClass);
					$(metricValue).siblings(".help-block").html(messageHtml);
					
				});
			}
		});

    }

        
    function validateProjectReport(form) {

    	//  if cancel was selected, do not validate form
    	if(bCancel) return true;
    	
    	//  initialize boolean values
    	var bValid = true;
    	var bValidNumeric = true;
    	var bValidMetricValues = true;

    	//  validate that metric values are numeric
    	bValidNumeric = validateNumeric();
    	
    	//  if submitted for review, validate that a metric value
    	//  was supplied or that the not supplied checkbox was checked
    	//  and a comment was entered.
    	if(bConfirm) bValidMetricValues = validateMetricSupplied();
    	
    	bValid = (bValidNumeric && bValidMetricValues);
    	if(!bValid) return false;

    }
    
    function validateNumeric() {
    	
    	var bValid = true;
    	
    	$(".metricValue").each(function() {
		    var metricValue = this.value;
		    
    		if (metricValue) {
    			var valid = (metricValue.match(/^-?\d*(\.\d{1,6})?$/));
    			var fValue = parseFloat(metricValue);
	    		
	            if (!valid || isNaN(fValue)) {
	                // alert("Metric value must be numeric.");
	                $(this).parent().addClass("has-error");
	                $(this).siblings(".help-block").html("* Metric value must be numeric with up to 6 decimal places.");
	            	this.focus();
	            	bValid = false;
	
	            } else {
	            	$(this).parent().removeClass("has-error has-warning");
	            	$(this).siblings(".help-block").html("");
	            }
    		}
		    
		});
    	
    	return bValid;
    }
    
    
    function validateMetricSupplied() {
    	
    	var bValid = true;
    	
    	$(".metricValue").each(function() {
		    var metricValue = this.value;
		    
    		if (!metricValue) {
    			
    			var valid = true;
    			
    			try {
	    			var metricDefId = this.id.substring(this.id.indexOf("'")+1, this.id.lastIndexOf("'"));
	    			var comments = $("textarea[id*='\\'"+metricDefId+"\\'.'][id*='Comments']")[0].value; 
	    			var notSupplied = $("input[id*='\\'"+metricDefId+"\\'\]'][id*='ValueNotSupplied']")[0].checked; 
    			} catch (e) {
    				valid = false;
    			}
    			
    			// if comments is not empty and notSupplied is not checked
    			// set bValid to false to force user to provide metric value
    			if(comments && notSupplied) {
    				valid = true;
    			} else {
    				valid = false;
    			}
    			
    			
	            if (!valid) {
	                // alert("Metric value must be numeric.");
	                $(this).parent().addClass("has-error");
	                $(this).siblings(".help-block").html("* A metric value must be provided or the not supplied checkbox must be checked and a comment entered.");
	            	this.focus();
	            	bValid = false;
	
	            } else {
	            	$(this).parent().removeClass("has-error");
	            	$(this).siblings(".help-block").html("");
	            }

    		}
		    
		});
    	
    	return bValid;

    }
    
</script>





