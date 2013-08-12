#
# Cookbook Name:: users
# Recipe:: vagrant
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
template "/home/vagrant/.bash_aliases" do
  source "dotbash_aliases.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

template "/home/vagrant/.bashrc" do
  source "dotbashrc.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
  variables(:color => "CLR_BYELLOW")
end
