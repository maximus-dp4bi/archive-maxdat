# Available constants:
#   They are to assign a type to a field with a value null.
#   sdc.NULL_BOOLEAN, sdc.NULL_CHAR, sdc.NULL_BYTE, sdc.NULL_SHORT, sdc.NULL_INTEGER, sdc.NULL_LONG,
#   sdc.NULL_FLOAT, sdc.NULL_DOUBLE, sdc.NULL_DATE, sdc.NULL_DATETIME, sdc.NULL_TIME, sdc.NULL_DECIMAL,
#   sdc.NULL_BYTE_ARRAY, sdc.NULL_STRING, sdc.NULL_LIST, sdc.NULL_MAP

# Check if Python is part of the PATH variable
import os

import requests
import json
import time
from datetime import date
import pandas as pd
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

class streamsets_login:
    CTH_URL = 'https://cloud.streamsets.com/security/public-rest/v1/authentication/login'
    headers = {
        'Content-Type': 'application/json',
        'X-Requested-By': 'SDC',
    }
    response = []
    USERNAME = None
    PASSWORD = None
    auth_cookie = None

    def __init__(self):
        # Let us first get the user name and password to login
        self.USERNAME = 'streamsets@maximus.com'
        self.PASSWORD = 'n*Db%^Q@7gWT*NVE'
        
        self.login()

    def login(self):
        # Let us first get authenticated
        data = '{"userName":"' + self.USERNAME + '", "password":"' + self.PASSWORD + '"}'
        self.response = requests.post(self.CTH_URL, headers=self.headers, data=data)
        self.auth_cookie = self.response.cookies['SS-SSO-LOGIN']


