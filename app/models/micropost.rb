# == Schema Information
# Schema version: 20110515180354
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer         default(0)
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :parent_id

  belongs_to :user
  belongs_to :parent, :class_name => "Micropost"
  
  validates :parent_id, :presence => true
  validates :content, :presence => true, :length => {:minimum => 1}
  validate  :valid_size
  validates :user_id, :presence => true
  
  has_many  :microposts, :foreign_key => "parent_id",
                         :dependent => :destroy
  has_many  :comments, :through => :microposts, 
                       :source => :parent

  default_scope :order => 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  scope :posts, where(:parent_id => 0)
  
  def depth
    i=0; 
    p_id = self.parent_id
    while(p_id != 0)
      p_id = Micropost.find(p_id).parent_id;
      i+=1
    end
    errors.add(:id, "Nested comment of depth > 3") if i > 3
    return i
  end
  
  #scope :comments, where("id IN (SELECT micropost.id FROM microposts INNER JOIN microposts AS comments ON microposts.id = comments.parent_id WHERE comments.parent_id = "+self.id.to_s+")")

    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user.id })
    end    
    #def self.from_users_followed_by(user)
    #  followed_ids = user.following.map(&:id).join(", ")
    #  where("user_id IN (#{followed_ids}) OR user_id = ?", user)
    #end
    
    def self.comments_of(micropost)
      where("parent_id = :micropost_id ",{:micropost_id => self.id})
    end
  private
    def valid_size
      errors.add(:content, "Content can't be of size greater than 140") if
        Sanitize.clean(self.content).length > 140
    end
end
