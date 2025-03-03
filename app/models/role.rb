class Role < ApplicationRecord
  ROLES = [
    "active",
    "admin",
  ]

  has_and_belongs_to_many :parents, join_table: :parents_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify
end
