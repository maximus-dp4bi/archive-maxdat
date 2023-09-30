<%@ include file="/common/taglibs.jsp"%>

<c:set var="projectReportTypeMsg" scope="request"><fmt:message key="projectReport.type.${projectReport.type}"/></c:set>
<head>
    <title><fmt:message key="addProjectReport.title"><fmt:param value="${projectReportTypeMsg}"/></fmt:message></title>
</head>

<c:set var="projectReportType" scope="request"><fmt:message key="${projectReport.type}"/></c:set>
<div class="col-sm-2">
    <h2><fmt:message key="addProjectReport.heading"><fmt:param value="${projectReportTypeMsg}"/></fmt:message></h2>
    <p><fmt:message key="addProjectReport.message"><fmt:param value="${projectReportTypeMsg}"/></fmt:message>	
</div>

<div class="col-sm-7">

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


    <form:form modelAttribute="projectReport" method="post" action="submit" id="addProjectReportForm" autocomplete="off"
               cssClass="well" >
        <form:hidden path="id"/>
        <form:hidden path="type" />


        
        <input type="hidden" name="from" value="<c:out value="${param.from}"/>"/>
        

        <spring:bind path="projectReport.project">
        <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
            <appfuse:label styleClass="control-label" key="projectReport.projectName"/>
            <form:select cssClass="form-control" path="project.id" items="${projectMap}" id="projectId" />
            <form:errors path="project" cssClass="help-block"/>
        </div>
        </spring:bind>
        
        <spring:bind path="projectReport.program">
        <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
        </spring:bind>
            <appfuse:label styleClass="control-label" key="projectReport.programName"/>
            <form:select cssClass="form-control" path="program.id" items="${programMap}" id="programId" />
            <form:errors path="program" cssClass="help-block"/>
        </div>

        <spring:bind path="projectReport.geographyMaster">
        <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
        </spring:bind>
            <appfuse:label styleClass="control-label" key="projectReport.geographyName"/>
            <form:select cssClass="form-control" path="geographyMaster.id" items="${geographyMasterMap}" id="geographyMasterId" />
            <form:errors path="geographyMaster" cssClass="help-block"/>
        </div>

        <spring:bind path="projectReport.functionalArea">
        <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
        </spring:bind>
            <appfuse:label styleClass="control-label" key="projectReport.functionalArea"/>
			<form:select cssClass="form-control" path="functionalArea" id="functionalArea">
				<form:option value="select" label="Select a functional area .." />
				<form:options items="${functionalAreas}" itemValue="value" itemLabel="label" />
 
            </form:select>
            <form:errors path="functionalArea" cssClass="help-block"/>
        </div>

		<div class="row">
			<div class="col-sm-6">
		        <spring:bind path="projectReport.reportingPeriod.type">
		        <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
		        </spring:bind>
		            <appfuse:label styleClass="control-label" key="projectReport.reportingPeriodType"/>
		            <form:select cssClass="form-control" path="reportingPeriod.type" id="reportingPeriodType">
		            	<form:option value="select" label="Select a reporting period type .." />
		            	<form:options items="${reportingPeriodTypeMap}" /> 
		            </form:select>
		            <form:errors path="reportingPeriod.type" cssClass="help-block"/>
		        </div>
	       	</div>
	       	<div class="col-sm-5 ">
	       		<label for="reportingPeriodYear">Reporting Period Year</label>
	            <select class="form-control" id="reportingPeriodYear">
					<%-- TODO:  move this logic to the controller --%>
					<c:choose>
						<%-- CODEREVIEW:  need to be able to submit 2016 data in Jan !!! --%>
						<c:when test="${projectReportType == 'actuals'}">
							<option value="2014">2014</option>
							<option value="2015" selected>2015</option> 
			            </c:when>
			            <c:otherwise>
			            	<%-- CODEREVIEW:  remove hard-coding and make dynamic --%>
							<option value="2014">2014</option>
							<option value="2015" selected>2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option> 
			            </c:otherwise>
			        </c:choose> 
	            </select>
	       	</div>
		</div>
        <spring:bind path="projectReport.reportingPeriod">
        <div class="form-group${(not empty status.errorMessage) ? ' has-error' : ''}">
        </spring:bind>
            <appfuse:label styleClass="control-label" key="projectReport.reportingPeriod"/>
			<form:select cssClass="form-control" path="reportingPeriod" id="reportingPeriodId" disabled="true" >
				<%-- having a hard time adding the first select option when using a list of LabelValues or a String Map, not sure why, maybe Generics ?? --%>
				<%-- <form:option value="select" label="Select a reporting period .." /> --%>
				<form:options items="${reportingPeriodMap}" itemValue="value" itemLabel="label" />
 
            </form:select>
            <form:errors path="reportingPeriod" cssClass="help-block"/>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-primary" id="saveNew" name="save" onclick="bCancel=false" disabled="true">
                <i class="icon-ok icon-white"></i> <fmt:message key="button.saveAndEnterMetrics"/>
            </button>

            <button type="submit" class="btn btn-default" id="cancel" name="cancel" onclick="bCancel=true">
                <i class="icon-remove"></i> <fmt:message key="button.cancel"/>
            </button>
        </div>
    </form:form>
