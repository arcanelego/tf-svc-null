terraform {
  backend "http" {
    address        = "http://localhost:1323/state/svc_null"
    lock_address   = "http://localhost:1323/state/svc_null/lock"
    unlock_address = "http://localhost:1323/state/svc_null/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}


resource "stateful_map" "my_resource" {
  // The "count" meta-parameter is used to address destroy provisioner limitation
  // See https://www.terraform.io/docs/provisioners/index.html#destroy-time-provisioners for details
  // For the sake for usage example we read value from file, in real world set it explicitely
  # count = trimspace(file("count"))

  desired = {
    foo = "barbas"
    bar = "barbas"
    baz = "barbas"
    bro = "barbas"

  }
  real = {
    foo = "bar"
    bar = "bar"
    baz = "bar"
    bro = "bar"
  }

}

module "nullish" {
  # source    = "./modules/null"
    source    = "git::http://gitea.ht.thetaylortorium.com/mt/tf_module_null.git"

  null_name = null_resource.test.id
}

module "nullish2" {
  # source    = "./modules/null"
    source    = "git::http://gitea.ht.thetaylortorium.com/mt/tf_module_null.git"

  null_name = null_resource.test.id
}


module "nullish3" {
  source    = "git::http://gitea.ht.thetaylortorium.com/mt/tf_module_null.git"
  null_name = null_resource.test.id
}


resource "null_resource" "test" {
  # id = "aksjdasd"
  # triggers = {
  #   cluster_instance_ids = null_resource.test3.id
  # }

}


resource "null_resource" "test2" {

}

resource "null_resource" "test3333" {
  for_each = toset(["asdasdas", "asdfvdsfgsd", "fsdfgklj"])

}


resource "null_resource" "test4" {

  triggers = {
    cluster_instance_ids = module.nullish.null_resource
  }

}

# resource "null_resource" "test5" {
#       provisioner "local-exec" {
#     command = "sleep 15"
#   }
# }


# resource "null_resource" "test25" {
#     #  depends_on = [null_resource.test31]   
#   provisioner "local-exec" {
#     command = "sleep 20"
#   }
# }

resource "null_resource" "test31" {


  provisioner "local-exec" {
    command = "sleep 10"
  }
  depends_on = [null_resource.test4]
}


resource "null_resource" "test41" {

  depends_on = [null_resource.test31]
}

resource "null_resource" "test51" {

  depends_on = [null_resource.test31]
}


resource "null_resource" "test251" {

}


