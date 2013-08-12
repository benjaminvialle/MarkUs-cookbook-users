#
# Cookbook Name:: users
# Recipe:: markus
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "users::default"

markus_group = Array.new

search(:users, 'groups:markus') do |u|
  markus_group << u['id']

  home_dir = "/home/#{u['id']}"

  user u['id'] do
    uid u['uid']
    gid u['gid']
    shell u['shell']
    password u['password']
    comment u['comment']
    supports :manage_home => true
    home home_dir
  end

  directory "#{home_dir}/.ssh" do
    owner u['id']
    group u['gid'] || u['id']
    mode "0700"
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner u['id']
    group u['gid'] || u['id']
    mode "0600"
    variables :ssh_keys => u['ssh_keys']
  end

  template "#{home_dir}/.bash_aliases" do
    source "dotbash_aliases.erb"
    owner u['id']
    group u['gid'] || u['id']
    mode "0644"
  end

  template "#{home_dir}/.bashrc" do
    source "dotbashrc.erb"
    owner u['id']
    group u['gid'] || u['id']
    mode "0644"
    variables(:color => "CLR_BBLUE")
  end
end
