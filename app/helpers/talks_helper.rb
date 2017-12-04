module TalksHelper
  def parent_talk(sub_id)
    parent_id = Talk.find(sub_id).from
    @parent_ids << sub_id
    if parent_id.present?
      @parent_ids << parent_id
      parent_talk(parent_id)
    else
      Talk.where(id: @parent_ids).pluck(:topic).join('👨‍👩‍👧‍👦')
    end
  end
end
