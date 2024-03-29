variable "resource_group_name" {
    type = string
    description = "resource group name of the virtual network"
}
variable "location" {
    type = string
    description = "location of the virtual network"
}
variable "virtual_network_name" {
    type = string
    description = "name of the virtual network"
}
variable "virtual_network_address_space" {
    type = list(string)
    description = "address space of the virtual network"
}
variable "subnet_name" {
    type = string
    description = "name of the subnet"
}
variable "subnet_address_prefix" {
    type = list(string)
    description = "address prefix of the subnet"
}
variable "vmname" {
    type = string
    description = "name of the vm"
}
variable "vm_size" {
    type = string
    description = "size of the virtual machine"
}
variable "os_disk_type" {
    type = string
    description = "type of the os disk. example Standard_LRS"
}
variable "admin_usename" {
    type = string
    description = "local admin user of the virtual machine"
}
variable "admin_password" {
    type = string
    description = "password of the local admin user"
}
variable "image_publisher" {
    type = string
    description = "Azure image publisher"
    default = "MicrosoftWindowsServer"
}
variable "image_offer" {
    type = string
    description = "Azure image offer"
    default = "WindowsServer"
}
variable "image_sku" {
    type = string
    description = "Azure image sku"
    default = "2016-Datacenter"
}


# # additional unused variables
# variable "public_subnet_count" {
#   description = "Number of public subnets."
#   type        = number
#   default     = 2
# }

# variable "private_subnet_count" {
#   description = "Number of private subnets."
#   type        = number
#   default     = 2
# }

# variable "public_subnet_cidr_blocks" {
#   description = "Available cidr blocks for public subnets."
#   type        = list(string)
#   default     = [
#     "10.0.1.0/24",
#     "10.0.2.0/24",
#     "10.0.3.0/24",
#     "10.0.4.0/24",
#     "10.0.5.0/24",
#     "10.0.6.0/24",
#     "10.0.7.0/24",
#     "10.0.8.0/24",
#   ]
# }

# variable "private_subnet_cidr_blocks" {
#   description = "Available cidr blocks for private subnets."
#   type        = list(string)
#   default     = [
#     "10.0.101.0/24",
#     "10.0.102.0/24",
#     "10.0.103.0/24",
#     "10.0.104.0/24",
#     "10.0.105.0/24",
#     "10.0.106.0/24",
#     "10.0.107.0/24",
#     "10.0.108.0/24",
#   ]
# }

