locals {
    public_subnet = {
        for idx, az in var.azs : 
        az => var.public_subnet_cidrs[idx]
    }

    private_subnet = {
        for idx, az in var.azs : 
        az => var.private_subnet_cidrs[idx]
    }

    database_subnet = {
        for idx, az in var.azs : 
        az => var.database_subnet_cidrs[idx]
    }

}
