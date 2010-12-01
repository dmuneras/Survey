# -*- coding: utf-8 -*-
class AddSubsectors < ActiveRecord::Migration
  def self.up
    Subsector.create(:name => 'Alimentos')
    Subsector.create(:name => 'Mobiliario')
    Subsector.create(:name => 'Plástico')
  end

  def self.down
    Subsector.delete_all
  end
end
