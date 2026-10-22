VMNAME=$1
if [ -z "$1" ]
then
    echo "Missing virtual-machine-name in arguments"
    exit 1
fi

# 1. Rebuild the updated image
container build -t local/ubuntu-vscode:24.04 .

# 2. Force remove the old instance
container machine rm $VMNAME -f

# 3. Create the machine WITH --privileged permissions
container machine create local/ubuntu-vscode:24.04 --name $VMNAME --privileged

# 4. Set resources and start it up
container machine set -n $VMNAME cpus=4 memory=16G
container machine start $VMNAME
