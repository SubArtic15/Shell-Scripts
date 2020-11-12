"""
:summary file used to create and manage shortcuts and JSON file associated with
         launch shortcut/command.
:project Shell Script (2020)
"""
from json import load, dumps
from os import getenv
from sys import argv

from launch_library import LaunchOption



def transform_json_to_obj(is_json_file):
    """take in a read JSON file and transform it into an array of custom objects"""
    obj_arr = []

    for shortcut in is_json_file:
        desc, path = is_json_file[shortcut].values()
        obj = LaunchOption(shortcut, path, desc)
        obj_arr.append(obj)
    return obj_arr


def transform_obj_to_json(is_obj_arr):
    """take in a object array and transform it into a JSON file"""
    json_out = dict()
    for obj in is_obj_arr:
        s, t = obj.export()
        json_out[s] = t
    return json_out




if __name__ == '__main__':
    # variable set up
    back_end_dir = argv[1]
    action, *terms = argv[2:]

    PATHS_DIR = getenv('HOME') + '/.launch_paths.json'

    # get the paths
    with open(PATHS_DIR, "r") as data_file:
        json_file = load(data_file)
    object_array = transform_json_to_obj(json_file)

    # do adding action
    if action == '--add':
        to_add = LaunchOption(*terms)
        object_array.append(to_add)

    # do remove action
    else:
        all_shorcuts = list(json_file.keys())
        for obj in object_array:
            if obj.get_shortcut() == terms[0]:
                object_array.remove(obj)

    output_json = transform_obj_to_json(object_array)
    with open(PATHS_DIR, "w") as data_file:
        json_file = dumps(output_json, indent=4, sort_keys=True)
        data_file.write(json_file)
