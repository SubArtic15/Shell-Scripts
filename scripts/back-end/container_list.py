"""
:summary abstraction to a better version of 'docker containers ls --format...'
:project Shell Script (2020)
"""
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


def container_ip(cname):
    """given the container name, get the ip address"""
    raw_container_ip_command = ["docker", "inspect", "--format",
                                "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}",
                                cname]
    raw_container_ip_output = command(raw_container_ip_command).split('\n')[0]
    return raw_container_ip_output



if __name__ == '__main__':
    # run the following command and record it's output
    # ~$ docker container ls --format {{.Image}}\t{{.ID}}\t{{.Names}}\t{{.Labels}}
    container_ls_output = ["docker", "container", "ls", "--format",
                           "{{.Image}}\t{{.ID}}\t{{.Names}}\t{{.Labels}}"]
    container_list_information = command(container_ls_output).split('\n')

    # split output into a 2D array containing the: IMAGE:TAG, CONTAINER_ID,
    #                                              and CONTAINER_NAME
    container_matrix = list(map(lambda container_info: container_info.split('\t')[:-1],
                                container_list_information))[:-1]

    # given the name of a container, get the IP address; do this for each container
    for c1 in container_matrix:
        c1.append(container_ip(c1[-1]))

    # calculate extra spaces
    extra_spaces = max(list(map(lambda container_info: len(container_info[2]),
                                container_matrix)))

    # display the data
    print("IMAGE\t\tCONTAINER ID\t\tNAME{}IP".format(' ' * (extra_spaces - 1)))
    for container_info in container_matrix:
        container_image, container_id, container_name, container_ip = container_info

        container_space = ' ' * (extra_spaces - len(container_image))
        name_space = ' ' * (extra_spaces - len(container_name))

        print(f"{container_image}{container_space}", end='\t')
        print(f"{container_id}", end='\t'*2)
        print(f"{container_name}{name_space}", end="   ")
        print(container_ip)
