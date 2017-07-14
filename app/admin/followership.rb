ActiveAdmin.register Followership do
  includes :follower, :followed

  permit_params :follower_id, :followed_id
end