class streamsets_restful_api:
    sessionToken = None
    path = r'C:\\Users\\claprano\\Documents'
    header_for_info = None

    def __init__(self, sessionToken):
        self.sessionToken = sessionToken
        self.header_for_info = {
            'Content-Type': 'application/json',
            'X-Requested-By': 'SCH',
            'X-SS-REST-CALL': 'true',
            'X-SS-User-Auth-Token': sessionToken,
        }

    def get_streamsets_json_response(self, url):
        RequestResponse = requests.get(url, headers=self.header_for_info)
        #self.save_response_to_json(RequestResponse, 'response_get.json')
        RequestResponseData = RequestResponse.json()
        RequestResponseDataFrame = None
        try:
            if isinstance(RequestResponseData, dict):
                if 'data' in RequestResponseData.keys():
                    RequestResponseDataFrame = pd.json_normalize(RequestResponseData['data'])
                    # print(RequestResponseData.keys())
                else:
                    RequestResponseDataFrame = pd.json_normalize(RequestResponseData)
                    # print(RequestResponseData.keys())
            else:
                RequestResponseDataFrame = pd.json_normalize(RequestResponseData)
                # print('This is a list')
        except Exception as e:
            print(e)
        return RequestResponseDataFrame

    def post_streamsets_json_response(self, url):
        RequestResponse = requests.post(url, headers=self.header_for_info)
        #self.save_response_to_json(RequestResponse, 'response_post.json')
        RequestResponseData = RequestResponse.json()
        RequestResponseDataFrame = None
        try:
            if isinstance(RequestResponseData, dict):
                if 'data' in RequestResponseData.keys():
                    RequestResponseDataFrame = pd.json_normalize(RequestResponseData['data'])
                    # print(RequestResponseData.keys())
                else:
                    RequestResponseDataFrame = pd.json_normalize(RequestResponseData)
                    # print(RequestResponseData.keys())
            else:
                RequestResponseDataFrame = pd.json_normalize(RequestResponseData)
                # print('This is a list')
        except Exception as e:
            print(e)
        return RequestResponseDataFrame

    def get_jobs_tag(self, jobTag):
        GetJobs = '	https://cloud.streamsets.com/jobrunner/rest/v1/jobs?jobTag=' + jobTag  # get the list of jobs based on the job tag
        return self.get_streamsets_json_response(GetJobs)

    def get_problematic_jobs(self):
        GetProblematicJobs = 'https://cloud.streamsets.com/jobrunner/rest/v1/metrics/problematicJobs'  # Gets a list of problematic jobs

        return self.get_streamsets_json_response(GetProblematicJobs)

    def post_ack_error(self, jobList):
        ackErrorforJobs = 'https://cloud.streamsets.com/jobrunner/rest/v1/jobs/acknowledgeErrors'  # ack list of inactive error jobs
        RequestResponse = requests.post(ackErrorforJobs, headers=self.header_for_info, data=jobList)
        return RequestResponse

    def save_response_to_json(self, data, filename):
        with open(self.path + '\\' + filename + '_' + str(date.today()) + '.json', 'w', encoding='utf-8') as f:
            json.dump(data.text, f, ensure_ascii=False, indent=4)
            # f.write(data.text)
        print('File saved')

    def get_all_labels(self):
        GetListofPipelineLabels = 'https://cloud.streamsets.com/pipelinestore/rest/v1/pipelineLabels'  # Gets a list of pipeline labels
        return self.get_streamsets_json_response(GetListofPipelineLabels)

    def get_jobs(self):
        GetJobs = 'https://cloud.streamsets.com/jobrunner/rest/v1/jobs'  # can ask for specific status later
        return self.get_streamsets_json_response(GetJobs)

    def get_pipeline_from_label(self, label):
        GetListofPipelinesfromLabel = 'https://cloud.streamsets.com/pipelinestore/rest/v1/pipelines?pipelineLabelId=' + label  # gets a list of pipelines you want to affect
        return self.get_streamsets_json_response(GetListofPipelinesfromLabel)

    def post_reset_offset(self, job_id):
        ResetOffsetforJob = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/resetOffset'  # Reset the offset for this job
        # reset_offset_response = self.post_streamsets_json_response(ResetOffsetforJob)
        RequestResponse = requests.post(ResetOffsetforJob, headers=self.header_for_info)
        return RequestResponse

    def post_start_jobs(self, jobList):
        ackErrorforJobs = 'https://cloud.streamsets.com/jobrunner/rest/v1/jobs/startJobs'  # ack list of inactive error jobs
        RequestResponse = requests.post(ackErrorforJobs, headers=self.header_for_info, data=jobList)
        return RequestResponse

    def post_start_job(self, job_id, resetOrigin):
        StartPipelinewithJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/start'  # add /start or /stop at the end along with job ID in loop
        # self.post_streamsets_json_response(StopPipelinewithJobId, 'Stop_Pipeline_with_JobId')
        # We might have to wait for a while befor the status changes because it goes into a DEACTIVATING status before it turns INACTIVE
        job_status = self.get_status_for_job(job_id)
        while (job_status['status'].iloc[0] != 'INACTIVE'):
            time.sleep(5)
            job_status = self.get_status_for_job(job_id)
        if (job_status['status'].iloc[0] == 'INACTIVE'):
            if resetOrigin:
                resetOffsetResponse = self.post_reset_offset(job_id)
                time.sleep(5)
                # print(resetOffsetResponse)
            try:
                StartJobResponseDF = self.post_streamsets_json_response(StartPipelinewithJobId)
                job_status = self.get_status_for_job(job_id)
                while (job_status['status'].iloc[0] != 'ACTIVE'):
                    time.sleep(5)
                    job_status = self.get_status_for_job(job_id)
                if job_status['status'].iloc[0] == 'ACTIVE':
                    return 0  # str(job_id) + ' : is successfully started'
                else:
                    return 1  # Something went wrong while starting this job
            except Exception as e:
                return 1  # job_id + ' : Something went wrong while starting this job'
        else:
            return 2  # str(job_id) + ' : is ACTIVE'

    def post_stop_job(self, job_id):
        StopPipelinewithJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/stop'  # add /start or /stop at the end along with job ID in loop
        ForceStopPipelinewithJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/forceStop'  # add /start or /stop at the end along with job ID in loop
        count = 0
        # self.post_streamsets_json_response(StopPipelinewithJobId, 'Stop_Pipeline_with_JobId')
        # We might have to wait for a while befor the status changes because it goes into a ACTIVATING status before it turns ACTIVE
        job_status = self.get_status_for_job(job_id)
        print (job_status['status'].iloc[0])
        # while(job_status['status'].iloc[0]!='ACTIVE'):
        #     time.sleep(5)
        #     job_status = self.get_status_for_job(job_id)
        if (job_status['status'].iloc[0] == 'ACTIVE' or job_status['status'].iloc[0] == 'ACTIVATING'):
            try:
                StopJobResponseDF = self.post_streamsets_json_response(StopPipelinewithJobId)
                job_status = self.get_status_for_job(job_id)
                while count < 10 and job_status['status'].iloc[0] != 'INACTIVE' and job_status['status'].iloc[0] != 'INACTIVE_ERROR':
                    time.sleep(6)
                    job_status = self.get_status_for_job(job_id)
                    print(job_status['status'].iloc[0])
                    count += 1
                if job_status['status'].iloc[0] == 'INACTIVE':
                    return 0  # str(job_id) + ' : is successfully stopped'
                elif job_status['status'].iloc[0] == 'INACTIVE_ERROR':
                    return 1  # str(job_id) + ' : is successfully stopped but need to ack the error'
                else:
                    return 2  # Something went wrong while stopping this job
            except Exception as e:
                return 1  # job_id + ' : Something went wrong while stopping this job'
        elif job_status['status'].iloc[0] == 'DEACTIVATING':
            self.post_streamsets_json_response(ForceStopPipelinewithJobId)
            return 1
        else:
            if count == 10:
                return 2

            return 0  # str(job_id) + ' : is not ACTIVE'

    def get_job_from_commit_id(self, commit_id):
        GetListofJobsfromPipelineCommitId = 'https://cloud.streamsets.com/jobrunner/rest/v1/jobs/forPipelineCommit?pipelineCommitId=' + commit_id  # Fill this through a program 3bf18c0f-1008-4a23-b3df-a98c1331e551:maximus.com'
        return self.get_streamsets_json_response(GetListofJobsfromPipelineCommitId)

    def get_status_for_job(self, job_id):
        GetStatusforJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/currentStatus'
        return self.get_streamsets_json_response(GetStatusforJobId)


