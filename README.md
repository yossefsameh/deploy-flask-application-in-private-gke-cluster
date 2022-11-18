#   using terraform to build infrastructure in GCP
###  Terraform Environment
####         1- firstly you have to create your own project on Google Cloud Platform
         
          
####         2- create directory in your local machine and add file called (provider.tf) to mention project id and region on Google

         
####         3- in terminal write this command
                    
                    terraform init
                   
                  
![Screenshot 2022-11-18 151417 width="150"](https://user-images.githubusercontent.com/43928828/202713711-1f938d00-36b7-4540-beb6-d19bc3ffc59d.png )

###  infrastructure

####         1- create vpc with allow ssh and http ingress firewall                              
          
          
####         2- create 2 subnets (management and restricted)  
######                     enable private_ip_google_access to be able to access google APIs
          
          
####         3- apply nat to management subnet                                        
         
           
####         4- create 2 service accounts (with container.admin and storage.admin roles)
          
          
####        5- create private instance in management subnet with service account


####         6- create standard gke with service account acceced only by managment subnet CIDR


####         7- write this command 
                   terraform apply 
        

###  connect to cluster from instance and deploy application


####          1- ssh to my private instance     
 
                    
####          2- install kubectl    
![Screenshot 2022-11-15 135115 width="150"](https://user-images.githubusercontent.com/43928828/202166287-443b590e-e759-41d6-91a2-4fd6367fc7a1.png)     
          
          
####          3- (optional) use gcloud init to choose my vm service account (which already chosen by terraform) 
 ![Screenshot 2022-11-15 134639 width="150"](https://user-images.githubusercontent.com/43928828/202166463-56422e5a-3e53-48ef-a704-74270c3d10fc.png)

          
          
####          4- connect to cluster  from instance
 ![Screenshot 2022-11-16 161924 width="150"](https://user-images.githubusercontent.com/43928828/202240797-9c42c97a-40f5-429c-b934-91ab14ebcf2c.png)
 
          
####          5- check pods    
 ![Screenshot 2022-11-15 135523 width="150"](https://user-images.githubusercontent.com/43928828/202166509-59cfb445-7795-4e4d-afd3-830b5a6ea330.png)
 
 
 ####         6- install docker and git 
 
 
 ####         7- git clone our application then dockerize it
 ![Screenshot 2022-11-18 160916 width="50"](https://user-images.githubusercontent.com/43928828/202723908-1909d19b-3142-4132-b5b8-bb857bc4649c.png)


####          8- build application image
                       docker build -t img-name .
                     
                     
####          9- change tag of image to push it to GCR (this is registry to store docker images locally in GCP project)
                       docker tag img-name gcr.io/project-id/img-name:tag

####          10- run this command
                       gcloud auth configure-docker


####          10- push image to GCR
                       docker push gcr.io/project-id/img-name:tag
                       
####          11- pull redis image from dockerhub then change tag 
                        docker pull redis 
                        docker tag gcr.io/project-id/redis:tag
                        
                        
####          12- push redis image to GCR
![Screenshot 2022-11-17 231735](https://user-images.githubusercontent.com/43928828/202727053-20910a44-f743-41be-a89b-b6b6f4c308df.png)
![Screenshot 2022-11-18 054247](https://user-images.githubusercontent.com/43928828/202733051-3badbfbf-cc1e-4588-904e-5d27c39a6f63.png)



####          13- create declarative (.yml file) to create deployment with application image pulled from GCR and Loadbalancer service 
![Screenshot 2022-11-18 163443](https://user-images.githubusercontent.com/43928828/202729225-a3be9485-5226-4b26-b913-048889030fc5.png)


####          14- create declarative (.yml file) to create deployment with redis image pulled from GCR and ClusterIp service       
![Screenshot 2022-11-18 163632](https://user-images.githubusercontent.com/43928828/202729632-ae1a0bbe-4aa0-4f93-a5fc-2931303f554a.png)


####          15- apply 
                     kubectl apply -f redis.yml
                     kubectl apply -f app.yml


####          16- when container is created go to LoadBalancer url you will see your web app
![WhatsApp Image 2022-11-18 at 5 20 28 AM](https://user-images.githubusercontent.com/43928828/202732084-d6d97b89-4c35-4506-ac27-aadbb9c70c26.jpeg)

