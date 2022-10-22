machines = {
  "lab-env-qt" => {"memory" => "2048", "cpu" => "2", "ip" => "81", "image" => "bento/ubuntu-20.04"}
}

Vagrant.configure("2") do |config|

    machines.each do |name, conf|
        
        config.vm.define "#{name}" do |machine|
            machine.vm.box = "#{conf["image"]}"
            machine.vm.hostname = "#{name}.lab.k8s.io"
            machine.vm.network "private_network", ip: "192.168.50.#{conf["ip"]}"

            machine.vm.provision "shell" do |s|
                ssh_pub_key = File.readlines("keys/vagrant.pub").first.strip
                s.inline = <<-SHELL
                echo "Ambiente para laboratório: Harbor" > /tmp/vagrant.txt
                echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
                echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
            SHELL
            end

            machine.vm.provider "virtualbox" do |vb|
                vb.name = "#{name}"
                vb.memory = conf["memory"]
                vb.cpus = conf["cpu"]
            end
            # machine.vm.provision "shell", path: "setup.sh" 
        end
    end
end