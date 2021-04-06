"""
:summary abstraction to a better version of 'docker container stop [CONTAINER_NAME]'
:project Shell Script (2020)
"""
from os import system
from argparse import ArgumentParser

from termcolor import colored

from container_library import command





if __name__ == '__main__':
    # get names of all running containers my running the below command
    # and logging the results
    container_name_command = "docker container ls --format {{.Names}}"
    container_name_information = command(container_name_command).split('\n')[:-1]

    # set up and parse command line arguments
    parser = ArgumentParser()
    parser.add_argument('-c', '--count', dest='num_containers',
                        type=int, default=999,
                        help='determines number of containers to create')
    parser.add_argument("-n", "--name", dest="name", default=None,
                        help="determines the name of a container to be stopped.")

    # abstract arguments out ot parser namespace
    args = parser.parse_args()
    num_containers = args.num_containers
    container_name = args.name

    # if the number arg is filled and the name arg is empty, then remove
    # the specified numbers of containers
    if num_containers > 0 and container_name is None:
        num_running_containers = len(container_name_information)
        lower_bound = min(num_containers, num_running_containers)
        for idx in range(lower_bound):
            container_name = container_name_information[idx]
            print("Stopping:", container_name)
            system(f"docker container stop {container_name}")

    # if the name args is fulled and the name args is empty, then remove
    # one container specified in --name
    elif args.name in container_name_information:
        print("stopping:", args.name)
        system(f"docker container stop {args.name}")

    # else, report an error
    else:
        error = colored("No containers have been stopped", "red")
        print(error)
