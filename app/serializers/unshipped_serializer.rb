class UnshippedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :potential_revenue
  set_type :unshsipped_order
end
