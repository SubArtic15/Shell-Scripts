"""
:summary a library of functions used in container based function.
:project Shell Script (2020)
"""
from collections import defaultdict
from subprocess import check_output





def command(cmd_to_run):
    """run a terminal command, and return its output"""
    if isinstance(cmd_to_run, str):
        split_cmd_to_run = cmd_to_run.split(' ')
        return check_output(split_cmd_to_run).decode()
    elif isinstance(cmd_to_run, list):
        return check_output(cmd_to_run).decode()
    raise ValueError("The input for this function must be of type: list or str.")


def get_image_information():
    """get information about docker images, and their tags"""
    image_dict = defaultdict(list)

    docker_images_command = "docker images --format {{.Repository}}:{{.Tag}}"
    docker_images_output = command(docker_images_command).split('\n')[:-1]
    docker_images_output = list(map(lambda line: line.split(':'), docker_images_output))

    for image, tag in docker_images_output:
        image_dict[image].append(tag)

    return image_dict
