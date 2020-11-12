"""
:summary abstraction to a better version of 'docker run --rm -dt [IMAGE]:[TAG]'
:project Shell Script (2020)
"""
from argparse import ArgumentParser
from collections import defaultdict
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
    docker_images_command = "docker images --format {{.Repository}}:{{.Tag}}"
    docker_images_output = command(docker_images_command).split('\n')[:-1]
    image_dict = defaultdict(list)
    for image_combo in docker_images_output:
        image, tag = image_combo.split(":")
        image_dict[image].append(tag)

    parser = ArgumentParser()
    parser.add_argument('-c', '--count', action='store', dest='num_containers', type=int,
                        default=1,
                        help='determines number of containers to create')
    parser.add_argument('-i', '--image', action='store', dest='image', type=str,
                        default="ubuntu",
                        help=f"Choose the image type from: {list(image_dict.keys())}")
    parser.add_argument('-t', '--tag', action='store', dest='tag', type=str,
                        default="latest",
                        help=f"Choose the tag type from: {list(image_dict.values())}")

    args = parser.parse_args()

    if not args.image in image_dict.keys() and not args.tag in image_dict[args.image]:
        print("Invalid --image and or --tag")
    else:
        print(f"Creating (x{args.num_containers}) {args.image}:{args.tag} container(s)...")
        for _ in range(args.num_containers):
            if args.image in image_dict.keys() and args.tag in image_dict[args.image]:
                command(f"docker run --rm -dt {args.image}:{args.tag}")