def streamsets_intraday_job_rerun(JOBTAG, RERUNJOB):

    # Variables
    errorStarting = False

    # Let us try logging in
    login_object = streamsets_login()

    # Now lets create a rest object to perform various API requests
    streamsets_rest_object = streamsets_restful_api(login_object.auth_cookie)

    # Get a list of all problematic jobs available in the system.
    JobsDataFrame = streamsets_rest_object.get_jobs_tag(JOBTAG)

    for index, row in JobsDataFrame.iterrows():

        #print(row['id'], row['name'], row['currentJobStatus.status'])

        if RERUNJOB == 'Workflow' and '_WORKFLOW' not in row['name']:
            continue

        if row['currentJobStatus.status'].upper() == 'INACTIVE':
            print("Starting ", row['name'])
            startResult = streamsets_rest_object.post_start_job(row['id'], 'True')

            # Only change from False to True
            if startResult > 0 and not errorStarting:
                errorStarting = True

    return errorStarting


def streamsets_intraday_jobs_cleaner(JOBTAG, RERUNJOB, RERUN, EMAILLIST):

    #Variables
    inactiveErrorJobList = None #stores the list of inactive jobs
    stuckJobs = None
    emailJobsList = []

    # Let us try logging in
    login_object = streamsets_login()

    # Creates a  rest object to perform various API requests
    streamsets_rest_object = streamsets_restful_api(login_object.auth_cookie)

    # Get a list of all problematic jobs available in the system.
    JobsDataFrame = streamsets_rest_object.get_jobs_tag(JOBTAG)

    for index, row in JobsDataFrame.iterrows():
        stopResult = 0
        print(row['id'], row['name'], row['currentJobStatus.status'])
        if row['currentJobStatus.status'].upper() != 'INACTIVE':

            # It will not be considered stuck if it is the workflow (For PI generic only)
            # Only change from False to True
            #if '_WORKFLOW' not in row['name'] and not hasStuck:
            #    hasStuck = True

            if RERUNJOB == 'All':
                if stuckJobs == None:
                    stuckJobs = '["' + row['id'] + '"'
                else:
                    stuckJobs += ',"' + row['id'] + '"'
            elif '_WORKFLOW' in row['name']:
                if stuckJobs == None:
                    stuckJobs = '["' + row['id'] + '"'
                else:
                    stuckJobs += ',"' + row['id'] + '"'

            stopResult = streamsets_rest_object.post_stop_job(row['id']) #if 1 it means it went to INACTIVE_ERROR status

            # Store the job name for the email
            emailJobsList.append(row['name'])

        if row['currentJobStatus.status'].upper() == 'INACTIVE_ERROR' or stopResult != 0:
            if inactiveErrorJobList == None:
                inactiveErrorJobList = '["' + row['id'] + '"'
            else:
                inactiveErrorJobList += ',"' + row['id'] + '"'

    # The jobs should be stopped
    if inactiveErrorJobList is not None:
        print('Ack Inactive Errors')
        streamsets_rest_object.post_ack_error(inactiveErrorJobList + ']')

    if stuckJobs is not None and RERUN.upper() == 'True'.upper():
        stuckJobs += ']'
        print('Starting ' + stuckJobs)
        streamsets_rest_object.post_start_jobs(stuckJobs)

    # IF the email job list is empty
    if len(emailJobsList) == 0:
        return 0

    message = PIMessage(RERUN, RERUNJOB, emailJobsList)

    send_email1(EMAILLIST, message[0], message[1])

    return 0


