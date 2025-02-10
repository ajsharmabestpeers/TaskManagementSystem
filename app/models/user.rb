class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    # enum role: { admin: 0, project_manager: 1, team_member: 2 }
    # after_initialize :set_default_role, if: :new_record?

    has_many :projects
    has_many :tasks
    # has_many :tasks, through: :projects

    enum role: %i[admin project_manager team_member]
    def admin?
      role == 'admin'
    end
  
    def project_manager?
      role == 'project_manager'
    end
    
    after_initialize :set_default_role, if: :new_record?
  
    private 
    
    def set_default_role
      self.role ||= :admin
    end
    
end
