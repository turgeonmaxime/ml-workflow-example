"""Automated prediction.

Usage: 
  04-script-predict-newdata.py --endpoint=URL [--pagesize=SIZE] [--out=OFILE] IFILE
  04-script-predict-newdata.py (-h | --help)

Arguments:
  IFILE            Input file

Options:
  -h --help        Show this screen.
  --endpoint=URL   API endpoint.
  --pagesize=SIZE  Number of records per query [default: 100].
  --out=OFILE      Path to output [default: out.csv].

"""
from docopt import docopt
import requests
import pandas as pd

if __name__ == '__main__':
    arguments = docopt(__doc__)
    endpoint = arguments['--endpoint']
    pagesize = int(arguments['--pagesize'])

    df = pd.read_csv(arguments['IFILE'])
    df['prediction'] = 0.0
    for lb in range(0, df.shape[0], pagesize):
        df_sub = df[lb:(lb + pagesize)]
        response = requests.post(endpoint, json = df_sub.to_json())
        results = pd.Series(response.json()['predictions'], index = df_sub.index)
        df.loc[lb:(lb + pagesize), 'prediction'] = results 

    df.to_csv(arguments['--out'])
