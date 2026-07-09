#!/bin/bash

CONTAINER_NAME="dev-test-env"
USER_NAME="tester"
LOCAL_SCRIPT_DIR="$HOME/Nextcloud/scripts"

echo "Spinning up fresh container: $CONTAINER_NAME"
podman run -dt --rm --name "$CONTAINER_NAME" fedora:latest /bin/bash

echo "Installing sudo and creating user: $USER_NAME"
podman exec "$CONTAINER_NAME" dnf install -y sudo
podman exec "$CONTAINER_NAME" useradd -m -G wheel "$USER_NAME"
podman exec "$CONTAINER_NAME" passwd -d "$USER_NAME"


echo "----------------------------------------------------"
echo "Success! Your lab is ready."
echo ""
echo "To jump into the lab, run:"
echo "podman exec -it -u $USER_NAME $CONTAINER_NAME /bin/bash -l"
echo ""
echo "When you are finished with your tests, run:"
echo "podman stop $CONTAINER_NAME"
echo "----------------------------------------------------"
