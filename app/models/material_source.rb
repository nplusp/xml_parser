# == Schema Information
#
# Table name: material_sources
#
#  id            :integer          not null, primary key
#  url           :string           not null
#  supplier_name :string
#  title         :string
#  episode       :string
#  year          :string
#  duration      :string
#  aspect_ratio  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class MaterialSource < ApplicationRecord
  include ContentFetchingHelper

  validates :url, presence: true, uniqueness: true, url: { no_local: true }
  validates_presence_of :supplier_name, :title, :episode, :year, :duration, :aspect_ratio, on: :create

  audited only: [:supplier_name, :title, :episode, :year, :duration, :aspect_ratio]
end
