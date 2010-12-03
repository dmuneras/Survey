# -*- coding: utf-8 -*-
class FixAspects < ActiveRecord::Migration
  def self.up
    Aspect.find_by_name('Aspectos Estratégicos').update_attributes(:name => 'Aspectos estratégicos')

    aspects = Aspect.all(:order => 'created_at')
    number = 1
    for aspect in aspects do
      aspect.update_attributes(:number => number)
      number += 1
    end
  end

  def self.down
    for aspect in Aspect.all do
      aspect.update_attributes(:number => nil)
    end
  end
end
