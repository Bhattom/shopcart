class PostPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :record
    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      user.admin? || user.guest?
    end

    def create?
      user.admin?
    end
  
    def update?
      user.admin?
    end
  
    def destroy?
      user.admin?
    end
  end
end
