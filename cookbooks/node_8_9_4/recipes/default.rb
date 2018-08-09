#
# Cookbook Name:: node_8_9_4
# Recipe:: default
#
ey_cloud_report "custom node ebuild install" do
  message "Installing custom node ebuild"
end

version = "8.9.4"

ebuild_file = "/engineyard/portage/engineyard/net-libs/nodejs-bin/nodejs-bin-#{version}.ebuild"

remote_file ebuild_file do
  source "nodejs-bin-generic.ebuild"
  backup 0
  mode 0644
end
execute "ebuild-nodejs" do
  cwd "/engineyard/portage/engineyard/net-libs/nodejs-bin/"
  command "ebuild #{File.basename(ebuild_file)} manifest"
end
execute "eix-sync" do
  command "eix-sync"
end
ey_cloud_report "emerge custom nodejs-bin-#{version}" do
  message "emerge custom nodejs-bin-#{version}"
end
execute "install nodejs-bin-#{version}" do
  command "emerge -g -n --color n --nospinner =net-libs/nodejs-bin-#{version}"
end
ey_cloud_report "eselect custom nodejs-bin-#{version}" do
  message "eselect custom nodejs-bin-#{version}"
end
execute "eselect nodejs-bin-#{version}" do
  command "eselect nodejs set #{version}"
end

link '/opt/nodejs/current' do
  to "/opt/nodejs/#{version}"
end

link "/opt/nodejs/#{version}/bin/npm" do
  to "/opt/nodejs/#{version}/lib/node_modules/npm/bin/npm-cli.js"
end
