variable "ami_id" {
    type = string
    description = "AMI ID for Instance"
    default = "ami-02f58a2199a0637f3"
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
        rule2 = {
            description = "HTTP Port"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            self = false
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            security_groups = []
        }
    }
}

variable "user_data_filename" {
    type = string
    description = "Users Data File Path/Name"
    default = "files/user-data.sh"
}

variable "role_policy_filename" {
    type = string
    description = "Role Policy File Path/Name"
    default = "files/iam-role-policy.json"
}
