class AdminUser < Parent
  self.inheritance_column = :_type_disabled

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end

  before_destroy :raise_if_last
  def raise_if_last
    if AdminUser.count < 2
      raise "Can't delete last admin user"
    end
  end
end
