module TalksHelper
  def parent_talk(sub_id)
    p parent_id = Talk.find(sub_id).from
    if parent_id.present?
      @parent_ids << parent_id
      parent_talk(parent_id)
    else
      Talk.where(id: @parent_ids).pluck(:topic).reverse.join('．')
    end
  end
end
