# Available constants:
#   They are to assign a type to a field with a value null.
#   sdc.NULL_BOOLEAN, sdc.NULL_CHAR, sdc.NULL_BYTE, sdc.NULL_SHORT, sdc.NULL_INTEGER, sdc.NULL_LONG,
#   sdc.NULL_FLOAT, sdc.NULL_DOUBLE, sdc.NULL_DATE, sdc.NULL_DATETIME, sdc.NULL_TIME, sdc.NULL_DECIMAL,
#   sdc.NULL_BYTE_ARRAY, sdc.NULL_STRING, sdc.NULL_LIST, sdc.NULL_MAP

# Check if Python is part of the PATH variable
import requests
import os
import json
import time
from datetime import date
import pandas as pd
import argparse
import sys

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

    def __init__(self, USERNAME, PASSWORD):
        self.USERNAME = USERNAME
        self.PASSWORD = PASSWORD
        self.login()

    def login(self):
        # Let us first get authenticated
        data = '{"userName":"' + self.USERNAME +'", "password":"' + self.PASSWORD + '"}'
        self.response = requests.post(self.CTH_URL, headers=self.headers, data=data)
        self.auth_cookie = self.response.cookies['SS-SSO-LOGIN']

class streamsets_restful_api:
    sessionToken = None
    path = r'C:\\Users\\asanthanagopalan\\Documents\\Streamsets Python Script'
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
        RequestResponse = requests.get(url, headers  = self.header_for_info)
        # self.save_response_to_json(RequestResponse, filename)
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
        RequestResponse = requests.post(url, headers  = self.header_for_info)
        # self.save_response_to_json(RequestResponse, filename)
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

    def save_response_to_json(self, data, filename):
        with open(self.path +'\\' + filename + '_' + str(date.today()) + '.json', 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=4)
        print('File saved')

    def get_all_labels(self):
        GetListofPipelineLabels='https://cloud.streamsets.com/pipelinestore/rest/v1/pipelineLabels' # Gets a list of pipeline labels
        return self.get_streamsets_json_response(GetListofPipelineLabels)

    def get_jobs(self):
        GetJobs = 'https://cloud.streamsets.com/jobrunner/rest/v1/jobs' # can ask for specific status later
        return self.get_streamsets_json_response(GetJobs)

    def get_pipeline_from_label(self, label):
        GetListofPipelinesfromLabel = 'https://cloud.streamsets.com/pipelinestore/rest/v1/pipelines?pipelineLabelId=' + label #gets a list of pipelines you want to affect
        return self.get_streamsets_json_response(GetListofPipelinesfromLabel)

    def post_reset_offset(self, job_id):
        ResetOffsetforJob = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/resetOffset' # Reset the offset for this job
        # reset_offset_response = self.post_streamsets_json_response(ResetOffsetforJob)
        RequestResponse = requests.post(ResetOffsetforJob, headers  = self.header_for_info)
        return RequestResponse

    def post_start_job(self, job_id, resetOrigin):
        StartPipelinewithJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/start' # add /start or /stop at the end along with job ID in loop
        # self.post_streamsets_json_response(StopPipelinewithJobId, 'Stop_Pipeline_with_JobId')
        # We might have to wait for a while befor the status changes because it goes into a DEACTIVATING status before it turns INACTIVE
        job_status = self.get_status_for_job(job_id)
        while(job_status['status'].iloc[0]!='INACTIVE'):
            time.sleep(5)
            job_status = self.get_status_for_job(job_id)
        if (job_status['status'].iloc[0]=='INACTIVE'):
            if resetOrigin:
                    resetOffsetResponse = self.post_reset_offset(job_id)
                    time.sleep(5)          
                    # print(resetOffsetResponse)      
            try:
                StartJobResponseDF =  self.post_streamsets_json_response(StartPipelinewithJobId)
                job_status = self.get_status_for_job(job_id)
                while(job_status['status'].iloc[0]!='ACTIVE'):
                    time.sleep(5)
                    job_status = self.get_status_for_job(job_id)
                if job_status['status'].iloc[0] == 'ACTIVE':
                    return 0 # str(job_id) + ' : is successfully started'
                else:
                    return 1 # Something went wrong while starting this job
            except Exception as e:
                return 1 # job_id + ' : Something went wrong while starting this job'
        else:
            return 2 # str(job_id) + ' : is ACTIVE'

    def post_stop_job(self, job_id):
        StopPipelinewithJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id + '/stop' # add /start or /stop at the end along with job ID in loop
        # self.post_streamsets_json_response(StopPipelinewithJobId, 'Stop_Pipeline_with_JobId')
        # We might have to wait for a while befor the status changes because it goes into a ACTIVATING status before it turns ACTIVE
        job_status = self.get_status_for_job(job_id)
        # while(job_status['status'].iloc[0]!='ACTIVE'):
        #     time.sleep(5)
        #     job_status = self.get_status_for_job(job_id)
        if (job_status['status'].iloc[0]=='ACTIVE'):
            try:
                StopJobResponseDF =  self.post_streamsets_json_response(StopPipelinewithJobId)
                job_status = self.get_status_for_job(job_id)
                while(job_status['status'].iloc[0]!='INACTIVE'):
                    time.sleep(5)
                    job_status = self.get_status_for_job(job_id)
                if job_status['status'].iloc[0] == 'INACTIVE':
                    return 0 # str(job_id) + ' : is successfully started'
                else:
                    return 1 # Something went wrong while starting this job
            except Exception as e:
                return 1 # job_id + ' : Something went wrong while stopping this job'
        else:
            return 0 # str(job_id) + ' : is not ACTIVE'

    def get_job_from_commit_id(self, commit_id):
        GetListofJobsfromPipelineCommitId = 'https://cloud.streamsets.com/jobrunner/rest/v1/jobs/forPipelineCommit?pipelineCommitId=' + commit_id # Fill this through a program 3bf18c0f-1008-4a23-b3df-a98c1331e551:maximus.com'
        return self.get_streamsets_json_response(GetListofJobsfromPipelineCommitId)

    def get_status_for_job(self, job_id):
        GetStatusforJobId = 'https://cloud.streamsets.com/jobrunner/rest/v1/job/' + job_id +'/currentStatus'
        return self.get_streamsets_json_response(GetStatusforJobId)

