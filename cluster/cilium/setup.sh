#! /bin/sh

if sudo firewall-cmd  --info-service=cilium ; then
    echo "Already have Cilium firewall rules setup"
else
    echo "Setting up Cilium firewall rules"
    
    sudo firewall-cmd --permanent --new-service=cilium
    sudo firewall-cmd --permanent --service=cilium --set-description="Cilium Firewall Rules"  

    sudo firewall-cmd --permanent --service=cilium --add-port=4240/tcp # cluster health checks (cilium-health)
    sudo firewall-cmd --permanent --service=cilium --add-port=4244/tcp # Hubble server
    sudo firewall-cmd --permanent --service=cilium --add-port=4245/tcp # Hubble Relay
    sudo firewall-cmd --permanent --service=cilium --add-port=4250/tcp # Mutual Authentication port
    sudo firewall-cmd --permanent --service=cilium --add-port=4251/tcp # Spire Agent health check port (listening on 127.0.0.1 or ::1)
    sudo firewall-cmd --permanent --service=cilium --add-port=6060/tcp # cilium-agent pprof server (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=6061/tcp # cilium-operator pprof server (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=6062/tcp # Hubble Relay pprof server (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9878/tcp # cilium-envoy health listener (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9879/tcp # cilium-agent health status API (listening on 127.0.0.1 and/or ::1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9890/tcp # cilium-agent gops server (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9891/tcp # operator gops server (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9893/tcp # Hubble Relay gops server (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9901/tcp # cilium-envoy Admin API (listening on 127.0.0.1)
    sudo firewall-cmd --permanent --service=cilium --add-port=9962/tcp # cilium-agent Prometheus metrics
    sudo firewall-cmd --permanent --service=cilium --add-port=9963/tcp # cilium-operator Prometheus metrics
    sudo firewall-cmd --permanent --service=cilium --add-port=9964/tcp # cilium-envoy Prometheus metrics
    #sudo firewall-cmd --permanent --service=cilium --add-port=51871/udp # WireGuard encryption tunnel endpoint

    sudo firewall-cmd --permanent --add-service=cilium

    sudo firewall-cmd --reload
fi
