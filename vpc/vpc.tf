variable "vpc_name"{}
#variable "main_vpc_cidr"{}
variable "public_subnets" {}
 variable "private_subnets" {}
 variable "internet_gateway_name"{}
 variable "publicsubnetname"{}
 variable "privatesubnetname"{}
 variable "publicroutetablename"{}
 variable "privateroutetablename"{}
 #variable "publicroutetableassosciation"{}
 #variable "privateroutetableassosciation"{}
 variable "natgatewayname"{}
 variable "eip_name"{}

 resource "aws_vpc" "Main" {               
   cidr_block       =    "10.0.0.0/24"
   instance_tenancy = "default"
   tags={
              Name=var.vpc_name
   }
 }

 resource "aws_internet_gateway" "IGW" {    
    vpc_id =  aws_vpc.Main.id   
    tags={
        Name=var.internet_gateway_name
    }            
 }
 
 resource "aws_subnet" "publicsubnets" {    
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.public_subnets}"
   tags={
    Name=var.publicsubnetname
   }      
 }
                 
 resource "aws_subnet" "privatesubnets" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.private_subnets}"
   tags={
    Name=var.privatesubnetname
   }          
 }

 resource "aws_route_table" "PublicRT" {   
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"               
    gateway_id = aws_internet_gateway.IGW.id
     }
     tags={
        Name=var.publicroutetablename
     }
 }
 
 resource "aws_route_table" "PrivateRT" {   
   vpc_id = aws_vpc.Main.id
   route {
   cidr_block = "0.0.0.0/0"            
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
   tags={
    Name=var.privateroutetablename
   }
 }
 
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnets.id
    route_table_id = aws_route_table.PublicRT.id
 }

 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnets.id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
   tags={
    Name=var.eip_name
   }
 }
 
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets.id
   tags={
    Name=var.natgatewayname
   }
 }