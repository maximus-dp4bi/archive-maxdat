#!/usr/bin/python
import pandas as pd
import os
import re
import sys
import datetime
import shutil


def get_curr_datetime():
    return datetime.datetime.now().strftime('%Y%m%d%H%M')


def format_holidays():
    main_dir = '/home/streamsets/project_hours'
    curr_dt = get_curr_datetime()
    in_csv_file = 'project_holidays.csv'
    out_csv_file = curr_dt + '_formatted_project_holidays.csv'
    err_csv_file = curr_dt + '_discarded_project_holidays.csv'
    os.chdir(main_dir)

    if not os.path.isfile(in_csv_file):
        return
    ph_data = pd.read_csv(in_csv_file, error_bad_lines=False,
                          warn_bad_lines=True)
    ph_data = ph_data.astype(str)
    upd_data = pd.DataFrame(columns=['PROJECT_ID',
                            'PROJECT_HOLIDAY_DATE', 'HOLIDAY_NAME',
                            'ISDELETE', 'CHECK_FLAG'])
    dsc_data = pd.DataFrame(columns=['PROJECT_ID',
                            'PROJECT_HOLIDAY_DATE', 'HOLIDAY_NAME',
                            'ISDELETE'])
    dup_data = pd.DataFrame(columns=['PROJECT_ID',
                            'PROJECT_HOLIDAY_DATE', 'HOLIDAY_NAME',
                            'ISDELETE'])

    dt_format = \
        re.compile('^(20[2-9][0-9])-(0[1-9]|[10-12])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])$')

    # wd_format = re.compile('[1-7]')

    for (idx, rows) in ph_data.iterrows():
        project_id = rows['PROJECT_ID'].replace(' ', '')
        project_holiday_date = rows['HOLIDAY_DATE'].replace(' ', '')
        holiday_name = rows['HOLIDAY_NAME'].strip()
        isdelete = rows['ISDELETE'].replace(' ', '')
        check_flag = 0
        

        if project_id.isnumeric() \
            and dt_format.search(project_holiday_date) \
            and (isdelete.lower() == 'nan' or isdelete == '0.0'
                 or isdelete == '1.0'):
            if isdelete.lower() == 'nan':
                isdelete = int(0)
            else:
                isdelete = int(float(isdelete))
            new_row = {
                'PROJECT_ID': project_id,
                'PROJECT_HOLIDAY_DATE': project_holiday_date,
                'HOLIDAY_NAME': holiday_name,
                'ISDELETE': isdelete,
                'CHECK_FLAG': check_flag,
                }
            upd_data = upd_data.append(new_row, ignore_index=True)
        else:

            if isdelete.lower() == 'nan':
                isdelete = ''
            else:
                isdelete = int(float(isdelete))
            new_row = {
                'PROJECT_ID': project_id,
                'PROJECT_HOLIDAY_DATE': project_holiday_date,
                'HOLIDAY_NAME': holiday_name,
                'ISDELETE': isdelete,
                }
            dsc_data = dsc_data.append(new_row, ignore_index=True)

    upd_data.to_csv(out_csv_file, index=False)

    fph_data = pd.read_csv(out_csv_file)
    dup_copy = fph_data[fph_data.duplicated(['PROJECT_ID',
                        'PROJECT_HOLIDAY_DATE'], keep=False)]

    fph_data.drop_duplicates(subset=['PROJECT_ID',
                             'PROJECT_HOLIDAY_DATE'], keep=False,
                             inplace=True)
    fph_data.to_csv(out_csv_file, index=False)

    for (idx, rows) in dup_copy.iterrows():
        new_row = {
            'PROJECT_ID': rows['PROJECT_ID'],
            'PROJECT_HOLIDAY_DATE': rows['PROJECT_HOLIDAY_DATE'],
            'HOLIDAY_NAME': rows['HOLIDAY_NAME'],
            'ISDELETE': rows['ISDELETE'],
            }
        dsc_data = dsc_data.append(new_row, ignore_index=True)

    if dsc_data.shape[0] > 0:
        dsc_data.to_csv(err_csv_file, index=False)
    if os.path.isfile(err_csv_file):
        shutil.move(err_csv_file, 'discarded/' + err_csv_file)

    if os.path.isfile(in_csv_file):
        new_filename = curr_dt + '_' + in_csv_file
        shutil.move(in_csv_file, 'archive/' + new_filename)


def main():
    if len(sys.argv) != 1:
        print('USAGE: project_holidays_formatter.py')
        exit()

    format_holidays()


if __name__ == '__main__':
    main()
