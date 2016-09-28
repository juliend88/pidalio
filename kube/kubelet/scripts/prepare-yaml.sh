#!/usr/bin/env bash
rm -f /etc/kubernetes/descriptors/*
cp /opt/pidalio/kube/kubelet/descriptors/* /etc/kubernetes/descriptors
for file in $(ls /etc/kubernetes/descriptors/*.yaml)
do
    sed -i s/\\\$domain\\\$/${DOMAIN}/g ${file}
done
cat <<EOF > /etc/kubernetes/descriptors/0-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: openstack
type: Opaque
data:
  password: $(echo -n '$OS_PASSWORD' | base64)
  username: $(echo -n '$OS_USERNAME' | base64)
EOF
