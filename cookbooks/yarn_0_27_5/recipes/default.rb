#
# Cookbook Name:: yarn_0_27_5
# Recipe:: default
#
ey_cloud_report "custom yarn ebuild install" do
  message "Installing custom yarn ebuild"
end

root_path = "/engineyard/portage/engineyard/dev-util/yarn/"

directory root_path do
  action :create
  not_if { ::Dir.exists?(root_path) }
end

file_name = "yarn-0.27.5.ebuild"

ebuild_file = "#{root_path}#{file_name}"

cookbook_file ebuild_file do
  source file_name
  mode '0644'
end

execute "build manifest" do
  cwd "#{root_path}"
  command "ebuild yarn-0.27.5.ebuild manifest"
end

execute "eix-sync" do
  command "eix-sync"
end

execute "install yarn" do
  command "emerge yarn"
end

ey_cloud_report "yarn installed" do
  message "Yarn installed"
end
