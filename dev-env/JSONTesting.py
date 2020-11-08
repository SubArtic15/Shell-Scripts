"""
:summary test & learn JSON python
:project Shell-Scripts/
"""
from json import load


FILE = "linux.json"

if __name__ == '__main__':
    with open(FILE) as json_file:
        data = load(json_file)['txs']

    for transaction_id in data:
        for key, value in transaction_id.items():
            print(key + ":", value)
        print('\n')
