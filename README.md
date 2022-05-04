## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/jawadayache1999/Elk-Server/blob/main/Images/ElkNetwork.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

https://github.com/jawadayache1999/Elk-Server/blob/main/Ansible/filebeat-playbook-copy.yml

https://github.com/jawadayache1999/Elk-Server/blob/main/Ansible/metricbeat-playbook-copy.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly responsive, in addition to restricting access to the network.

Load balancers can be used to protect against DoS attacks because they analyze traffic and determine which server to send it to.
This allows for network redundancy by having the traffic distributed among available servers to protect against an overload of traffic.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.


Filebeat looks for changes in files and when the change occurred by looking at analyzing log files

Metricbeat records metrics from the OS as well as the services running on that particular server. Elasticsearch helps vizualize
the data that is generated from the OS and the services running


| Name       | Function   | IP Address | Operating System |
|------------|------------|------------|------------------|
| JumpBox    | Gateway    | 10.0.0.4   | Linux            |
| Web-1      | Webserver  | 10.0.0.6   | Linux            |
| Web-2      | Webserver  | 10.0.0.7   | Linux            |
| ELK-Server | ELK Server | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the JumpBoxProvisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
100.36.149.103

Machines within the network can only be accessed by JumpBoxProvisioner.

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible  | Allowed IP Address |
|---------------|----------------------|--------------------|
| JumpBox       | Yes                  | 100.36.149.103     |
| Web-1         | No                   | 10.0.0.4           |
| Web-2         | No                   | 10.0.0.4           |
| ELK-Server    | Yes (Port 5601)      | 100.36.149.103     |
| Load Balancer | Yes (Port 80)        | 100.36.149.103     |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it provides
a more streamlined process when installing and configuring multiple services

The playbook implements the following tasks:
The first module of the playbook installs docker.io on the ELK VM
The next task is to install python on the virtual machine
ELK requires a lot of memory so the next step is to increase the virtual memory to 262144
The next step is to install and execute the docker elk container on system boot up so the docker does not have to be manually started


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://github.com/jawadayache1999/Elk-Server/blob/main/Images/docker_ps_output.png


### Target Machines & Beats
This ELK server is configured to monitor the following machines: Web-1 (10.0.0.6), Web-2 (10.0.0.7)

We have installed the following Beats on these machines: Metricbeat and Filebeat

These Beats allow us to collect the following information from each machine:

Filebeat collects log information about the file system and specifies which files have been changed and when to Elasticsearch or Logstash. To vizualize the output from filebeat you would have to go to the Kibana GUI and from there you are able to filter results by container, beat, argument, etc.

Metricbeat shows statistics for the processes running on the system. These include memory, CPU usage, file system, Network/Disk IO, etc.


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to /etc/ansible/files/filebeat-config.yml.
- Update the filebeat-config.yml file to include host "10.1.0.4:9200" with the username being 'elastic' and the password set to 'changeme'.
As well as setup.kibana host to "10.1.0.4:5601". In line 3 of the playbook files a host parameter is included to specifiy which machines to install
specific dockers and packages on. For example, the install-elk playbook file only applies the commands to machines listed under the [elk] group in the
ansible hosts file. Metricbeat/filebeat playbook files have the host parameter as [webservers] to apply the commands to the Web-1 and Web-2 Virtual Machines
- Run the playbook, and navigate to Kibana to check that the installation worked as expected.

http://52.140.213.230:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

Download and Update Configuration file:

curl https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat > /etc/ansible/metricbeat-config.yml

Create/Update playbook file:

nano metricbeat-playbook.yml

To run the playbook file:

ansible-playbook metricbeat-playbook.yml

