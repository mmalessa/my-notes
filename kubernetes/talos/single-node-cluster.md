# Instalacja Talos na PC (single-node cluster)
Uwage - zajmie cały dostępny dysk fizyczny!

## Boot z obrazu iso
Po zbotowaniu - wyjąć USB

## Przygotowania
```
export CONTROL_PLANE_IP=x.x.x.x    # adres maszyny wyczytany z ekranu Talos ISO
export CLUSTER_NAME=mycluster            # dowolna nazwa klastra
```

Szukamy dysku, na którym chcemy zainstalować Talos
```
talosctl get disks --insecure --nodes $CONTROL_PLANE_IP

export DISK_NAME=sda
```

## Generowanie configów
```
talosctl gen config $CLUSTER_NAME https://$CONTROL_PLANE_IP:6443 --install-disk /dev/$DISK_NAME
```

## Ustawienie talosconfig
```
# export TALOSCONFIG=./talosconfig
# lub lepiej (dopisuje do ~/.talos/config)
talosctl config merge ./talosconfig
```

## Wgrywanie konfiguracji control plane na maszynę (pierwsze - insecure)
```
talosctl apply-config --insecure --nodes $CONTROL_PLANE_IP --file controlplane.yaml
```
Nastąpi automatyczny restart talos

## Ustawienie endpoints 
```
talosctl config endpoints $CONTROL_PLANE_IP
```


## Bootstrap - uruchomienie clustra i pobranie kubeconfig
```
talosctl bootstrap --nodes $CONTROL_PLANE_IP
```

sprawdzenie czy cluster jest zbootstrappowany
```
talosctl --nodes $CONTROL_PLANE_IP get members
talosctl --nodes $CONTROL_PLANE_IP service
```
apid powinno być w stanie Running


Generowanie kubeconfig
```
talosctl kubeconfig --nodes $CONTROL_PLANE_IP
```
powinno dopisać do ~/.kube/config

sprawdzić, np:
```
kubectx
```

## Złagodzenie PodSecurity dla namespace default

Tylko w środowisku dev!
```
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# nie wiem czy to jest potrzebne
kubectl label namespace default pod-security.kubernetes.io/enforce=privileged --overwrite
```
