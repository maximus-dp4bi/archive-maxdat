import json
from numpy import string_
import snowflake.connector as sc
from snowflake.connector.pandas_tools import pd_writer
import pandas as pd
from flatten_json import flatten
import time
import os

from snowflake.sqlalchemy import URL
from sqlalchemy import create_engine


class SnowflakeConnector(object):
    Username = None
    Password = None
    Account = None
    warehouse = 'MARS_DP4BI_LOAD_WH'
    database = 'MARS_DP4BI_DEV'
    schema = 'public'
    role = 'MARS_DP4BI_DEV'
    session_parameters = {
        'QUERY_TAG': 'Streamsets Operations Monitoring'
    }

    engine = None
    con = None

    def __init__(self, Username, Password, Account):
        self.Username = Username
        self.Password = Password
        self.Account = Account
        self.ConnectToSnowflake()

    def ConnectToSnowflake(self):
        # Get credentials through a file that is protected at os level
        # try:
        #    PASSWORD = os.getenv('SNOWSQL_PWD')
        #    WAREHOUSE = os.getenv('WAREHOUSE')
        #    AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY_ID')
        #    AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')
        # except Exception as e:
        #    print('Not able to fetch credentials. You might not have authorization or the files might be deleted' + e)

        # But I'm going to set connection manually for now
        try:
            #self.con = sc.connect(
            #    user=self.Username,
            #    password=self.Password,
            #    account=self.Account,
            #    warehouse = self.warehouse,
            #    database = self.database,
            #    schema = self.schema
            #)

            self.engine = create_engine(URL(
                        account = self.Account,
                        user = self.Username,
                        password = self.Password,
                        database = self.database,
                        schema = self.schema,
                        warehouse = self.warehouse,
                        role = self.role
                        ))

            self.con = self.engine.connect()
            # tran = self.con.begin()
            # tran.rollback()
            # print('Connection successful')
            # print(con)
        except Exception as e:
            print(e)
            # print('Error {0} ({1}): {2} ({3})'.format(e.errno, e.sqlstate, e.msg, e.sfqid))

    def WriteToSnowflake(self, df, TableName):
        try:
            # print('Going to try inserting the Data Frame')
            # success, nchunks, nrows, _ = write_pandas(self.con, df, TableName, database = self.database, schema = self.schema)
            df.to_sql(name = TableName, con = self.engine, if_exists = 'replace', index=False, method='multi', chunksize=16384)
        except Exception as e:
            return e
        return 0

class GitConfig(object):
    FilePath = None

    def __init__(self, FilePath):
        self.FilePath = FilePath

    def ReadConfigFile(self):
        # BaselineDF = pd.read_json(self.FilePath, orient= 'index')
        with open(self.FilePath) as data_file:    
            data = json.load(data_file)
            data_flattened = [flatten(d) for d in data['pages']]  
        BaselineDF = pd.DataFrame(data_flattened)
        BaselineTransformedDF = self.TransformDF(BaselineDF)
        return BaselineTransformedDF
    
    def TransformDF(self, df):
        # Have to transpose this because Snowflake has a soft limit on the number of columns possible in a table
        dfTransposeDF = df.transpose()

        # Converting all the columns to type String because I'm getting some type conversion error when I insert into snowflake. Most likely because of those list arrays in between.
        for column in dfTransposeDF:
            dfTransposeDF[column] = dfTransposeDF[column].astype('string')
        
        # Making the first row as the row header
        dfTransposeDF.columns = dfTransposeDF.iloc[0]
        dfTransposeDF = dfTransposeDF[1:]
        dfTransposeDF.columns = dfTransposeDF.columns.str.upper()

        # Making the index a separate column
        dfTransposeDF.reset_index(inplace=True)
        dfTransposeDF = dfTransposeDF.rename(columns = {'index':'SECTIONS'})

        return dfTransposeDF

def ingest_git_config(SnowflakeObject, dirPath, configFile):
    print('Ingesting file:' + configFile)
    GitConfigObject = GitConfig(os.path.abspath(os.path.join(dirPath, configFile)))
    configTransformedDF = GitConfigObject.ReadConfigFile()
    # print(configTransformedDF)       
    # BaselineDF.to_csv('./baselinecsv.csv')


    success = SnowflakeObject.WriteToSnowflake(configTransformedDF, configFile[:-5])

    f = open('./logfile', 'a+')
    currentdate = time.strftime('%Y-%m-%d|%H:%M:%S')
    f.write(currentdate + ',' + str(success) +'\n')
    f.close()

    return success

if __name__ == "__main__":
    dirPath = 'C:\\Users\\asanthanagopalan\\Documents\\Github Config JSON'

    # SnowflakeConnector('SVC_STREAMSETS_MARS_DP4BI_DEV_USER','V*WMA+54Yq=}p~_Y')
    SnowflakeObject = SnowflakeConnector('SVC_STREAMSETS_MARS_DP4BI_DEV_USER', 'V*WMA+54Yq=}p~_Y', 'fu30703.us-east-1')
    # print(SnowflakeObject.engine, SnowflakeObject.con)
    # Trying to connect to snowflake

    fileList = os.listdir(dirPath)
    # print(fileList)
    # print([os.path.abspath(os.path.join(dirPath, i)) for i in fileList])
    successOutput = [ingest_git_config(SnowflakeObject, dirPath, i) for i in fileList]

    print(successOutput)
    
    # [ingest_git_config(fileList)]
# Ingest the json into snowflake raw tables

#cs = ctx.cursor()
# try:
#    cs.execute("create or replace transient table test_json_load (scr variant)")
#    cs.execute("insert into test_json_load (select PARSE_JSON('%s'))" % json.dumps(var))
# finally:
#    cs.close()
# ctx.close()
