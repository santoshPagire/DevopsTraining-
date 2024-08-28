Here's the updated README file with the additional Docker repository setup commands included after point 5:

---

# Kubernetes Cluster Setup Guide

## 1. Prepare the Nodes

### Log in to Control Node
- Ensure you have access to the control plane node.
![alt text](<images/Screenshot from 2024-08-28 22-16-53.png>)

### Install Packages on All Nodes (Control Plane and Workers)

1. **Log in to the control plane node.**

2. **Create the Configuration File for containerd:**

    ```bash
    cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
    overlay
    br_netfilter
    EOF
    ```

3. **Load the Modules:**

    ```bash
    sudo modprobe overlay
    sudo modprobe br_netfilter
    ```
    [alt text](<images/Screenshot from 2024-08-28 22-31-09.png>)

4. **Set the System Configurations for Kubernetes Networking:**

    ```bash
    cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
    net.bridge.bridge-nf-call-iptables = 1
    net.ipv4.ip_forward = 1
    net.bridge.bridge-nf-call-ip6tables = 1
    EOF
    ```

5. **Apply the New Settings:**

    ```bash
    sudo sysctl --system
    ```
![alt text](<images/Screenshot from 2024-08-28 22-37-36.png>)
6. **Add Docker Repository:**

    - **Add Docker's GPG Key:**

        ```bash
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        ```

    - **Add Docker Repository:**

        ```bash
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        ```
![alt text](<images/Screenshot from 2024-08-28 22-38-00.png>)
7. **Install containerd:**

    ```bash
    sudo apt-get update && sudo apt-get install -y containerd.io
    ```
![alt text](<images/Screenshot from 2024-08-28 22-38-25.png>)
8. **Create the Default Configuration File for containerd:**

    ```bash
    sudo mkdir -p /etc/containerd
    ```
![alt text](<images/Screenshot from 2024-08-28 22-39-31.png>)

9. **Generate the Default containerd Configuration and Save It:**

    ```bash
    sudo containerd config default | sudo tee /etc/containerd/config.toml
    ```

10. **Restart containerd:**

    ```bash
    sudo systemctl restart containerd
    ```

11. **Verify that containerd is Running:**

    ```bash
    sudo systemctl status containerd
    ```
![alt text](<images/Screenshot from 2024-08-28 22-41-05.png>)

12. **Disable Swap:**

    ```bash
    sudo swapoff -a
    ```

13. **Install Dependency Packages:**

    ```bash
    sudo apt-get update && sudo apt-get install -y apt-transport-https curl
    ```
![alt text](<images/Screenshot from 2024-08-28 22-41-20.png>)

14. **Download and Add the Kubernetes GPG Key:**

    ```bash
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    ```

15. **Add Kubernetes to the Repository List:**

    ```bash
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
    deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /
    EOF
    ```

16. **Update the Package Listings:**

    ```bash
    sudo apt-get update
    ```
![alt text](<images/Screenshot from 2024-08-28 22-41-37.png>)

17. **Install Kubernetes Packages:**

    ```bash
    sudo apt-get install -y kubelet kubeadm kubectl
    ```
    *Note: If you encounter a dpkg lock message, wait a minute or two and try again.*
    ![alt text](<images/Screenshot from 2024-08-28 22-41-57.png>)

18. **Turn Off Automatic Updates:**

    ```bash
    sudo apt-mark hold kubelet kubeadm kubectl
    ```
![alt text](<images/Screenshot from 2024-08-28 22-42-13.png>)
19. **Log in to Both Worker Nodes and Repeat the Above Steps.**

## 2. Initialize the Cluster

1. **On the Control Plane Node, Initialize the Kubernetes Cluster:**

    ```bash
    sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.27.11
    ```
    ![alt text](<images/Screenshot from 2024-08-28 22-50-54.png>)

2. **Set kubectl Access:**

    ```bash
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    ```
3. **Test Access to the Cluster:**

    ```bash
    kubectl get nodes
    ```
![alt text](<images/Screenshot from 2024-08-28 22-42-36.png>)
## 3. Install the Calico Network Add-On

1. **On the Control Plane Node, Install Calico Networking:**

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
    ```


2. **Check the Status of the Control Plane Node:**

    ```bash
    kubectl get nodes
    ```