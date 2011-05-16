module MicropostsHelper
  def comments_of(micropost)
    Micropost.all(:joins => "INNER JOIN microposts AS parents ON microposts.parent_id = parents.id", 
                    :conditions => "microposts.parent_id = "+micropost.id.to_s,
                    :order => 'microposts.created_at ASC')
  end
end
