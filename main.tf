
 module "vpc"{
    source="./vpc"
    #main_vpc_cidr=var.vpc_cidr
    private_subnets=var.private_subnets
    public_subnets=var.public_subnets
    vpc_name=var.vpc_name
    internet_gateway_name=var.internet_gateway_name
    publicsubnetname=var.publicsubnetname
    privatesubnetname=var.privatesubnetname
    publicroutetablename=var.publicroutetablename
    privateroutetablename=var.privateroutetablename
    #publicroutetableassosciation=var.publicroutetableassosciation
    #privateroutetableassosciation=var.privateroutetableassosciation
    natgatewayname=var.natgatewayname
    eip_name=var.eip_name
}

module "ec2"{
    source="./ec2"
}