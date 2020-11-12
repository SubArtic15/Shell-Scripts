"""
:summary abstraction to a better version of 'docker container stop [CONTAINER_NAME]'
:project Shell Script (2020)
"""
from argparse import ArgumentParser
from subprocess import check_output



def command(cmd_to_run):
    """run linux terminal command and capture output"""
    if isinstance(cmd_to_run, list):
        final_command = cmd_to_run
    elif isinstance(cmd_to_run, str):
        final_command = cmd_to_run.split(' ')
    else:
        raise ValueError("The input for function :: command must be a [list, str]")
    return check_output(final_command).decode()


if __name__ == '__main__':
    # run the following command and record it's output
    # ~$ docker container ls --format {{.Names}}
    container_name_command = ["docker", "container", "ls", "--format", "{{.Names}}"]
    container_name_information = command(container_name_command).split('\n')[:-1]

    parser = ArgumentParser()
    parser.add_argument("--name", action="store", dest="name", type=str, default=None,
                        help="determines the name of a container to be stopped.")
    parser.add_argument("--num", "--number", action="store", dest="num_containers",
                        type=int, default=0,
                        help="determines the number of containers to be stopped.")

    args = parser.parse_args()

    # if the number arg is filled and the name arg is empty, then remove
    # --num_containers worth of containers
    if args.num_containers > 0 and args.name is None:
        for idx in range(min(args.num_containers, len(container_name_information))):
            print("stopping:", container_name_information[idx])
            command(f"docker container stop {container_name_information[idx]}")

    # if the name args is fulled and the name args is empty, then remove
    # one container specified in --name
    elif args.num_containers == 0 and args.name in container_name_information:
        print("stopping:", args.name)
        command(f"docker container stop {args.name}")

    # else, report an error
    else:
        print("\033[1;31mNo containers have been stopped\033[0m")
