#! /bin/sh

sudo su

for module in vfio_pci uio_pci_generic nvme-tcp; do
    filename="/etc/modules-load.d/$module.conf"

    if [ ! -f $filename ]; then
        echo "Adding module $module"
        echo $module > $filename

        modprobe $module
    fi
done

if grep "vm.nr_hugepages=1024" /etc/sysctl.conf; then 
    echo "Already has the hugepages setup";
else
    echo "Setting up hugepages"
    echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
    echo "vm.nr_hugepages=1024" >> /etc/sysctl.conf
fi
