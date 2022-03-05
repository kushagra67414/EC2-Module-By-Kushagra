variable "vpc_id" {
    type = string
    description = "VPC ID"
    default = null
}


// ---------------------------------------- //
/* -- Variables Related to EC2 Instances -- */
// --------------------------------------- //

variable "key_name" {
    type = string
    description = "Key Pair Name"
    default = "ec2key"
}

variable "sg_name" {
    type = string
    description = "Security Group Name"
    default = "ec2sg"
}

variable "sg_ingress" {
    type = map(object({
        description = string
        from_port = number
        to_port = number
        protocol = string
        self = bool
        cidr_blocks = list(string)
        ipv6_cidr_blocks = list(string)
        security_groups = list(string)
    }))
    description = "SG Ingress Rule Details"
    default = {
        rule1 = {
            description = "SSH Port"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            self = true
            cidr_blocks = []
            ipv6_cidr_blocks = []
            security_groups = []
        }
    }
}

variable "sg_egress" {
    type = map(object({
        description = string
        from_port = number
        to_port = number
        protocol = string
        self = bool
        cidr_blocks = list(string)
        ipv6_cidr_blocks = list(string)
        security_groups = list(string)
    }))
    description = "SG Egress Rule Details"
    default = {
        rule1 = {
            description = "Anywhere"
            from_port = 0
            to_port = 0
            protocol = -1
            self = false
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            security_groups = []
        }
    }
}

variable "ami_id" {
    type = string
    description = "AMI ID for Instance"
}

variable "inst_type" {
    type = string
    description = "Instance Type"
    default = "t2.micro"
}

variable "instance_termination_protection" {
    type = bool
    description = "Enable/Disable Instance Termination Protection"
    default = false
}


// ----------------------------------- //
/* -- Variables Related to IAM Role -- */
// ---------------------------------- //

variable "user_data" {
    type = string
    description = "User Data for Instance"
}

variable "role_name" {
    type = string
    description = "Name of EC2 Role"
    default = "EC2Role"
}

variable "managed_policy_arns" {
    type = list(string)
    description = "Managed Policy ARNs to Attach with EC2 Role"
    default = []
}

variable "ec2_role_policy" {
    type = string
    description = "Inline Policy for the EC2 Role"
}
