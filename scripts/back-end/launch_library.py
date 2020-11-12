"""
:summary abstraction and management of JSON dictionary relationship
:project Shell-Scripts/
"""
from os import path, getenv


class LaunchOption:
    """unnecessary abstractopm for a standardized key to dictionary relationship"""
    DEFAULT_DESC = "no-description-provided"

    def __init__(self, is_shortcut, is_path, is_desc=None):
        self._shorcut = is_shortcut
        self._path = self.__check_path(is_path)
        self._desc = is_desc or self.DEFAULT_DESC


    def __check_path(self, is_path, is_test=False):
        """check the validity of a given path"""
        if is_test or path.isdir(is_path):
            return is_path
        raise FileNotFoundError(f"The provided path '{is_path}' is invalid.")


    def get_shortcut(self):
        return self._shorcut



    def export(self):
        """transform object into mini JSON object"""
        return self._shorcut, {"path": self._path, "desc": self._desc}


    def __repr__(self):
        return "Shortcut: {}\n\tPath: {}\n\tDesc: {}".format(self._shorcut,
                                                             self._path,
                                                             self._desc)










if __name__ == "__main__":
    from string import ascii_lowercase
    from random import randint, choice

    def random_string(character_set, length):
        output = ""
        for _ in range(randint(length // 2, length)):
            output += choice(character_set)
        return output

    def create_object():
        p = getenv('HOME')
        s = random_string(ascii_lowercase, 10)
        d = random_string(ascii_lowercase, 80)
        return LaunchOption(s, p, d)

    test_dictionary = dict()
    for _ in range(10):
        shrtcut, d = create_object().export()
        test_dictionary[shrtcut] = d


    print("#DISPLAY RESULTS")
    for scut in test_dictionary:
        print("shortcut:", scut)
        for key, val in test_dictionary[scut].items():
            print(f"    {key}: {val}")
        print()
