#!/usr/bin/python
import pandas as pd
import os
import re
import sys
import datetime
import shutil


def get_curr_datetime():
    return datetime.datetime.now().strftime('%Y%m%d%H%M')


def split_by_weekday():
    main_dir = '/home/streamsets/project_hours'
    curr_dt = get_curr_datetime()
    in_csv_file = 'project_hours.csv'
    out_csv_file = curr_dt + '_formatted_project_hours.csv'
    err_csv_file = curr_dt + '_discarded_project_hours.csv'
    os.chdir(main_dir)

    if not os.path.isfile(in_csv_file):
        return
    ph_data = pd.read_csv(in_csv_file,error_bad_lines=False,warn_bad_lines=True)
    ph_data = ph_data.astype(str)
    upd_data = pd.DataFrame(columns=['PROJECT_ID',
                            'PROJECT_HOURS_WEEK_DAY',
                                     'PROJECT_HOURS_START_TIME',
                                     'PROJECT_HOURS_END_TIME', 'CHECK_FLAG'])
    dsc_data = pd.DataFrame(columns=['projectid', 'weekday_start',
                            'weekday_end', 'start_time', 'end_time'])
    dup_data = pd.DataFrame(columns=['project_id',
                            'project_hours_week_day',
                                     'project_hours_start_time',
                                     'project_hours_end_time', 'check_flag'])

    tm_format = re.compile('^([0-1][0-9]|2[0-3]):([0-5][0-9])$')
    wd_format = re.compile('^[1-7]$')

    for (idx, rows) in ph_data.iterrows():
        project_id = rows['projectid'].replace(' ', '')
        start = rows['weekday_start'].replace(' ', '')
        end = rows['weekday_end'].replace(' ', '')
        ph_start = rows['start_time'].replace(' ', '').zfill(5)
        ph_end = rows['end_time'].replace(' ', '').zfill(5)
        check_flag = 0
        if project_id.isnumeric() and wd_format.search(start) and start \
            <= end and wd_format.search(end) \
            and tm_format.search(ph_start) and ph_start <= ph_end \
                and tm_format.search(ph_end):

            if start == end:
                project_hours_weekday = start
                new_row = {
                    'PROJECT_ID': project_id,
                    'PROJECT_HOURS_WEEK_DAY': project_hours_weekday,
                    'PROJECT_HOURS_START_TIME': ph_start,
                    'PROJECT_HOURS_END_TIME': ph_end,
                    'CHECK_FLAG': check_flag,
                }
                upd_data = upd_data.append(new_row, ignore_index=True)
            else:
                for i in range(int(start), int(end) + 1):
                    project_hours_weekday = i
                    new_row = {
                        'PROJECT_ID': project_id,
                        'PROJECT_HOURS_WEEK_DAY': project_hours_weekday,
                        'PROJECT_HOURS_START_TIME': ph_start,
                        'PROJECT_HOURS_END_TIME': ph_end,
                        'CHECK_FLAG': check_flag,
                    }
                    upd_data = upd_data.append(new_row, ignore_index=True)
        else:

            new_row = {
                'projectid': rows['projectid'],
                'weekday_start': rows['weekday_start'],
                'weekday_end': rows['weekday_end'],
                'start_time': rows['start_time'],
                'end_time': rows['end_time'],
            }
            dsc_data = dsc_data.append(new_row, ignore_index=True)
            continue

    upd_data.to_csv(out_csv_file, index=False)

    fph_data = pd.read_csv(out_csv_file)
    dup_copy = fph_data[fph_data.duplicated(['PROJECT_ID',
                        'PROJECT_HOURS_WEEK_DAY'], keep=False)]

    fph_data.drop_duplicates(subset=['PROJECT_ID',
                             'PROJECT_HOURS_WEEK_DAY'], keep=False,
                             inplace=True)
    fph_data.to_csv(out_csv_file, index=False)

    for (idx, rows) in dup_copy.iterrows():
        new_row = {
            'projectid': rows['project_id'],
            'weekday_start': rows['PROJECT_HOURS_WEEK_DAY'],
            'weekday_end': '',
            'start_time': rows['PROJECT_HOURS_START_TIME'],
            'end_time': rows['PROJECT_HOURS_END_TIME'],
        }
        dsc_data = dsc_data.append(new_row, ignore_index=True)

    if dsc_data.shape[0] > 0:
        dsc_data.to_csv(err_csv_file, index=False)
    if os.path.isfile(err_csv_file):
        shutil.move(err_csv_file, "discarded/" + err_csv_file)

    if os.path.isfile(in_csv_file):
        new_filename = curr_dt + "_" + in_csv_file
        shutil.move(in_csv_file, "archive/" + new_filename)


def main():
    if len(sys.argv) != 1:
        print('USAGE: proj_hours_formatter.py')
        exit()

    split_by_weekday()


if __name__ == '__main__':
    main()
