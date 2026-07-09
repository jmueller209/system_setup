#!/bin/bash

# Configuration
CONTAINER_NAME="dev-test-env"
USER_NAME="tester"
LOCAL_SCRIPT_DIR="$HOME/Nextcloud/scripts"

echo "1. Spinning up fresh container: $CONTAINER_NAME"
# Using --rm means the container will vanish the moment you stop it
podman run -dt --rm --name "$CONTAINER_NAME" fedora:latest /bin/bash

echo "2. Installing sudo and creating user: $USER_NAME"
podman exec "$CONTAINER_NAME" dnf install -y sudo
podman exec "$CONTAINER_NAME" useradd -m -G wheel "$USER_NAME"
podman exec "$CONTAINER_NAME" passwd -d "$USER_NAME"

echo "3. Copying your folder into the container"
podman cp "$LOCAL_SCRIPT_DIR" "$CONTAINER_NAME:/home/$USER_NAME/scripts"
podman exec "$CONTAINER_NAME" chown -R "$USER_NAME":"$USER_NAME" "/home/$USER_NAME/scripts"

echo "----------------------------------------------------"
echo "Success! Your lab is ready."
echo ""
echo "To jump into the lab, run:"
echo "podman exec -it -u $USER_NAME $CONTAINER_NAME /bin/bash -l"
echo ""
echo "When you are finished with your tests, run:"
echo "podman stop $CONTAINER_NAME"
echo "----------------------------------------------------"
