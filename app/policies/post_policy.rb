class PostPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :record
    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.present? && user.admin?
    end
  
    def update?
      user.present? && user.admin?
    end
  
    def destroy?
      user.present? && user.admin?
    end

    def view_user_list?
      true
    end
  end
end