def streamsets_stop_start_jobs(JOBTAG):
    #Variables
    inactiveErrorJobList = None # stores the list of inactive jobs

    # Verifies if there is files in the pending directory
    pendingFilescount = len(os.listdir("/home/streamsets/marsdb/tmp/new_tables/created/"))

    if (pendingFilescount == 0):
        return 0

    # Let us try logging in
    login_object = streamsets_login()

    # Now lets create a rest object to perform various API requests
    streamsets_rest_object = streamsets_restful_api(login_object.auth_cookie)

    # Get a list of load jobs with the job tag passed.
    JobsDataFrame = streamsets_rest_object.get_jobs_tag(JOBTAG)

    for index, row in JobsDataFrame.iterrows():
        stopResult = 0
        print(row['id'], row['name'], row['currentJobStatus.status'])
        if row['currentJobStatus.status'].upper() != 'INACTIVE':
            stopResult = streamsets_rest_object.post_stop_job(row['id']) #if 1 it means it went to INACTIVE_ERROR status

        if row['currentJobStatus.status'].upper() == 'INACTIVE_ERROR' or stopResult != 0:
            if (inactiveErrorJobList == None):
                inactiveErrorJobList = '["' + row['id'] + '"'
            else:
                inactiveErrorJobList += ',"' + row['id'] + '"'

    # The jobs should be stopped
    if inactiveErrorJobList != None:
        streamsets_rest_object.post_ack_error(inactiveErrorJobList + ']')

    # Move files from created folder to tmp/stage folder
    os.system("mv /home/streamsets/marsdb/tmp/new_tables/created/* /home/streamsets/marsdb/tmp/stage/")

    # Restart The jobs

    # Get a list of load jobs with the job tag passed.
    JobsDataFrame = streamsets_rest_object.get_jobs_tag(JOBTAG)

    for index, row in JobsDataFrame.iterrows():
        startResult = 0
        print(row['id'], row['name'], row['currentJobStatus.status'])

        if row['currentJobStatus.status'].upper() == 'INACTIVE':
            startResult = streamsets_rest_object.post_start_job(row['id'], 'True')  # if 1 it means it went to INACTIVE_ERROR status

    return 0


def send_email1(emailList, subject, content):
    port = 25  # For SSL
    smtp_server = "localhost"
    sender_email = "streamsets_noreply@maximus.com"  # Enter your address
    receiver_email = emailList  # Enter receiver address

    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["From"] = sender_email
    message["To"] = receiver_email
    message.attach(MIMEText(content, "plain"))

    with smtplib.SMTP(smtp_server, port) as server:
        # server.login(sender_email, password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        server.quit()



def PIMessage(RERUN, RERUNJOB, emailJobsList):

    emailParts = []

    # Define the email subject and content
    emailContent = """\
    Hi,

    List of Jobs that had to be stopped:"""

    emailSubject = 'ERROR - Stopped Streamsets PI Job(s) List.'

    if RERUN.upper() == 'True'.upper():
        emailSubject += ' Automatic Rerun.'
        emailContent = emailContent + """\

    """ + ', '.join(emailJobsList) + """\


    """ + RERUNJOB + ' jobs were restarted automatically.'
    else:
        emailContent = emailContent + """\

    """ + ', '.join(emailJobsList)

    emailContent = emailContent + """\


    Sincerely,

    Data Engineering Team
    Maximus US"""

    # Create full message
    emailParts.append(emailSubject)
    emailParts.append(emailContent)
    message = """\
    subject: """ + emailSubject + """\

    """ + emailContent

    return emailParts
