class UnshippedSerializer
  include FastJsonapi::ObjectSerializer
  attributes :potential_revenue

  # set_type :unshipped_order

end
