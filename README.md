## Create EKS cluster
1. The terraform code under the folder: ***terraform-eks***
2. Use Terraform version ***0.12***
3. The cluster has: 1 vpc module, 1 subnets module, 1 network_loadbalancer, 1 eks_cluster, 1 eks_cluster and 1 route53 module
4. Must update the Domain information for Route53 records
5. Must update the backend
6. Must provide the ACM certificate if enable TLS on Loadbalancer
7. The basic variables can be updated on the tfvars file
8. For more variables can be found in the vars file or in the source module
9. The source modules can be found in the public github repo: https://github.com/Greg215/terraform-aws-eks
10. Run init to init the whole cluster: ***terraform init***
11. To apply it: ***terraform apply***
12. To destroy it: ***terraform destroy***

       
## Install Helm operator
1. The code under folder: ***helm-operator***
2. It will create a new namespace: ***helm***
3. It will create a deployment to apply ***fluxcd helm-operator***
4. It will create the customresource, rbac relate resources
5. To apply the deployment run: ***kubectl apply -f helm-operator-deployment.yaml***
6. To apply the customresource run: ***kubectl apply -f helm-customresource.yaml***
6. To apply the rbac run: ***kubectl apply -f helm-rbac.yaml***

       
## Install Nginx Operator for Ingress
1. The code under folder: ***ingress-operator***
2. It will create a new namespace for ingress
3. It will deploy the ingress by using helm chart via ***fluxcd***
4. To apply it run: ***kubectl apply -f nginx-operator.yaml***

     
## Install Wordpress with bitnami helm chart
1. The helm chart from bitnami can be found here: https://github.com/bitnami/charts/tree/master/bitnami/wordpress/#installing-the-chart
2. The values.yaml file can be found in the folder: ***wordpress***
3. Create a new namespace for wordpress: ***kubectl create namespace wordpress***
4. The full values file config can be found: https://github.com/bitnami/charts/blob/master/bitnami/wordpress/values.yaml
5. Add wordpress chart repo: ***helm repo add bitnami https://charts.bitnami.com/bitnami***
6. Enable the ingress on the values file and update the hostname.
7. Update the storage class as gp2 on aws on values file .
8. Enable the metrics on values file for the monitoring purposes.
9. Install the helm chart: ***helm install -f values.yaml greg-wordpress bitnami/wordpress -n wordpress***
10. For the backup and recovery purposes, can use the external database

       
## Install Prometheus and Grafana with helm chart
1. The values file can be found under folder: ***monitoring***
2. The helm chart for prometheus can be found: https://github.com/prometheus-community/helm-charts
3. To add the prometheus chart to the repo: ***helm repo add prometheus-community https://prometheus-community.github.io/helm-charts***
4. The full values file for prometheus can be found: https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml
5. The helm chart for the grafana can be found: https://github.com/grafana/helm-charts
6. To add the grafana chart to the repo: ***helm repo add grafana https://grafana.github.io/helm-charts***
7. The full values for the grafana can be found: https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml
8. Create a new namespace for monitoring: ***kubectl create namespace monitoring***
9. To install prometheus: ***helm install -f prometheus-value.yaml greg-prometheus prometheus-community/prometheus -n monitoring***
10. To install grafana: ***helm install -f grafana-value.yaml greg-grafana grafana/grafana -n monitoring***
11. To upgrade: ***helm upgrade -f prometheus-value.yaml prometheus prometheus-community/prometheus -n monitoring***
12: To uninstall: ***helm uninstall prometheus prometheus-community/prometheus -n monitoring***
13. For grafana login ***username: admin, pwd: grafana***

     
## The screen shots
1. The folder screen-shot list all the screen shot of the deployment I have done for the tasks.
2. The ***namespace-list.png*** is the namespaces that will be created during the deployment
3. The ***all-pods-list.png*** is the all the pods that will be created in the end
4. The ***wordpress-page.png*** is the inital page of wordpress when it been launched.
5. The ***grafana-dashboard.png*** is the grafana dashboard that can be created for the monitoring purposes.
6. The ***pod-cpu.png*** is the panel for the wordpress pod cpu status.
7. The ***pod-memory.png*** is the panel for the workpress pod memory status.
8. The ***datasource-config.png*** is the config for adding prometheus datasource which using internal k8s dns.