def streamsets_start_stop(LABEL, ACTION, resetOrigin):
    # Let us first get the user name and password to login
    USERNAME = 'streamsets@maximus.com'
    PASSWORD = 'n*Db%^Q@7gWT*NVE'
    # Here I've directly entered the password but it would be safer to fetch it from a local protected file

    # These are the arguments for transaction
    LABEL = LABEL
    ACTION = ACTION
    resetOrigin = resetOrigin

    # Let us try logging in
    login_object = streamsets_login(USERNAME, PASSWORD)

    # Now lets create a rest object to perform various API requests
    streamsets_rest_object = streamsets_restful_api(login_object.auth_cookie)

    #let us try to do some API calls
    # LabelsDataFrame = streamsets_rest_object.get_all_labels()

    # Get a list of all the jobs available in the system. We could maybe think about parameterizing this
    JobsDataFrame = streamsets_rest_object.get_jobs()

    # Get a list of pipelines that are associated with a Label argument
    PipelineDataFrame = streamsets_rest_object.get_pipeline_from_label(LABEL)

    # Basically join the two data frames on the latest commit from the pipeline to the commits for the job. This would give a list of jobs to act on.
    if ACTION == 'STOP':
        ResultDF = pd.merge(PipelineDataFrame, JobsDataFrame, how = 'inner', left_on='commitId', right_on='pipelineCommitId')
        FunctionResult = [streamsets_rest_object.post_stop_job(jobid) for jobid in ResultDF['id']]
    elif ACTION == 'START':
        ResultDF = pd.merge(PipelineDataFrame, JobsDataFrame, how = 'inner', left_on='commitId', right_on='pipelineCommitId')
        FunctionResult = [streamsets_rest_object.post_start_job(jobid, resetOrigin) for jobid in ResultDF['id']]
    # print(FunctionResult) # If FunctionResult returns a bunch of 0s then your pipelines should have changed. If not there is some error.

    if sum(FunctionResult)>0:
        return 1
    else:
        return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Perform a REST API request')
    parser.add_argument('--label', metavar='LABEL', required=True, help='the label for pipelines to change')
    parser.add_argument('--action', metavar='ACTION', required=True, help='Action for jobrunner')
    parser.add_argument('--resetOrigin', metavar='resetOrigin', required=False, help='Reset Offset for jobrunner')                        
    args = parser.parse_args()
    if streamsets_start_stop(LABEL = args.label, ACTION = args.action, resetOrigin = args.resetOrigin):
        sys.exit(1)
    else:
        sys.exit(0)
