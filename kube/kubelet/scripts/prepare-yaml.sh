#!/usr/bin/env bash
rm -Rf /etc/kubernetes/descriptors/*
cp -Rf /opt/pidalio/kube/kubelet/descriptors/* /etc/kubernetes/descriptors
for file in $(ls /etc/kubernetes/descriptors/dns/*.yaml /etc/kubernetes/descriptors/toolbox/*.yaml /etc/kubernetes/descriptors/ceph/*.yaml)
do
    sed -i s/\\\$stack_name\\\$/${STACK_NAME}/g ${file}
    sed -i s/\\\$token\\\$/${PIDALIO_TOKEN}/g ${file}
    sed -i s/\\\$domain\\\$/${DOMAIN}/g ${file}
    sed -i s/\\\$node_type\\\$/${NODE_TYPE}/g ${file}
    sed -i s/\\\$private_ipv4\\\$/${NODE_IP}/g ${file}
    sed -i s/\\\$public_ipv4\\\$/${NODE_PUBLIC_IP}/g ${file}
    sed -i s#\\\$CEPH_DISK_DEVICE\\\$#${CEPH_DISK_DEVICE}#g ${file}
done
