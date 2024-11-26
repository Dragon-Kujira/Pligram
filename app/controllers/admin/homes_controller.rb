class Admin::HomesController < ApplicationController

  def top
    @admin = current_admin  # カレントの管理者データを取得する例
  end
  
end
