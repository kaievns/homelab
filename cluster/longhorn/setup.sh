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

if sudo firewall-cmd  --info-service=longhorn ; then
    echo "Already have Longhorn firewall rules setup"
else
    echo "Setting up Longhorn firewall rules"
    
    sudo firewall-cmd --permanent --new-service=longhorn
    sudo firewall-cmd --permanent --service=longhorn --set-description="Longhorn Firewall Rules"  

    sudo firewall-cmd --permanent --service=longhorn --add-port=9500/tcp
    sudo firewall-cmd --permanent --service=longhorn --add-port=9501/tcp
    sudo firewall-cmd --permanent --service=longhorn --add-port=9502/tcp
    sudo firewall-cmd --permanent --service=longhorn --add-port=9503/tcp

    sudo firewall-cmd --permanent --add-service=longhorn

    sudo firewall-cmd --reload
fi
