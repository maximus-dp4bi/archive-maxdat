# Available constants:
#   They are to assign a type to a field with a value null.
#   sdc.NULL_BOOLEAN, sdc.NULL_CHAR, sdc.NULL_BYTE, sdc.NULL_SHORT, sdc.NULL_INTEGER, sdc.NULL_LONG,
#   sdc.NULL_FLOAT, sdc.NULL_DOUBLE, sdc.NULL_DATE, sdc.NULL_DATETIME, sdc.NULL_TIME, sdc.NULL_DECIMAL,
#   sdc.NULL_BYTE_ARRAY, sdc.NULL_STRING, sdc.NULL_LIST, sdc.NULL_MAP

# Check if Python is part of the PATH variable
import argparse
import sys
import StreamsetsRestAPIFunctions as ssf


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Perform a REST API request')

    # parser.add_argument('--user', metavar='USER', required=True, help='Streamsets User')
    parser.add_argument('--function', metavar='function', required=True, help='Function name (streamsets_intraday_jobs_cleaner, streamsets_stop_start_jobs)')
    parser.add_argument('--jobTag', metavar='TAG', required=True, help='Job Tag')
    parser.add_argument('--rerun', metavar='TAG', required=False, help='True/False to rerun the pipeline')
    parser.add_argument('--rerunJob', metavar='TAG', required=False, help='All/Workflow to select what we want to rerun')
    parser.add_argument('--emailList', metavar='TAG', required=False, help='DataTeamDeveloperGrp@maximus.com, DataTeamIngestionDistUAT@maximus.com, DataTeamDeveloperGrp@maximus.com')
    args = parser.parse_args()

    # Verify if function exists
    if not callable(getattr(ssf, args.function)):
        sys.exit(1)

    # Get the function reference
    funcRef = getattr(ssf, args.function)

    # if streamsets_intraday_jobs_cleaner(USER=args.user, PASS=args.password, JOBTAG=args.jobTag):
    if args.function == 'streamsets_stop_start_jobs':
        sys.exit(funcRef(JOBTAG=args.jobTag))
    elif args.function == 'streamsets_intraday_jobs_cleaner' and args.rerunJob in ('All', 'Workflow'):
        sys.exit(funcRef(JOBTAG=args.jobTag, RERUNJOB=args.rerunJob, RERUN=args.rerun, EMAILLIST=args.emailList))

    sys.exit(0)