</div>

<%--
<c:set var="scripts" scope="request">
<script type="text/javascript">
// This is here so we can exclude the selectAll call when roles is hidden
function onFormSubmit(theForm) {
    return validateUser(theForm);
}
</script>
</c:set>
 --%>
 
<v:javascript formName="projectReport" staticJavascript="false"/>
<script type="text/javascript" src="<c:url value="/scripts/validator.jsp"/>"></script>



<c:url var="onProjectChangeURL" value="/report/project" />
<c:url var="onReportingPeriodTypeChangeURL" value="/report/reportingPeriods" />

<script type="text/javascript">
$(document).ready(function() { 
	$('#projectId').change(
		function() {
			
			$('#reportingPeriodType').val('select');
			$('#reportingPeriodId').val('0');
			$('#reportingPeriodId').prop("disabled", true);
			
			$.getJSON('${onProjectChangeURL}', {
				projectId : $(this).val(),
				ajax : 'true'
			}, function(data) {

				setOptions('#programId', data.programOptions);
				setOptions('#geographyMasterId', data.geographyMasterOptions);

			});
		});
	
	$('#functionalArea').change(function() { refreshReportingPeriods(); });
	$('#reportingPeriodType').change(function() { refreshReportingPeriods(); });
	$('#reportingPeriodYear').change(function() { refreshReportingPeriods(); });
	
});


function refreshReportingPeriods() {
	var functionalArea = $('#functionalArea').val();
	var reportingPeriodType = $('#reportingPeriodType').val();
	
	if(functionalArea != 'select' && reportingPeriodType != 'select') {
		
		$('#reportingPeriodId').prop("disabled", true);
		
		$.getJSON('${onReportingPeriodTypeChangeURL}', {
			functionalArea : functionalArea,
			reportingPeriodType : reportingPeriodType,
			projectId : $('#projectId').val(),
			programId : $('#programId').val(),
			geographyMasterId : $('#geographyMasterId').val(),
			reportType : $('#type').val(),
			reportingPeriodYear : $('#reportingPeriodYear').val(),
			ajax : 'true'
		}, function(data) {

			setOptions('#reportingPeriodId', data);
			
			var reportType = $('#type').val();
			
			if(reportType == 'forecasts') {
				//  default to the first reporting period after today's date
				$("#reportingPeriodId > option").each(function() {
				    if(this.value != 0 && new Date(this.text) > new Date()) {
				    	this.selected = true;
				    	return false;
				    }
				    
				});
			} else {
				// default to the most recent reporting period
				$("#reportingPeriodId :nth-child(2)").prop("selected", true);
			}
			
			$('#reportingPeriodId').prop("disabled", false);
			$('#saveNew').prop("disabled", false);
			
		});
		
	} else {
		
		$('#reportingPeriodId').val('0');
		$('#reportingPeriodId').prop("disabled", true);
		$('#saveNew').prop("disabled", true);
		
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

function formatDate(date) {
	
	var dd = date.getDate();
	var mm = date.getMonth()+1; //January is 0!
	var yyyy = date.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	formattedDate = mm+'/'+dd+'/'+yyyy;
	return formattedDate;
}
</script>
