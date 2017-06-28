ActiveAdmin.register Followership do
  includes :follower, :followed

  permit_params :follower, :followed
end
