"""
:summary test & learn JSON python
:project Shell-Scripts/
"""
from string import ascii_lowercase, digits
from random import choice, randint
from json import dumps, load

def random_string(character_set, length):
    output = ""
    for s in range(randint(length // 2, length)):
        output += choice(character_set)
    return output

if __name__ == '__main__':
    # create a dictionary to be converted to JSON
    path_dictionary = dict()

    for i in range(200):
        shortcut = random_string(ascii_lowercase, 10)
        path = random_string(ascii_lowercase + digits, 20)
        desc = random_string(ascii_lowercase, 50)

        path_dictionary[shortcut] = {'path': path,
                                     'desc': desc
                                     }

    # export dictionary struct to JSON
    with open("test.json", "w") as outfile:
        output_str = dumps(path_dictionary, indent=4, sort_keys=True)
        outfile.write(output_str)

    # read JSON to dictionary object
    with open("test.json", "r") as infile:
        file_dictionary = load(infile)

    # random test
    random_shortcut = choice(list(file_dictionary.keys()))

    print("Shortcut:", random_shortcut)
    print("Path:", file_dictionary[random_shortcut]['path'])
    print("Description:", file_dictionary[random_shortcut]['desc'])
