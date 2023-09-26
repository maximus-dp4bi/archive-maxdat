from streamsets.sdk import ControlHub
import datetime
import sys
import pandas as pd
import operator


def int_to_datetime(n):
    if (n == ''):
        return n
    return datetime.datetime.fromtimestamp(n / 1e3).strftime('%Y-%m-%d %I:%M:%S %p')


def get_curr_datetime():
    return datetime.datetime.now().strftime('%Y%m%d%H%M')


def print_job_history(user, pwd, job_id):

    control_hub = ControlHub(
        'https://cloud.streamsets.com', username=user, password=pwd)
    my_job = control_hub.jobs.get(id=job_id)

    SummaryStats_FilePath = '/home/streamsets/JobHistoryStatistics/' + \
        get_curr_datetime() + '_' + my_job.job_id + '_' + 'SummaryStats.csv'
    DetailStats_FilePath = '/home/streamsets/JobHistoryStatistics/' + \
        get_curr_datetime() + '_' + my_job.job_id + '_' + 'DetailStats.csv'

    js_JobId = []
    js_JobName = []
    js_RunCount = []
    js_StartTime = []
    js_FinishTime = []
    js_Status = []
    js_InRecordCnt = []
    js_OutRecordCnt = []
    js_ErrRecordCnt = []
    js_User = []
    js_ErrInfo = []
    js_ErrMsg = []
    js_Warning = []
    jh_JobId = []
    jh_JobName = []
    jh_RunCount = []
    jh_MsgID = []
    jh_Time = []
    jh_Msg = []
    jh_Status = []
    jh_User = []

    JobId = my_job.job_id
    JobName = my_job.job_name

    for js in my_job.history:
        if(js.finish_time < js.start_time):
            js.finish_time = ''
        js_JobId.append(JobId)
        js_JobName.append(JobName)
        js_RunCount.append(js.run_count)
        js_StartTime.append(int_to_datetime(js.start_time))
        js_FinishTime.append(int_to_datetime(js.finish_time))
        js_Status.append(js.status + " " + js.color)
        js_InRecordCnt.append(js.input_record_count)
        js_OutRecordCnt.append(js.output_record_count)
        js_ErrRecordCnt.append(js.error_record_count)
        js_User.append(js.user)
        js_ErrInfo.append(js.error_infos)
        js_ErrMsg.append(js.error_message)
        js_Warning.append(js.warnings)

        #js.run_history.sort(key=lambda x:x.time,reverse=True)
        for i, jh in enumerate(js.run_history, 1):
            jh_MsgID.append(i)
            jh_JobId.append(JobId)
            jh_JobName.append(JobName)
            jh_RunCount.append(js.run_count)
            jh_Time.append(int_to_datetime(jh.time))
            jh_Msg.append(jh.message)
            jh_Status.append(jh.status)
            jh_User.append(jh.User)
        jh_MsgID = jh_MsgID[::-1]

    JobHistoryStats_Summary = pd.DataFrame({'JOBID': js_JobId, 'JOBNAME': js_JobName, 'RUNCOUNT': js_RunCount, 'STARTTIME': js_StartTime, 'FINISHTIME': js_FinishTime, 'STATUS': js_Status, 'IN_RECORDCNT': js_InRecordCnt, 'OUT_RECORDCNT': js_OutRecordCnt, 'ERR_RECORDCNT': js_ErrRecordCnt, 'USER': js_User, 'ERR_INFO': js_ErrInfo, 'ERR_MSG': js_ErrMsg, 'WARNING': js_Warning
                                            })

    JobHistoryStats_Detail = pd.DataFrame({'JOBID': jh_JobId, 'JOBNAME': jh_JobName, 'RUNCOUNT': jh_RunCount, 'DTL_MSGID': jh_MsgID, 'DTL_TIME': jh_Time, 'DTL_MSG': jh_Msg, 'DTL_STATUS': jh_Status, 'DTL_USER': jh_User
                                           })
    JobHistoryStats_Summary = JobHistoryStats_Summary.set_index('JOBID')
    JobHistoryStats_Detail = JobHistoryStats_Detail.set_index('JOBID')

    JobHistoryStats_Summary.to_csv(SummaryStats_FilePath)
    JobHistoryStats_Detail.to_csv(DetailStats_FilePath)


def main():
    if len(sys.argv) != 2:
        print('USAGE: print_job_history_tocsv.py <job_id>')
        exit()
    else:
        user = 'streamsets@maximus.com'
        pwd = 'xxxxxxxxxxxx'
        job_id = sys.argv[1]

    print_job_history(user, pwd, job_id)


if __name__ == "__main__":
    main()
