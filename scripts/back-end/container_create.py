"""
:summary abstraction to a better version of 'docker run --rm -dt [IMAGE]:[TAG]'
:project Shell Script (2020)
"""
from os import system
from argparse import ArgumentParser

from container_library import get_image_information





if __name__ == '__main__':
    # get metadata about docker images
    image_dict = get_image_information()
    images = list(image_dict.keys())
    image_tags = list(image_dict.values())

    # set up and parse command line arguments
    parser = ArgumentParser()
    parser.add_argument('-c', '--count', dest='num_containers',
                        type=int, default=1,
                        help='determines number of containers to create')
    parser.add_argument('-i', '--image', dest='image',
                        default="ubuntu",
                        help=f"Choose the image type from: {images}")
    parser.add_argument('-t', '--tag', dest='tag',
                        default="latest",
                        help=f"Choose the tag type from: {image_tags}")

    # abstract arguments out ot parser namespace
    args = parser.parse_args()
    num_containers = args.num_containers
    container_image = args.image
    container_tag = args.tag

    # check for validity in arguments
    if (container_image not in images) or (container_tag not in image_dict[container_image]):
        print("Invalid --image and/or --tag")

    # create some number of containers based off of the valididated parameters
    else:
        print(f"Creating (x{num_containers}) {container_image}:{container_tag} container(s)...")
        for _ in range(args.num_containers):
            system(f"docker run --rm -dt {args.image}:{args.tag}")
